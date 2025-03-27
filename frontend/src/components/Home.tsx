import React, { useState } from "react";
import Ranking from "./Ranking";
import Filtruj from "./Filtruj";
import Wyszukaj from "./Wyszukaj";

const Home: React.FC = () => {
  const [activeSection, setActiveSection] = useState<string>("");

  const renderContent = () => {
    switch (activeSection) {
      case "ranking":
        return <Ranking />;
      case "filtruj":
        return <Filtruj />;
      case "wyszukaj":
        return <Wyszukaj />;
      default:
        return <p>Wybierz opcję, aby zobaczyć zawartość.</p>;
    }
  };

  return (
    <div className="container mt-5">
      <h1 className="text-center mb-4">Trójbój Siłowy</h1>
      <div className="d-flex justify-content-center mb-4">
        <button
          className="btn btn-secondary mx-2"
          onClick={() => setActiveSection("ranking")}
        >
          Ranking
        </button>
        <button
          className="btn btn-secondary mx-2"
          onClick={() => setActiveSection("filtruj")}
        >
          Filtruj
        </button>
        <button
          className="btn btn-secondary mx-2"
          onClick={() => setActiveSection("wyszukaj")}
        >
          Wyszukaj
        </button>
      </div>

      <div className="content-display">{renderContent()}</div>
    </div>
  );
};

export default Home;
