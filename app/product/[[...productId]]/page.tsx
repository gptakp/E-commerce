"use client";

import CardDetails from "@/app/Components/cardDetails";
import { useSearchParams } from "next/navigation";
import { useEffect, useState } from "react";
import './productDetails.css'; 
import Image from "../../../public/boypink.jpg";

export default function ProductDetails() {
  const searchParams = useSearchParams();
  const [productId, setProductId] = useState<string | null>('');

  useEffect(() => {
    setProductId(searchParams.get("productId"));
  }, [searchParams.get("productId")]);

  return (
    <div className="product-details-container">
      <div className="product-details">
        {/* Left side - Product Image */}
        <div className="product-image">
          <img src={Image.src} alt="Product Image" />
        </div>

        {/* Right side - Product Info */}
        <div className="product-info">
          <div className="product-details-header">
            <h1>T-Shirt Name 10</h1>
            <p className="product-price">$33.00 – $36.00 & Free Shipping</p>
          </div>

          <div className="product-description">
            <p>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras dapibus
              interdum eros. In blandit velit a lacus laoreet dictum. Maecenas vel
              vulputate nulla. Ut nec enim vel tortor aliquet varius.
            </p>
          </div>

          <div className="product-quantity">
            <p>Quantity:</p>
            <div className="quantity-controls">
              <button>-</button>
              <span>1</span>
              <button>+</button>
            </div>
          </div>

          <button className="add-to-cart-button">Add to Cart</button>

          <div className="product-sku-category">
            <p>SKU: N/A</p>
            <p>Category: Men</p>
          </div>

          <div className="product-details-section">
            <h3>About the Product</h3>
            <p>
              Our T-Shirts are lorem ipsum dolor sit amet, consectetur adipiscing
              elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus
              leo.
            </p>
            <ul>
              <li>100% Cotton</li>
              <li>260gsm</li>
              <li>Breathable Fabric</li>
            </ul>

            <h3>Size & Fit</h3>
            <p>
              Model is wearing size M and is 6'1". Standard fit for a relaxed, easy
              feel.
            </p>

            <h3>Free Delivery & Returns</h3>
            <p>
              Free standard delivery on orders over $60. You can return your order
              for any reason, free of charge, within 30 days.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
