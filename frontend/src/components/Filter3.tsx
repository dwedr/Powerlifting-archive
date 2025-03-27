import React, { useState } from "react";
import axios from "axios";

const Filter3: React.FC = () => {
  const [competitionType, setCompetitionType] = useState<string>("Raw");
  const [results, setResults] = useState<
    { federation_name: string; competition_count: number }[]
  >([]);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const response = await axios.post(
        "http://localhost:3000/api/count-federation-competitions",
        {
          competition_type_input: competitionType,
        }
      );
      setResults(response.data);
      setError(null);
    } catch (err: any) {
      console.error("Blad przy zliaczniu dla federacji:", err.message);
      setError("Wystapil blad.");
    }
  };

  return (
    <div className="container mt-4">
      <h3>Ilość zawodów zoorganizowanych przez daną federacje</h3>
      <form onSubmit={handleSubmit} className="mb-3">
        <label htmlFor="competitionType" className="filter1-form">
          Wybierz rodzaj zawodów:
        </label>
        <select
          id="competitionType"
          className="form-select mb-3"
          value={competitionType}
          onChange={(e) => setCompetitionType(e.target.value)}
        >
          <option value="Raw">Raw</option>
          <option value="Bandaże">Bandaże</option>
          <option value="Raw + Bandaże">Raw + Bandaże</option>
          <option value="Jednowarstwowy">Jednowarstwowy</option>
          <option value="Wielowarstwowy">Wielowarstwowy</option>
          <option value="Nielimitowany">Nielimitowany</option>
        </select>
        <button type="submit" className="btn btn-primary">
          Filtruj
        </button>
      </form>

      {error && <div className="alert alert-danger">{error}</div>}

      {results.length > 0 && (
        <div className="results mt-4">
          <h4>Results</h4>
          <table className="table table-striped">
            <thead>
              <tr>
                <th>Federacja</th>
                <th>Ilość</th>
              </tr>
            </thead>
            <tbody>
              {results.map((result, index) => (
                <tr key={index}>
                  <td>{result.federation_name}</td>
                  <td>{result.competition_count}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default Filter3;
