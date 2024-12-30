import { NextRequest, NextResponse } from 'next/server';
import pool from '../../../lib/db';
import bycrypt from 'bcryptjs';

export async function GET() {
    try {
        const result = await pool.query('SELECT id, first_name, last_name, email, role FROM users');
        const users = result.rows;

        return NextResponse.json(users, { status: 200 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error fetching users: ${error.message}` }, { status: 500 });
    }
}

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const { first_name, last_name, email, password, role } = body;

        if (!first_name) {
            return NextResponse.json({ error: 'first_name is required.' }, { status: 400 })
        }
        if (!last_name) {
            return NextResponse.json({ error: 'last_name is required.' }, { status: 400 })
        }
        if (!email) {
            return NextResponse.json({ error: 'email is required.' }, { status: 400 })
        }
        if (!password) {
            return NextResponse.json({ error: 'password is required.' }, { status: 400 });
        }

        const existingUser = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
        if (existingUser.rows.length > 0) {
            return NextResponse.json({ error: 'Email is already taken.' }, { status: 400 });
        }

        const hashedPassword = await bycrypt.hash(password, 10);

        await pool.query(
            'INSERT INTO users (first_name, last_name, email, password, role, status) VALUES ($1, $2, $3, $4, $5, $6)',
            [first_name, last_name, email, hashedPassword, role || 'customer', 'active']
        );

        return NextResponse.json({ success: true, success_msg: `${role || 'customer'} created successfully.` }, { status: 201 });
    } catch (error: any) {
        console.error(error);
        return NextResponse.json({ error: `Error creating user: ${error.message}` }, { status: 500 });
    }
}
