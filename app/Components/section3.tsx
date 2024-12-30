import { useEffect, useState } from "react";
import './section3.css';
import FrontImage from "../../public/front.jpg";
import BackImage from "../../public/back.jpg";

export default function Section3() {
    const [scrollPosition, setScrollPosition] = useState(0);

    // Handle the scroll event
    useEffect(() => {
        const handleScroll = () => {
            setScrollPosition(window.scrollY);
        };

        window.addEventListener('scroll', handleScroll);

        return () => {
            window.removeEventListener('scroll', handleScroll);
        };
    }, []);

    // Calculate rotation based on scroll position
    const rotation = scrollPosition / 2; // Adjust this factor for the desired effect

    return (
        <div className="section3">
            <div className="imageContainer" style={{ transform: `rotateY(${rotation}deg)` }}>
                <div className="frontSide">
                    <img src={FrontImage.src} alt="Front" className="image" />
                    <div className="textOverlay">
                        <h6>New Collection</h6>
                        <h2>Be different in your own way!</h2>
                        <h3>Find your unique style.</h3>
                        <button>Shop Collection</button>
                    </div>
                </div>
                <div className="backSide">
                    <img src={BackImage.src} alt="Back" className="image" />
                </div>
            </div>
        </div>
    );
}
