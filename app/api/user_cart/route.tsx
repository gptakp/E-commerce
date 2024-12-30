import { NextRequest, NextResponse } from 'next/server';
import pool from '../../../lib/db';

export async function GET() {
    try {
        const result = await pool.query('SELECT id, user_id, product_id, quantity FROM shopping_cart');
        const cartItems = result.rows;

        return NextResponse.json(cartItems, { status: 200 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error fetching cart items: ${error.message}` }, { status: 500 });
    }
}

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const { user_id, product_id, quantity } = body;

        if (!user_id) {
            return NextResponse.json({ error: 'user_id is required' }, { status: 400 })
        }
        if (!product_id) {
            return NextResponse.json({ error: 'product_id is required' }, { status: 400 })
        }
        if (!quantity) {
            return NextResponse.json({ error: 'quantity is required' }, { status: 400 })
        }

        const existingUser = await pool.query('SELECT * FROM users WHERE id = $1', [user_id]);
        if (existingUser.rows.length < 0) {
            return NextResponse.json({ error: 'User does not exists.' }, { status: 400 });
        }
        const existingProduct = await pool.query('SELECT * FROM products WHERE id = $1', [user_id]);
        if (existingProduct.rows.length < 0) {
            return NextResponse.json({ error: 'Product does not exists.' }, { status: 400 });
        }

        await pool.query(
            'INSERT INTO shopping_cart (user_id, product_id, quantity) VALUES ($1, $2, $3)',
            [user_id, product_id, quantity]
        );

        return NextResponse.json({ success: true, success_msg: `Product created successfully.` }, { status: 201 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error creating product: ${error.message}` }, { status: 500 });
    }
}
