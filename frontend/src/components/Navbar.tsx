import React from "react";
import { Link } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.css";
interface NavbarProps {
  user: { loggedIn: boolean; role: number | null };
  onLogout: () => void;
}

const Navbar: React.FC<NavbarProps> = ({ user, onLogout }) => {
  return (
    <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
      <Link className="navbar-brand" to="/">
        Strona Główna
      </Link>
      <div className="collapse navbar-collapse">
        <ul className="navbar-nav ml-auto">
          {user.loggedIn ? (
            <>
              <li className="nav-item">
                <Link
                  className="nav-link"
                  to={
                    user.role === 0
                      ? "/page1"
                      : user.role === 1
                      ? "/page2"
                      : "/page3"
                  }
                >
                  Dashboard
                </Link>
              </li>
              <li className="nav-item">
                <button className="btn btn-link nav-link" onClick={onLogout}>
                  Wyloguj
                </button>
              </li>
            </>
          ) : (
            <li className="nav-item">
              <Link className="nav-link" to="/login">
                Zaloguj
              </Link>
            </li>
          )}
        </ul>
      </div>
    </nav>
  );
};

export default Navbar;
