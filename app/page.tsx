'use client'

import Layout from "./Components/layout";
import Section1 from "./Components/section1";
import Section2 from "./Components/section2";
import Section3 from "./Components/section3";
import Sectionmain from "./Components/sectionmain";

export default function Home() {
  return (
    <>
    <link
    href="https://cdn.jsdelivr.net/npm/boxicons@2.1.4/css/boxicons.min.css"
    rel="stylesheet"
/>

      <Layout>
        <div>
          <Sectionmain />
          <Section1 />
          <Section2 />
          <Section3 />
        </div>
      </Layout>
    </>
  );
}
