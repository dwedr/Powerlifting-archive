import React, { useState } from "react";
import axios from "axios";

const Ranking: React.FC = () => {
  const [athletes, setAthletes] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const fetchRankingData = async (endpoint: string) => {
    setLoading(true);
    setError("");
    try {
      const response = await axios.get(endpoint);
      setAthletes(response.data);
    } catch (err: any) {
      console.error("Blad przy pobieraniu danych:", err.message);
      setError("Nie udało się pobrać danych rankingu. Spróbuj ponownie.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container mt-4">
      <h2 className="text-center mb-4">Top 100</h2>

      {/* Button Row */}
      <div className="button-row mb-4">
        <button
          className="ranking-button"
          onClick={() =>
            fetchRankingData("http://localhost:3000/api/top-100-athletes")
          }
        >
          Wszyscy
        </button>
        <button
          className="ranking-button"
          onClick={() =>
            fetchRankingData("http://localhost:3000/api/top-100-male-results")
          }
        >
          Mężczyźni
        </button>
        <button
          className="ranking-button"
          onClick={() =>
            fetchRankingData("http://localhost:3000/api/top-100-female-results")
          }
        >
          Kobiety
        </button>
      </div>

      {/* Loading and Error States */}
      {loading && <p className="text-center">Ładowanie danych...</p>}
      {error && <p className="text-danger text-center">{error}</p>}

      {/* Athlete Table */}
      {!loading && !error && athletes.length > 0 && (
        <div className="results mt-4">
          <table className="table table-striped mt-3">
            <thead>
              <tr>
                <th>#</th>
                <th>Imię</th>
                <th>Nazwisko</th>
                <th>Kategoria wiekowa</th>
                <th>Waga</th>
                <th>Wynik IPF</th>
                <th>Total</th>
                <th>Zawody</th>
              </tr>
            </thead>
            <tbody>
              {athletes.map((athlete: any, index: number) => (
                <tr key={index}>
                  <td>{index + 1}</td>
                  <td>{athlete.first_name}</td>
                  <td>{athlete.surname}</td>
                  <td>{athlete.age_category}</td>
                  <td>{athlete.weight}</td>
                  <td>{athlete.ipf_score.toFixed(2)}</td>
                  <td>{athlete.total.toFixed(2)}</td>
                  <td>{athlete.competition_name}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {!loading && !error && athletes.length === 0 && (
        <p className="text-center">Brak wyników do wyświetlenia.</p>
      )}
    </div>
  );
};

export default Ranking;
