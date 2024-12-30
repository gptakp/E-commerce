import { NextRequest, NextResponse } from 'next/server';
import pool from '../../../lib/db';

export async function GET(request: NextRequest) {
    try {
        const url = new URL(request.url);
        const idParam = url.searchParams.get('id');  // Retrieve 'id' parameter from the query string

        let productsResult;

        // If 'id' is provided, fetch a single product by id
        if (idParam) {
            productsResult = await pool.query(`
                SELECT p.id AS product_id, p.name, p.description, p.image_url,
                    pv.id AS variant_id, pv.stock_quantity, pv.price, pv.sku, pv.image_url AS variant_image_url,
                    at.name AS attribute_type, av.value AS attribute_value
                FROM products p
                LEFT JOIN product_variants pv ON p.id = pv.product_id
                LEFT JOIN product_variant_attributes pva ON pv.id = pva.product_variant_id
                LEFT JOIN attribute_values av ON pva.attribute_value_id = av.id
                LEFT JOIN attribute_types at ON av.attribute_type_id = at.id
                WHERE p.id = $1
            `, [idParam]);
        } else {
            // If no 'id' is provided, fetch all products
            productsResult = await pool.query(`
                SELECT p.id AS product_id, p.name, p.description, p.image_url,
                    pv.id AS variant_id, pv.stock_quantity, pv.price, pv.sku, pv.image_url AS variant_image_url,
                    at.name AS attribute_type, av.value AS attribute_value
                FROM products p
                LEFT JOIN product_variants pv ON p.id = pv.product_id
                LEFT JOIN product_variant_attributes pva ON pv.id = pva.product_variant_id
                LEFT JOIN attribute_values av ON pva.attribute_value_id = av.id
                LEFT JOIN attribute_types at ON av.attribute_type_id = at.id
            `);
        }

        const products: any = {};

        productsResult.rows.forEach(row => {
            const { product_id, name, description, image_url, variant_id, stock_quantity, sku, price, variant_image_url, attribute_type, attribute_value } = row;

            if (!products[product_id]) {
                products[product_id] = {
                    id: product_id,
                    name: name,
                    description: description,
                    image_url: image_url,
                    variants: [],
                };
            }

            if (variant_id) {
                const existingVariant = products[product_id].variants.find((v: any) => v.id === variant_id);
                if (!existingVariant) {
                    products[product_id].variants.push({
                        id: variant_id,
                        stock_quantity: stock_quantity,
                        price: price,
                        sku: sku,
                        image_url: variant_image_url || null,
                        attributes: []
                    });
                }

                if (attribute_type && attribute_value) {
                    const variant = products[product_id].variants.find((v: any) => v.id === variant_id);
                    if (variant) {
                        variant.attributes.push({
                            attribute_type: attribute_type,
                            attribute_value: attribute_value
                        });
                    }
                }
            }
        });

        const formattedProducts = Object.values(products).map((product: any) => {
            return {
                id: product.id,
                name: product.name,
                description: product.description,
                image_url: product.image_url || null,
                variants: product.variants
            };
        });

        // If an ID was provided, return only that product, otherwise return all products
        if (idParam) {
            // Return only the first matching product if there is an id
            return NextResponse.json({ product: formattedProducts[0] || null }, { status: 200 });
        }

        return NextResponse.json({ products: formattedProducts }, { status: 200 });

    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error fetching products: ${error.message}` }, { status: 500 });
    }
}

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const { name, description, variants, sku, price, stock_quantity } = body;

        if (!name || !description) {
            return NextResponse.json({ error: 'Name and description are required for the product.' }, { status: 400 });
        }

        const productResult = await pool.query(
            'INSERT INTO products (name, description) VALUES ($1, $2) RETURNING id',
            [name, description]
        );
        const productId = productResult.rows[0].id;

        if (variants && variants.length > 0) {
            for (let variant of variants) {
                const { attributes, stock_quantity, price, image_url, sku: variantSku } = variant;

                if (!variantSku || !price || !stock_quantity) {
                    return NextResponse.json({ error: 'SKU, price, and stock_quantity are required for each variant.' }, { status: 400 });
                }

                const variantSkuCheck = await pool.query(
                    'SELECT id FROM product_variants WHERE sku = $1',
                    [variantSku]
                );
                if (variantSkuCheck.rows.length > 0) {
                    return NextResponse.json({ error: `Variant SKU ${variantSku} is already in use.` }, { status: 400 });
                }

                const variantResult = await pool.query(
                    'INSERT INTO product_variants (product_id, stock_quantity, price, image_url, sku) VALUES ($1, $2, $3, $4, $5) RETURNING id',
                    [productId, stock_quantity, price, image_url, variantSku]
                );
                const variantId = variantResult.rows[0].id;

                for (let attr of attributes) {
                    const { attribute_type, attribute_value } = attr;

                    const attributeTypeResult = await pool.query(
                        'SELECT id FROM attribute_types WHERE name = $1',
                        [attribute_type]
                    );
                    if (attributeTypeResult.rows.length === 0) {
                        return NextResponse.json({ error: `Attribute type ${attribute_type} not found.` }, { status: 400 });
                    }
                    const attributeTypeId = attributeTypeResult.rows[0].id;

                    const attributeValueResult = await pool.query(
                        'SELECT id FROM attribute_values WHERE attribute_type_id = $1 AND value = $2',
                        [attributeTypeId, attribute_value]
                    );
                    let attributeValueId: number;

                    if (attributeValueResult.rows.length === 0) {
                        const insertAttrValueResult = await pool.query(
                            'INSERT INTO attribute_values (attribute_type_id, value) VALUES ($1, $2) RETURNING id',
                            [attributeTypeId, attribute_value]
                        );
                        attributeValueId = insertAttrValueResult.rows[0].id;
                    } else {
                        attributeValueId = attributeValueResult.rows[0].id;
                    }

                    await pool.query(
                        'INSERT INTO product_variant_attributes (product_variant_id, attribute_value_id) VALUES ($1, $2)',
                        [variantId, attributeValueId]
                    );
                }
            }
        } else {
            if (!sku || !price || !stock_quantity) {
                return NextResponse.json({
                    error: 'SKU, price, and stock_quantity are required for products without variants.'
                }, { status: 400 });
            }

            await pool.query(
                'INSERT INTO product_variants (product_id, stock_quantity, price, sku) VALUES ($1, $2, $3, $4)',
                [productId, stock_quantity, price, sku]
            );
        }

        return NextResponse.json({ success: true, message: 'Product created successfully.' }, { status: 201 });

    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error creating product: ${error.message}` }, { status: 500 });
    }
}

export async function PUT(request: NextRequest) {
    try {
        const body = await request.json();
        const { id, name, description, variants, sku, price, stock_quantity } = body;

        if (!id || !name || !description) {
            return NextResponse.json({ error: 'Name, description, and product ID are required.' }, { status: 400 });
        }

        const productResult = await pool.query(
            'SELECT id FROM products WHERE id = $1',
            [id]
        );
        if (productResult.rows.length === 0) {
            return NextResponse.json({ error: 'Product not found.' }, { status: 404 });
        }

        await pool.query(
            'UPDATE products SET name = $1, description = $2 WHERE id = $3',
            [name, description, id]
        );

        if (variants && variants.length > 0) {
            for (let variant of variants) {
                const { attributes, stock_quantity, price, image_url, sku: variantSku } = variant;

                if (!variantSku || !price || !stock_quantity) {
                    return NextResponse.json({ error: 'SKU, price, and stock_quantity are required for each variant.' }, { status: 400 });
                }

                const variantSkuCheck = await pool.query(
                    'SELECT id FROM product_variants WHERE sku = $1 AND product_id != $2',
                    [variantSku, id]
                );

                if (variantSkuCheck.rows.length > 0) {
                    return NextResponse.json({ error: `Variant SKU ${variantSku} is already in use for another variant.` }, { status: 400 });
                }

                const attributeConditions = attributes.map((attr: any) =>
                    `(at.name = '${attr.attribute_type}' AND av.value = '${attr.attribute_value}')`
                ).join(' AND ');

                const existingVariant = await pool.query(
                    `SELECT pv.id FROM product_variants pv
                    JOIN product_variant_attributes pva ON pv.id = pva.product_variant_id
                    JOIN attribute_values av ON pva.attribute_value_id = av.id
                    JOIN attribute_types at ON av.attribute_type_id = at.id
                    WHERE pv.product_id = $1 AND ${attributeConditions}`,
                    [id]
                );

                if (existingVariant.rows.length > 0) {
                    const variantId = existingVariant.rows[0].id;

                    const variantSkuCheck = await pool.query(
                        'SELECT id FROM product_variants WHERE sku = $1 AND id != $2',
                        [variantSku, variantId]
                    );
                    if (variantSkuCheck.rows.length > 0) {
                        return NextResponse.json({ error: 'Variant SKU must be unique.' }, { status: 400 });
                    }

                    await pool.query(
                        'UPDATE product_variants SET stock_quantity = $1, price = $2, image_url = $3, sku = $4 WHERE id = $5',
                        [stock_quantity, price, image_url, variantSku, variantId]
                    );

                } else {
                    console.log(`Variant with attributes ${JSON.stringify(attributes)} not found for the product, skipping update.`);
                }
            }
        } else {
            if (!sku || !price || !stock_quantity) {
                return NextResponse.json({
                    error: 'SKU, price, and stock_quantity are required for products without variants.'
                }, { status: 400 });
            }

            await pool.query(
                'UPDATE product_variants SET stock_quantity = $1, price = $2, sku = $3 WHERE product_id = $4',
                [stock_quantity, price, sku, id]
            );
        }

        return NextResponse.json({ success: true, message: 'Product updated successfully.' }, { status: 200 });

    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error updating product: ${error.message}` }, { status: 500 });
    }
}
