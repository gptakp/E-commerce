import { NextRequest, NextResponse } from 'next/server';
import pool from '../../../lib/db';

export async function GET() {
    try {
        const result = await pool.query('SELECT id, code, discount_value, valid_from, valid_until, status FROM coupons');
        const coupons = result.rows;

        return NextResponse.json(coupons, { status: 200 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error fetching coupons: ${error.message}` }, { status: 500 });
    }
}

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const { code, discount_value, valid_from, valid_until, status } = body;

        if (!code) {
            return NextResponse.json({ error: 'code is required' }, { status: 400 })
        }
        if (!discount_value) {
            return NextResponse.json({ error: 'discount_value is required' }, { status: 400 })
        }
        if (!valid_from) {
            return NextResponse.json({ error: 'valid_from is required' }, { status: 400 })
        }
        if (!valid_until) {
            return NextResponse.json({ error: 'valid_until is required' }, { status: 400 })
        }
        if (!status) {
            return NextResponse.json({ error: 'status is required' }, { status: 400 })
        }

        const existingCategory = await pool.query('SELECT * FROM coupons WHERE code = $1', [code]);
        if (existingCategory.rows.length > 0) {
            return NextResponse.json({ error: 'Coupon already exists.' }, { status: 400 });
        }

        await pool.query(
            'INSERT INTO coupons (code, discount_value, valid_from, valid_until, status) VALUES ($1, $2, $3, $4)',
            [code, discount_value, valid_from, valid_until, status]
        );

        return NextResponse.json({ success: true, success_msg: `${code} created successfully.` }, { status: 201 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error creating coupon: ${error.message}` }, { status: 500 });
    }
}
