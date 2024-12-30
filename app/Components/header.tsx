'use client';

import React, { useState, useEffect } from 'react';
import { Layout, Menu, Button, Drawer, Badge, Input, Space } from 'antd';
import { MenuOutlined, ShoppingCartOutlined, SearchOutlined } from '@ant-design/icons';

const { Header, Content, Footer } = Layout;

const App: React.FC = () => {
  const [drawerVisible, setDrawerVisible] = useState(false);
  const [isMobile, setIsMobile] = useState(false);
  const [cartVisible, setCartVisible] = useState(false);  // To toggle shopping cart visibility
  const [cartItems, setCartItems] = useState<number>(3);  // Example cart items count
  const [searchVisible, setSearchVisible] = useState(false);  // To toggle search input visibility
  const [searchText, setSearchText] = useState('');  // To store search input value

  const menuItems = [
    { key: '1', label: 'Home' },
    { key: '2', label: 'Shop' },
    { key: '3', label: 'Men' },
    { key: '4', label: 'Women' },
    { key: '5', label: 'About Us' },
    { key: '6', label: 'Contact' },
  ];

  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth < 800);
    };

    handleResize(); // Set the initial state
    window.addEventListener('resize', handleResize);

    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, []);

  const handleSearch = (value: string) => {
    setSearchText(value);
    console.log('Searching for:', value); // You can handle search here
  };

  return (
    <Layout>
      <Header
        style={{
          position: 'sticky',
          top: 0,
          zIndex: 1,
          width: '100%',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          padding: '0 16px',
          backgroundColor: '#fff', // Set to white background
          color: 'black', // Set text to black
        }}
      >
        {isMobile ? (
          <div style={{ display: 'flex', alignItems: 'center' }}>
            <MenuOutlined
              onClick={() => setDrawerVisible(true)}
              style={{
                fontSize: '24px',
                color: 'black',
                marginRight: '16px',
                cursor: 'pointer',
              }}
            />
            <div style={{ color: 'black', fontSize: '18px', fontWeight: 'bold', textAlign: 'center', flex: 1 }}>
              T-Shirt Store
            </div>
          </div>
        ) : (
          <div style={{ display: 'flex', alignItems: 'center', width: '100%' }}>
            <div style={{ color: 'black', fontSize: '18px', fontWeight: 'bold', textAlign: 'center', flex: 1 }}>
              T-Shirt Store
            </div>
            <Menu
              theme="light" // Light theme so the background is white and text is black
              mode="horizontal"
              items={menuItems}
              className="custom-menu" // Custom class for menu styling
              style={{
                flex: 1,
                justifyContent: 'center',
                backgroundColor: 'white',
                color: 'black', // Ensure the text color of menu items is black
              }}
            />
          </div>
        )}
        {/* Search Icon and Basket Icon */}
        <div style={{ display: 'flex', alignItems: 'center' }}>
          {/* Search Button, only show when search box is not visible */}
          {!searchVisible && (
            <div style={{ marginRight: '24px', marginTop:'10px' }}> {/* Increased margin-right to add space */}
              <SearchOutlined
                style={{ fontSize: '24px', color: 'black', cursor: 'pointer' }}
                onClick={() => setSearchVisible(true)} // Show the search input box
              />
            </div>
          )}

          {/* Search Input, only show when search box is visible */}
          {searchVisible && (
            <Space direction="vertical">
              <Input
                placeholder="Search..."
                onPressEnter={(e) => handleSearch(e.currentTarget.value)}
                style={{ width: 200 }}
              />
            </Space>
          )}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

          {/* Basket Icon */}
          <Badge count={cartItems} showZero>
            <ShoppingCartOutlined
              style={{ fontSize: '24px', color: 'black', cursor: 'pointer' }}
              onClick={() => setCartVisible(!cartVisible)} // Toggle shopping cart visibility
            />
          </Badge>
        </div>
        <Button type="primary" style={{ marginLeft: '16px', backgroundColor: '#fff', color: 'black', borderColor: '#000' }}>
          Login
        </Button>
      </Header>

      {/* Drawer for Cart Items */}
      <Drawer
        title="Shopping Cart"
        placement="right"
        onClose={() => setCartVisible(false)}
        visible={cartVisible}
      >
        <div>
          <p>Your Cart Items:</p>
          {/* Here you can map over cart items and display them */}
          <p>Item 1</p>
          <p>Item 2</p>
          <p>Item 3</p>
        </div>
      </Drawer>

      <Drawer
        title="Menu"
        placement="left"
        onClose={() => setDrawerVisible(false)}
        visible={drawerVisible}
      >
        <Menu
          mode="vertical"
          items={menuItems}
          theme="light"
          className="custom-menu" // Custom class for drawer menu styling
          style={{ border: 'none', backgroundColor: '#fff', color: '#000' }}
        />
      </Drawer>
    </Layout>
  );
};

export default App;
