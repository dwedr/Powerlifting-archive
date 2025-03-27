import React, { useState } from "react";
import axios from "axios";

const Filter2: React.FC = () => {
  const [inputSex, setInputSex] = useState<string>("-");
  const [results, setResults] = useState<
    { country: string; athlete_count: number }[]
  >([]);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    const sexValue = inputSex === "-" ? null : inputSex;

    try {
      const response = await axios.post(
        "http://localhost:3000/api/count-athletes",
        {
          input_sex: sexValue,
        }
      );
      setResults(response.data);
      setError(null);
    } catch (err: any) {
      console.error("Blad przy zliczaniu zawodnikow:", err.message);
      setError("Wystapil blad.");
    }
  };

  return (
    <div className="container mt-4">
      <h3>Ilość zawodników z danego kraju</h3>
      <form onSubmit={handleSubmit} className="filter1-form">
        <div className="filter1-form">
          <label htmlFor="sex">Wybierz płeć:</label>
          <select
            id="sex"
            className="form-select mb-3"
            value={inputSex}
            onChange={(e) => setInputSex(e.target.value)}
          >
            <option value="-">-</option>
            <option value="M">Mężczyzna</option>
            <option value="F">Kobieta</option>
          </select>
        </div>
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
                <th>Kraj</th>
                <th>Ilość</th>
              </tr>
            </thead>
            <tbody>
              {results.map((result, index) => (
                <tr key={index}>
                  <td>{result.country}</td>
                  <td>{result.athlete_count}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default Filter2;
