import Card from "./card";
import Image from "../../public/boypink.jpg";
import Image1 from "../../public/girlwhite.jpg";
import Image3 from "../../public/boywhite.jpg";
import Image4 from "../../public/girlgrey.jpg";

export default function Section1() {
    return (
        <div
            style={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                padding: '40px',
            }}
        >
            <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                <div>Summer Collection</div>
                <div style={{ fontSize: '30px', fontWeight: 'bold' }}>
                    Popular T-Shirts
                </div>
            </div>
            <div
                style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
                    gap: '20px',
                    width: '100%',
                    maxWidth: '1600px',
                }}
            >
                <Card data={{ productId: '1', image: Image.src }} />
                <Card data={{ productId: '2', image: Image1.src }} />
                <Card data={{ productId: '3', image: Image3.src }} />
                <Card data={{ productId: '4', image: Image4.src }} />
            </div>
        </div>
    );
}
