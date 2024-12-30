import { Card, Row, Col, Typography } from 'antd';
import Image from "../../public/boyblackhalf.jpg";
import Image1 from "../../public/boyblackfull.png";

const { Title } = Typography;

export default function Section2() {
    return (
        <div style={{ padding: '40px', textAlign: 'center' }}>
            <Title level={3}>Summer Collection</Title>
            <Title level={2}>Popular T-Shirts</Title>

            <Row gutter={[16, 16]} justify="center">
                <Col xs={24} sm={12} md={8} lg={6}>
                    <Card style={{border:"1px solid black"}}
                        hoverable
                        cover={<img alt="Boy Black Half" src={Image.src} />}
                    >
                        <Card.Meta title="Boy Black Half T-Shirt" />
                    </Card>
                    <h5> Men</h5>
                    <h2 style={{ fontSize: '40px', fontWeight: '900' }}>The base collection - Ideal every day.</h2>
                    <button
                        style={{
                            background: 'black',
                            color: '#fff',
                            width: '150px',
                            height: '40px',
                            border: 'none',
                            borderRadius: '5px',
                            cursor: 'pointer',
                        }}
                    >
                        Shop
                    </button>

                </Col>
                <Col xs={24} sm={12} md={8} lg={6}>
                    <Card style={{border:"1px solid black"}}
                        hoverable
                        cover={<img alt="Boy Black Full" src={Image1.src} />}
                    >
                        <Card.Meta title="Boy Black Full T-Shirt" />
                    </Card>
                </Col>
            </Row>
        </div>
    );
}
