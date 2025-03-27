import React, { useState } from "react";
import axios from "axios";

const Wyszukaj: React.FC = () => {
  const [activeSearch, setActiveSearch] = useState<number>(1);
  const [athleteInput, setAthleteInput] = useState<string>("");
  const [federationInput, setFederationInput] = useState<string>("");
  const [athleteResults, setAthleteResults] = useState<any[]>([]);
  const [competitionResults, setCompetitionResults] = useState<any[]>([]);

  const handleAthleteSearch = async () => {
    const [athleteName, ...athleteSurnameArr] = athleteInput.split(" ");
    const athleteSurname = athleteSurnameArr.join(" ");

    if (!athleteName || !athleteSurname) {
      alert("Podaj imie i nazwisko");
      return;
    }

    try {
      const response = await axios.post(
        "http://localhost:3000/api/fetch-athlete-details-by-name",
        {
          athlete_name: athleteName,
          athlete_surname: athleteSurname,
        }
      );
      setAthleteResults(response.data);
    } catch (err: unknown) {
      console.error(
        "Blad przy pobieraniu danych zawodnika:",
        (err as Error).message
      );
    }
  };

  const handleFederationSearch = async () => {
    if (!federationInput) {
      alert("Podaj nazwe federacji.");
      return;
    }

    try {
      const response = await axios.post(
        "http://localhost:3000/api/fetch-competitions-by-federation",
        {
          federation_name: federationInput,
        }
      );
      setCompetitionResults(response.data);
    } catch (err: unknown) {
      console.error(
        "Blad przy pobieraniu danych federacji:",
        (err as Error).message
      );
    }
  };

  return (
    <div className="wyszukaj-container">
      <h2 className="text-center">Wyszukaj</h2>

      {/* Toggle Buttons */}
      <div className="button-row mb-4">
        <button
          className={`filter-button ${activeSearch === 1 ? "active" : ""}`}
          onClick={() => setActiveSearch(1)}
        >
          Wyszukaj Zawodnika
        </button>
        <button
          className={`filter-button ${activeSearch === 2 ? "active" : ""}`}
          onClick={() => setActiveSearch(2)}
        >
          Wyszukaj Zawody
        </button>
      </div>

      {/* Athlete Search */}
      {activeSearch === 1 && (
        <div className="search-section">
          <h3>Wyszukaj Zawodnika</h3>
          <input
            type="text"
            placeholder="Imię Nazwisko"
            value={athleteInput}
            onChange={(e) => setAthleteInput(e.target.value)}
            className="form-control"
          />
          <button
            onClick={handleAthleteSearch}
            className="btn btn-primary mt-2"
          >
            Wyszukaj
          </button>
          {athleteResults.length > 0 && (
            <div className="results mt-4">
              <h3>Wyniki Zawodnika:</h3>
              <table className="table table-striped">
                <thead>
                  <tr>
                    <th>Imię</th>
                    <th>Nazwisko</th>
                    <th>Płeć</th>
                    <th>Kraj</th>
                    <th>Zawody</th>
                    <th>Przysiad</th>
                    <th>Wyciskanie</th>
                    <th>Martwy Ciąg</th>
                    <th>Wynik Całkowity</th>
                    <th>IPF Score</th>
                  </tr>
                </thead>
                <tbody>
                  {athleteResults.map((competitor, index) => (
                    <tr key={index}>
                      <td>{competitor.r_first_name}</td>
                      <td>{competitor.r_surname}</td>
                      <td>{competitor.r_sex}</td>
                      <td>{competitor.r_country}</td>
                      <td>{competitor.r_competition_name}</td>
                      <td>
                        {competitor.r_sqt_first_attempt_success ? (
                          competitor.r_sqt_first_attempt
                        ) : (
                          <s>{competitor.r_sqt_first_attempt}</s>
                        )}
                        ,
                        {competitor.r_sqt_second_attempt_success ? (
                          competitor.r_sqt_second_attempt
                        ) : (
                          <s>{competitor.r_sqt_second_attempt}</s>
                        )}
                        ,
                        {competitor.r_sqt_third_attempt_success ? (
                          competitor.r_sqt_third_attempt
                        ) : (
                          <s>{competitor.r_sqt_third_attempt}</s>
                        )}
                      </td>
                      <td>
                        {competitor.r_bp_first_attempt_success ? (
                          competitor.r_bp_first_attempt
                        ) : (
                          <s>{competitor.r_bp_first_attempt}</s>
                        )}
                        ,
                        {competitor.r_bp_second_attempt_success ? (
                          competitor.r_bp_second_attempt
                        ) : (
                          <s>{competitor.r_bp_second_attempt}</s>
                        )}
                        ,
                        {competitor.r_bp_third_attempt_success ? (
                          competitor.r_bp_third_attempt
                        ) : (
                          <s>{competitor.r_bp_third_attempt}</s>
                        )}
                      </td>
                      <td>
                        {competitor.r_dl_first_attempt_success ? (
                          competitor.r_dl_first_attempt
                        ) : (
                          <s>{competitor.r_dl_first_attempt}</s>
                        )}
                        ,
                        {competitor.r_dl_second_attempt_success ? (
                          competitor.r_dl_second_attempt
                        ) : (
                          <s>{competitor.r_dl_second_attempt}</s>
                        )}
                        ,
                        {competitor.r_dl_third_attempt_success ? (
                          competitor.r_dl_third_attempt
                        ) : (
                          <s>{competitor.r_dl_third_attempt}</s>
                        )}
                      </td>
                      <td>{competitor.r_total_lift}</td>
                      <td>{competitor.r_ipf_score}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}

      {/* Federation Search */}
      {activeSearch === 2 && (
        <div className="search-section">
          <h3>Wyszukaj Zawody</h3>
          <input
            type="text"
            placeholder="Nazwa Federacji"
            value={federationInput}
            onChange={(e) => setFederationInput(e.target.value)}
            className="form-control"
          />
          <button
            onClick={handleFederationSearch}
            className="btn btn-primary mt-2"
          >
            Wyszukaj
          </button>
          {competitionResults.length > 0 && (
            <div className="results mt-4">
              <h3>Wyniki Zawodów:</h3>
              <div className="table-responsive">
                <table className="table table-striped">
                  <thead>
                    <tr>
                      <th>ID Zawodów</th>
                      <th>Nazwa Zawodów</th>
                      <th>Typ</th>
                      <th>Data Rozpoczęcia</th>
                      <th>Data Zakończenia</th>
                      <th>Kraj</th>
                      <th>Miasto</th>
                      <th>Pula Nagród</th>
                    </tr>
                  </thead>
                  <tbody>
                    {competitionResults.map((competition, index) => (
                      <tr key={index}>
                        <td>{competition.id_competition}</td>
                        <td>{competition.competition_name}</td>
                        <td>{competition.competition_type}</td>
                        <td>{competition.begin_date}</td>
                        <td>{competition.end_date}</td>
                        <td>{competition.loc_country}</td>
                        <td>{competition.loc_city}</td>
                        <td>{competition.prize_pool}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default Wyszukaj;
