import pool from '@/lib/db';
import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
    try {
        const url = new URL(request.url);
        const idParam = url.searchParams.get('id');  // Retrieve 'id' parameter from the query string

        if (idParam) {
            // If 'id' parameter exists, fetch a single attribute type by id
            const attributeTypeResult = await pool.query(
                'SELECT id, name FROM attribute_types WHERE id = $1',
                [idParam]
            );

            if (attributeTypeResult.rows.length === 0) {
                return NextResponse.json({ error: `Attribute type with id ${idParam} not found.` }, { status: 404 });
            }

            const attributeType = attributeTypeResult.rows[0];
            const attributeValuesResult = await pool.query(
                'SELECT value FROM attribute_values WHERE attribute_type_id = $1',
                [attributeType.id]
            );

            const attributeValues = attributeValuesResult.rows.map(row => row.value);

            return NextResponse.json({
                success: true,
                attribute: {
                    attribute_type: attributeType.name,
                    values: attributeValues
                }
            }, { status: 200 });

        } else {
            // If 'id' parameter does not exist, fetch all attribute types and values
            const attributeTypesResult = await pool.query(
                'SELECT id, name FROM attribute_types'
            );

            if (attributeTypesResult.rows.length === 0) {
                return NextResponse.json({ error: 'No attribute types found.' }, { status: 404 });
            }

            const attributeTypesWithValues = await Promise.all(
                attributeTypesResult.rows.map(async (attributeTypeRow) => {
                    const attributeTypeId = attributeTypeRow.id;
                    const attributeValuesResult = await pool.query(
                        'SELECT value FROM attribute_values WHERE attribute_type_id = $1',
                        [attributeTypeId]
                    );

                    const attributeValues = attributeValuesResult.rows.map(row => row.value);

                    return {
                        attribute_type: attributeTypeRow.name,
                        values: attributeValues
                    };
                })
            );

            return NextResponse.json({
                success: true,
                attributes: attributeTypesWithValues
            }, { status: 200 });
        }

    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error fetching attributes: ${error.message}` }, { status: 500 });
    }
}

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const { attribute_type, attribute_values } = body;

        if (!attribute_type || !attribute_values || attribute_values.length === 0) {
            return NextResponse.json({ error: 'Both attribute_type and attribute_values are required.' }, { status: 400 });
        }

        let attributeTypeResult = await pool.query(
            'SELECT id FROM attribute_types WHERE name = $1',
            [attribute_type]
        );

        let attributeTypeId;
        if (attributeTypeResult.rows.length === 0) {
            const insertAttributeTypeResult = await pool.query(
                'INSERT INTO attribute_types (name) VALUES ($1) RETURNING id',
                [attribute_type]
            );
            attributeTypeId = insertAttributeTypeResult.rows[0].id;
        } else {
            attributeTypeId = attributeTypeResult.rows[0].id;
        }

        const insertAttributeValuesPromises = attribute_values.map(async (value: string) => {
            const attributeValueResult = await pool.query(
                'SELECT id FROM attribute_values WHERE attribute_type_id = $1 AND value = $2',
                [attributeTypeId, value]
            );

            if (attributeValueResult.rows.length === 0) {
                await pool.query(
                    'INSERT INTO attribute_values (attribute_type_id, value) VALUES ($1, $2)',
                    [attributeTypeId, value]
                );
            }
        });

        await Promise.all(insertAttributeValuesPromises);

        return NextResponse.json({ success: true, message: 'Attribute type and values added successfully.' }, { status: 201 });

    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error adding attribute: ${error.message}` }, { status: 500 });
    }
}

export async function PUT(request: NextRequest) {
    try {
        const body = await request.json();
        const { attribute_type, attribute_values } = body;

        if (!attribute_type || !attribute_values || attribute_values.length === 0) {
            return NextResponse.json({ error: 'Both attribute_type and attribute_values are required.' }, { status: 400 });
        }

        const attributeTypeResult = await pool.query(
            'SELECT id FROM attribute_types WHERE name = $1',
            [attribute_type]
        );

        if (attributeTypeResult.rows.length === 0) {
            return NextResponse.json({ error: `Attribute type ${attribute_type} not found.` }, { status: 404 });
        }

        const attributeTypeId = attributeTypeResult.rows[0].id;

        const updateAttributeValuesPromises = attribute_values.map(async (value: string) => {
            const attributeValueResult = await pool.query(
                'SELECT id FROM attribute_values WHERE attribute_type_id = $1 AND value = $2',
                [attributeTypeId, value]
            );

            if (attributeValueResult.rows.length === 0) {
                await pool.query(
                    'INSERT INTO attribute_values (attribute_type_id, value) VALUES ($1, $2)',
                    [attributeTypeId, value]
                );
            } else {
                // If the value exists, you can choose to update it if needed
                // (Optional logic for updating existing values, or you can leave it out)
                // await pool.query('UPDATE attribute_values SET value = $2 WHERE id = $1', [attributeValueResult.rows[0].id, value]);
            }
        });

        await Promise.all(updateAttributeValuesPromises);

        return NextResponse.json({ success: true, message: 'Attribute values updated successfully.' }, { status: 200 });

    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error updating attribute type and values: ${error.message}` }, { status: 500 });
    }
}
