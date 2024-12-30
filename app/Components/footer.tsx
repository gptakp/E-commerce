'use client'
import React from "react";
import { Layout, Row, Col, Typography, Space } from "antd";
import './footer.css';

const { Text, Title } = Typography;

export default function Footer() {
    return (
        <Layout.Footer className="footer">
            <div className="footer-content">
                <Row gutter={[16, 16]}>
                    <Col xs={24} sm={8}>
                        <div className="footer-section">
                            <Title level={4}>About Us</Title>
                            <Text>
                                We are a company committed to delivering the best products and services to our customers.
                            </Text>
                        </div>
                    </Col>
                    <Col xs={24} sm={8}>
                        <div className="footer-section">
                            <Title level={4}>Quick Links</Title>
                            <ul>
                                <li><a href="#home">Home</a></li>
                                <li><a href="#services">Services</a></li>
                                <li><a href="#contact">Contact</a></li>
                            </ul>
                        </div>
                    </Col>
                    <Col xs={24} sm={8}>
                        <div className="footer-section">
                            <Title level={4}>Follow Us</Title>
                            <Space size="large">
                                <a href="#facebook">Facebook</a>
                                <a href="#twitter">Twitter</a>
                                <a href="#instagram">Instagram</a>
                            </Space>
                        </div>
                    </Col>
                </Row>
            </div>
            <div className="footer-bottom">
                <Row justify="center">
                    <Col>
                        <Text>&copy; 2024 Your Company. All rights reserved.</Text>
                    </Col>
                </Row>
            </div>
        </Layout.Footer>
    );
}
