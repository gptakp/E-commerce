import { NextRequest, NextResponse } from 'next/server';
import pool from '../../../lib/db';

export async function GET() {
    try {
        const result = await pool.query('SELECT id, product_id, image_url FROM product_images');
        const productImages = result.rows;

        return NextResponse.json(productImages, { status: 200 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error fetching product images: ${error.message}` }, { status: 500 });
    }
}

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const { product_id, image_url } = body;

        if (!product_id) {
            return NextResponse.json({ error: 'product_name is required' }, { status: 400 })
        }
        if (!image_url) {
            return NextResponse.json({ error: 'image_url is required' }, { status: 400 })
        }

        const existingCategory = await pool.query('SELECT * FROM products WHERE id = $1', [product_id]);
        if (existingCategory.rows.length < 0) {
            return NextResponse.json({ error: 'Product does not exists.' }, { status: 400 });
        }

        await pool.query(
            'INSERT INTO product_images (product_id, image_url) VALUES ($1, $2)',
            [existingCategory.rows[0].id, image_url]
        );

        return NextResponse.json({ success: true, success_msg: `Product image added successfully.` }, { status: 201 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error creating product image: ${error.message}` }, { status: 500 });
    }
}
