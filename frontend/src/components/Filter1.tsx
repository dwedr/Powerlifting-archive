import React, { useState, useEffect } from "react";
import axios from "axios";

const Filter1: React.FC = () => {
  const [formData, setFormData] = useState({
    comp_type: "",
    age: "",
    weight_class: "",
    sex_input: "",
    limit_amount: "",
  });
  const [weightCategories, setWeightCategories] = useState<string[]>([]);
  const [resultData, setResultData] = useState<any[]>([]);


  useEffect(() => {
    const fetchWeightCategories = async () => {
      try {
        const response = await axios.get(
          "http://localhost:3000/api/get-distinct-weight-categories"
        );
        setWeightCategories(
          response.data.map(
            (item: { weight_category: string }) => item.weight_category
          )
        );
      } catch (err: unknown) {
        if (axios.isAxiosError(err)) {
          console.error(
            "Blad przy pobieraniu kategori wagowej:",
            err.response?.data?.message || err.message
          );
        } else {
          console.error("Wystapil blad:", err);
        }
      }
    };

    fetchWeightCategories();
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };


  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const response = await axios.post(
        "http://localhost:3000/api/fetch-athlete-details",
        formData
      );
      setResultData(response.data); 
    } catch (err: unknown) {
      if (axios.isAxiosError(err)) {
        console.error(
          "Blad przy pobieraniu danych zawodnika:",
          err.response?.data?.message || err.message
        );
      } else {
        console.error("Wystapil blad:", err);
      }
    }
  };

  return (
    <div className="filter1-container">
      <h3>Specyfikacje</h3>
      <form onSubmit={handleSubmit} className="filter1-form">
        <div className="form-group">
          <label htmlFor="comp_type">Typ zawodów:</label>
          <select
            name="comp_type"
            id="comp_type"
            className="form-control"
            onChange={handleChange}
            required
          >
            <option value="">Wybierz...</option>
            <option value="Raw">Raw</option>
            <option value="Bandaże">Bandaże</option>
            <option value="Raw + Bandaże">Raw + Bandaże</option>
            <option value="Jednowarstwowy">Jednowarstwowy</option>
            <option value="Wielowarstwowy">Wielowarstwowy</option>
            <option value="Nielimitowany">Nielimitowany</option>
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="age">Kategoria wiekowa:</label>
          <select
            name="age"
            id="age"
            className="form-control"
            onChange={handleChange}
            required
          >
            <option value="">Wybierz...</option>
            <option value="Youth">Youth</option>
            <option value="Teen">Teen</option>
            <option value="Juniors">Juniors</option>
            <option value="Seniors">Seniors</option>
            <option value="Submasters">Submasters</option>
            <option value="Masters">Masters</option>
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="weight_class">Kategoria wagowa:</label>
          <select
            name="weight_class"
            id="weight_class"
            className="form-control"
            onChange={handleChange}
            required
          >
            <option value="">Wybierz...</option>
            {weightCategories.map((category) => (
              <option key={category} value={category}>
                {category}
              </option>
            ))}
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="sex_input">Płeć:</label>
          <select
            name="sex_input"
            id="sex_input"
            className="form-control"
            onChange={handleChange}
            required
          >
            <option value="">Wybierz...</option>
            <option value="M">Mężczyzna</option>
            <option value="F">Kobieta</option>
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="limit_amount">Limit wyników:</label>
          <select
            name="limit_amount"
            id="limit_amount"
            className="form-control"
            onChange={handleChange}
            required
          >
            <option value="">Wybierz...</option>
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="100">100</option>
          </select>
        </div>

        <button type="submit" className="btn btn-primary">
          Filtruj
        </button>
      </form>

      <div className="results mt-4">
        {resultData.length > 0 && (
          <>
            <h3>Wyniki:</h3>
            <table className="table table-striped">
              <thead>
                <tr>
                  <th>Imię</th>
                  <th>Nazwisko</th>
                  <th>Płeć</th>
                  <th>Przysiad</th>
                  <th>Wyciskanie</th>
                  <th>Martwy Ciąg</th>
                  <th>Total</th>
                  <th>IPF Score</th>
                </tr>
              </thead>
              <tbody>
                {resultData.map((athlete, index) => (
                  <tr key={index}>
                    <td>{athlete.first_name}</td>
                    <td>{athlete.surname}</td>
                    <td>{athlete.r_sex}</td>
                    <td>
                      {/* Squats */}
                      {athlete.r_sqt_first_attempt_success ? (
                        athlete.r_sqt_first_attempt
                      ) : (
                        <s>{athlete.r_sqt_first_attempt}</s>
                      )}
                      ,{" "}
                      {athlete.r_sqt_second_attempt_success ? (
                        athlete.r_sqt_second_attempt
                      ) : (
                        <s>{athlete.r_sqt_second_attempt}</s>
                      )}
                      ,{" "}
                      {athlete.r_sqt_third_attempt_success ? (
                        athlete.r_sqt_third_attempt
                      ) : (
                        <s>{athlete.r_sqt_third_attempt}</s>
                      )}
                    </td>
                    <td>
                      {/* Bench Press */}
                      {athlete.r_bp_first_attempt_success ? (
                        athlete.r_bp_first_attempt
                      ) : (
                        <s>{athlete.r_bp_first_attempt}</s>
                      )}
                      ,{" "}
                      {athlete.r_bp_second_attempt_success ? (
                        athlete.r_bp_second_attempt
                      ) : (
                        <s>{athlete.r_bp_second_attempt}</s>
                      )}
                      ,{" "}
                      {athlete.r_bp_third_attempt_success ? (
                        athlete.r_bp_third_attempt
                      ) : (
                        <s>{athlete.r_bp_third_attempt}</s>
                      )}
                    </td>
                    <td>
                      {/* Deadlift */}
                      {athlete.r_dl_first_attempt_success ? (
                        athlete.r_dl_first_attempt
                      ) : (
                        <s>{athlete.r_dl_first_attempt}</s>
                      )}
                      ,{" "}
                      {athlete.r_dl_second_attempt_success ? (
                        athlete.r_dl_second_attempt
                      ) : (
                        <s>{athlete.r_dl_second_attempt}</s>
                      )}
                      ,{" "}
                      {athlete.r_dl_third_attempt_success ? (
                        athlete.r_dl_third_attempt
                      ) : (
                        <s>{athlete.r_dl_third_attempt}</s>
                      )}
                    </td>
                    <td>{athlete.r_total}</td>
                    <td>{athlete.r_ipf_score}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </>
        )}
      </div>
    </div>
  );
};

export default Filter1;
