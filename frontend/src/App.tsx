import React, { useState } from "react";
import { Routes, Route, useNavigate } from "react-router-dom";
import Navbar from "./components/Navbar";
import Login from "./components/Login";
import Home from "./components/Home";
import Page1 from "./components/Page1";
import Page2 from "./components/Page2";
import Page3 from "./components/Page3";
import "./App.css";

function App() {
  const [user, setUser] = useState({ loggedIn: false, role: null }); // Track login state and role
  const navigate = useNavigate();

  // Handle logout
  const handleLogout = () => {
    sessionStorage.clear();
    setUser({ loggedIn: false, role: null });
    navigate("/");
  };

  // Handle login
  const handleLogin = (role: any) => {
    setUser({ loggedIn: true, role });
    if (role === 0) navigate("/page1");
    else if (role === 1) navigate("/page2");
    else if (role === 2) navigate("/page3");
  };

  return (
    <>
      <Navbar user={user} onLogout={handleLogout} />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login onLogin={handleLogin} />} />
        <Route path="/page1" element={<Page1 />} />
        <Route path="/page2" element={<Page2 />} />
        <Route path="/page3" element={<Page3 />} />
      </Routes>
    </>
  );
}

export default App;
