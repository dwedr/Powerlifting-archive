import React, { useState } from "react";
import axios from "axios";
import "./Login.css"; // Import the CSS for styling

interface LoginProps {
  onLogin: (role: number) => void;
}

const Login: React.FC<LoginProps> = ({ onLogin }) => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    try {
      const response = await axios.post("http://localhost:3000/login", {
        username,
        password,
      });

      const { token, role } = response.data;
      sessionStorage.setItem("token", token);
      sessionStorage.setItem("role", role.toString());
      onLogin(role); // Notify App about the login
    } catch (err: any) {
      setError("Nieprawidłowa nazwa użytkownika lub hasło.");
    }
  };

  return (
    <div className="login-container">
      <form onSubmit={handleSubmit} className="login-form">
        <h2 className="login-title">Zaloguj się</h2>
        {error && <p className="error-message">{error}</p>}
        <div className="form-group">
          <label htmlFor="username">Nazwa użytkownika</label>
          <input
            type="text"
            id="username"
            className="form-control"
            placeholder="Wprowadź nazwę użytkownika"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label htmlFor="password">Hasło</label>
          <input
            type="password"
            id="password"
            className="form-control"
            placeholder="Wprowadź hasło"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
        </div>
        <button type="submit" className="btn btn-primary btn-block">
          Zaloguj
        </button>
      </form>
    </div>
  );
};

export default Login;
