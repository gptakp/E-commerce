import React from "react";
import { Button } from "antd";
import "./sectionmain.css";

export default function Sectionmain() {
  return (
    <div className="backe">
      <div className="imageContainer">
        <img
          src="/women.png"
          alt="Shop Collection"
          className="image"
        />
        <div className="textContainer">
          <h4>Women</h4>
          <h1>
            Slick. <br /> Modern. <br /> Awesome.
          </h1>
        </div>
        <Button type="primary" className="button">Shop Collection</Button>
      </div>
    </div>
  );
}
