import { useRouter } from "next/navigation";
import "./card.css";

export default function Card({ data }: any) {
    const navigate = useRouter();

    const createQueryString = (name: string, value: string) => {
        const params = new URLSearchParams();
        params.set(name, value);

        return params.toString();
    };

    return (
        <div className="card">
            {/* Icon Container */}
            <div className="icon-container">
                {/* Basket Icon */}
                <i
                    className="bx bx-cart"
                    title="Add to Cart"
                    onClick={() => navigate.push("/product")}
                ></i>

                {/* Quick View Icon */}
                <i
                    className="bx bx-show-alt"
                    title="Quick View"
                    onClick={() => alert("Quick View of the product!")}
                ></i>
            </div>

            {/* Image Container */}
            <div
                className="image-container"
                onClick={() =>
                    navigate.push(`/product?${createQueryString("productId", data?.productId)}`)
                }
            >
                <img className="card-image" src={data?.image} alt="Product" />
            </div>

            {/* Card Details */}
            <div className="card-category">MEN</div>
            <div className="card-title">T_SHIRT 1</div>
            <div className="card-price">$33-$35</div>
            <div className="card-colors">
                <div className="color" style={{ background: "black" }} />
                <div className="color" style={{ background: "red" }} />
                <div className="color" style={{ background: "blue" }} />
            </div>
            <div className="card-sizes">
                <div className="size">S</div>
                <div className="size">M</div>
                <div className="size">L</div>
                <div className="size">XL</div>
            </div>
        </div>
    );
}
