import { NextRequest, NextResponse } from 'next/server';
import pool from '../../../lib/db';

export async function GET() {
    try {
        const result = await pool.query('SELECT id, name, description FROM categories');
        const categories = result.rows;

        return NextResponse.json(categories, { status: 200 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error fetching categories: ${error.message}` }, { status: 500 });
    }
}

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const { name, description } = body;

        if (!name) {
            return NextResponse.json({ error: 'name is required.' }, { status: 400 })
        }
        if (!description) {
            return NextResponse.json({ error: 'description is required.' }, { status: 400 })
        }

        const existingCategory = await pool.query('SELECT * FROM categories WHERE name = $1', [name]);
        if (existingCategory.rows.length > 0) {
            return NextResponse.json({ error: 'Category is already exists.' }, { status: 400 });
        }

        await pool.query(
            'INSERT INTO categories (name, description) VALUES ($1, $2)',
            [name, description]
        );

        return NextResponse.json({ success: true, success_msg: `${name} created successfully.` }, { status: 201 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error creating category: ${error.message}` }, { status: 500 });
    }
}

export async function PUT(request: NextRequest) {
    try {
        const body = await request.json();
        const { name, description, id } = body;

        if (!id) {
            return NextResponse.json({ error: 'id is required.' }, { status: 400 })
        }
        else {
            const categoryExists = await pool.query('SELECT * FROM categories WHERE id = $1', [id]);

            if (categoryExists.rows.length === 0) {
                return NextResponse.json({ error: 'Category is already exists.' }, { status: 400 });
            }
            else {
                if (!name) {
                    return NextResponse.json({ error: 'name is required.' }, { status: 400 })
                }
                if (!description) {
                    return NextResponse.json({ error: 'description is required.' }, { status: 400 })
                }

                await pool.query(
                    'UPDATE categories SET name = $1, description = $2 WHERE id = $3',
                    [name, description, id]
                );

                return NextResponse.json({ success: true, success_msg: `${name} updated successfully.` }, { status: 201 });
            }
        }

    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error updating category: ${error.message}` }, { status: 500 });
    }
}
