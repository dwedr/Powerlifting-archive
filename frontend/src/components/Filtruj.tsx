import React, { useState } from "react";
import "./Filtruj.css";
import Filter1 from "./Filter1";
import Filter2 from "./Filter2";
import Filter3 from "./Filter3";

const Filtruj: React.FC = () => {
  const [activeFilter, setActiveFilter] = useState<number | null>(null);

  const handleFilterSelection = (filterId: number) => {
    setActiveFilter(filterId);
  };

  return (
    <div className="filtruj-container">
      <h2 className="filtruj-heading">Opcje</h2>

      {/* Filter Buttons */}
      <div className="filtruj-options">
        <button
          className={`filtruj-button ${activeFilter === 1 ? "active" : ""}`}
          onClick={() => handleFilterSelection(1)}
        >
          Filtruj zawodników
        </button>
        <button
          className={`filtruj-button ${activeFilter === 2 ? "active" : ""}`}
          onClick={() => handleFilterSelection(2)}
        >
          Filtruj kraje
        </button>
        <button
          className={`filtruj-button ${activeFilter === 3 ? "active" : ""}`}
          onClick={() => handleFilterSelection(3)}
        >
          Filtruj zawody
        </button>
      </div>

      {/* Display corresponding filter form */}
      <div className="filter-form">
        {activeFilter === 1 && <Filter1 />}
        {activeFilter === 2 && <Filter2 />}
        {activeFilter === 3 && <Filter3 />}
      </div>
    </div>
  );
};

export default Filtruj;
