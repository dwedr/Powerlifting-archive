import React, { useState } from "react";
import axios from "axios";

const Page1: React.FC = () => {
  const [activeSection, setActiveSection] = useState<string | null>(null);
  const [competitionDetails, setCompetitionDetails] = useState({
    competition_name: "",
    competition_type: "",
    begin_date: "",
    end_date: "",
    loc_country: "",
    loc_city: "",
    prize_pool: "",
  });
  const [csvFile, setCsvFile] = useState<File | null>(null);
  const [requestType, setRequestType] = useState<number | null>(null);
  const [requestDescription, setRequestDescription] = useState("");
  const [requests, setRequests] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);
  const [viewMode, setViewMode] = useState("");

  const handleCompetitionSubmit = async () => {
    if (!csvFile) {
      alert("Dodaj plik CSV.");
      return;
    }

    try {
      const fileReader = new FileReader();
      fileReader.onload = async (event) => {
        const csvText = event.target?.result as string;
        const rows = csvText.split("\n").filter((row) => row.trim() !== "");
        const competitors = rows.slice(0).map((row) => {
          const values = row.split(";").map((value) => value.trim());

          // Build the competitor details
          const competitorDetails = {
            id_competitor: parseInt(values[0]) || null, // ID may be null
            fname: values[1] || null,
            surname: values[2] || null,
            date_of_birth: values[3] || null,
            country: values[4] || null,
            sex: values[5] || null,
          };

          // Build squat details
          const squatDetails = {
            sqt_first_attempt: parseFloat(values[8]) || null,
            sqt_first_attempt_success: values[9],
            sqt_second_attempt: parseFloat(values[10]) || null,
            sqt_second_attempt_success: values[11],
            sqt_third_attempt: parseFloat(values[12]) || null,
            sqt_third_attempt_success: values[13],
          };

          // Build bench press details
          const benchDetails = {
            bp_first_attempt: parseFloat(values[14]) || null,
            bp_first_attempt_success: values[15],
            bp_second_attempt: parseFloat(values[16]) || null,
            bp_second_attempt_success: values[17],
            bp_third_attempt: parseFloat(values[18]) || null,
            bp_third_attempt_success: values[19],
          };

          // Build deadlift details
          const deadliftDetails = {
            dl_first_attempt: parseFloat(values[20]) || null,
            dl_first_attempt_success: values[21],
            dl_second_attempt: parseFloat(values[22]) || null,
            dl_second_attempt_success: values[23],
            dl_third_attempt: parseFloat(values[24]) || null,
            dl_third_attempt_success: values[25],
          };

          // Build the competitor object
          return {
            competitor_details: competitorDetails,
            competitor_weight: parseFloat(values[6]) || null,
            weight_class: values[7] || null,
            squat_details: squatDetails,
            bench_details: benchDetails,
            deadlift_details: deadliftDetails,
          };
        });

        try {
          // Send the data to the server
          const response = await axios.post(
            "http://localhost:3000/api/competitions",
            {
              competition_details: competitionDetails,
              competitors,
            },
            {
              headers: {
                Authorization: `Bearer ${sessionStorage.getItem("token")}`,
              },
            }
          );
          alert(response.data.message);
        } catch (err) {
          console.error("Wystapil blad przy wprowadzniu danych zawodow:", err);
          alert("Wystapil blad.");
        }
      };
      fileReader.readAsText(csvFile);
    } catch (err) {
      console.error("Wystapil blad przy pobieraniu danych z pliku CSV:", err);
      alert("Wystapil blad.");
    }
  };

  const handleRequestSubmit = async () => {
    if (requestType === null || requestDescription === "") {
      alert("Uzupelnij wszystkie pola.");
      return;
    }

    try {
      const response = await axios.post(
        "http://localhost:3000/api/requests/make",
        {
          type_number: requestType - 1,
          description: requestDescription,
        },
        {
          headers: {
            Authorization: `Bearer ${sessionStorage.getItem("token")}`,
          },
        }
      );
      alert(response.data.message);
    } catch (err) {
      console.error("Wystapil blad przy przetwarzaniu zapytania:", err);
      alert("Wystapil blad.");
    }
  };

  const fetchRequests = async () => {
    setLoading(true);
    try {
      const response = await axios.get(
        "http://localhost:3000/api/requests-by-federation",
        {
          headers: {
            Authorization: `Bearer ${sessionStorage.getItem("token")}`,
          },
        }
      );
      setRequests(response.data);
    } catch (err) {
      console.error("Wystapil blad przy przetwarzaniu zapytania:", err);
      alert("Wystapil blad.");
    }
    setLoading(false);
  };

  return (
    <div className="container mt-4">
      <h1>Federation Dashboard</h1>
      <div className="btn-group mb-3">
        <button
          className={`btn ${
            viewMode === "dodaj" ? "btn-primary" : "btn-outline-primary"
          }`}
          onClick={() => {
            setActiveSection("dodaj");
            setViewMode("dodaj");
          }}
        >
          Dodaj
        </button>
        <button
          className={`btn ${
            viewMode === "prosba" ? "btn-primary" : "btn-outline-primary"
          }`}
          onClick={() => {
            setActiveSection("prośba");
            setViewMode("prosba");
          }}
        >
          Prośba
        </button>
        <button
          className={`btn ${
            viewMode === "moje" ? "btn-primary" : "btn-outline-primary"
          }`}
          onClick={() => {
            setActiveSection("mojeProśby");
            fetchRequests();
            setViewMode("moje");
          }}
        >
          Moje Prośby
        </button>
      </div>

      {activeSection === "dodaj" && (
        <div>
          <h2>Dodaj Zawody</h2>
          <form>
            <div className="mb-3">
              <label className="form-label">Nazwa zawodów</label>
              <input
                type="text"
                className="form-control"
                value={competitionDetails.competition_name}
                onChange={(e) =>
                  setCompetitionDetails({
                    ...competitionDetails,
                    competition_name: e.target.value,
                  })
                }
              />
            </div>
            <div className="mb-3">
              <label className="form-label">Typ zawodów</label>
              <select
                className="form-select"
                value={competitionDetails.competition_type}
                onChange={(e) =>
                  setCompetitionDetails({
                    ...competitionDetails,
                    competition_type: e.target.value,
                  })
                }
              >
                <option value="">Wybierz</option>
                <option value="Raw">Raw</option>
                <option value="Bandaże">Bandaże</option>
                <option value="Raw + Bandaże">Raw + Bandaże</option>
                <option value="Jednowarstwowy">Jednowarstwowy</option>
                <option value="Wielowarstwowy">Wielowarstwowy</option>
                <option value="Nielimitowany">Nielimitowany</option>
              </select>
            </div>
            <div className="mb-3">
              <label className="form-label">Data rozpoczęcia</label>
              <input
                type="date"
                className="form-control"
                value={competitionDetails.begin_date}
                onChange={(e) =>
                  setCompetitionDetails({
                    ...competitionDetails,
                    begin_date: e.target.value,
                  })
                }
              />
            </div>
            <div className="mb-3">
              <label className="form-label">Data zakończenia</label>
              <input
                type="date"
                className="form-control"
                value={competitionDetails.end_date}
                onChange={(e) =>
                  setCompetitionDetails({
                    ...competitionDetails,
                    end_date: e.target.value,
                  })
                }
              />
            </div>
            <div className="mb-3">
              <label className="form-label">Kraj</label>
              <select
                className="form-select"
                value={competitionDetails.loc_country}
                onChange={(e) =>
                  setCompetitionDetails({
                    ...competitionDetails,
                    loc_country: e.target.value,
                  })
                }
              >
                <option value="">Wybierz</option>
                {[
                  "Afganistan",
                  "Albania",
                  "Algieria",
                  "Andora",
                  "Angola",
                  "Antigua i Barbuda",
                  "Arabia Saudyjska",
                  "Argentyna",
                  "Armenia",
                  "Australia",
                  "Austria",
                  "Azerbejdżan",
                  "Bahamy",
                  "Bahrajn",
                  "Bangladesz",
                  "Barbados",
                  "Belgia",
                  "Belize",
                  "Benin",
                  "Bhutan",
                  "Białoruś",
                  "Boliwia",
                  "Bośnia i Hercegowina",
                  "Botswana",
                  "Brazylia",
                  "Brunei",
                  "Bułgaria",
                  "Burkina Faso",
                  "Burundi",
                  "Chile",
                  "Chiny",
                  "Chorwacja",
                  "Cypr",
                  "Czarnogóra",
                  "Czechy",
                  "Dania",
                  "Dominika",
                  "Dominikana",
                  "Dżibuti",
                  "Ekwador",
                  "Egipt",
                  "Erytrea",
                  "Estonia",
                  "Eswatini",
                  "Etiopia",
                  "Fidżi",
                  "Filipiny",
                  "Finlandia",
                  "Francja",
                  "Gabon",
                  "Gambia",
                  "Ghana",
                  "Grecja",
                  "Grenada",
                  "Gruzja",
                  "Gujana",
                  "Gwatemala",
                  "Gwinea",
                  "Gwinea Bissau",
                  "Gwinea Równikowa",
                  "Haiti",
                  "Hiszpania",
                  "Holandia",
                  "Honduras",
                  "Indie",
                  "Indonezja",
                  "Irak",
                  "Iran",
                  "Irlandia",
                  "Islandia",
                  "Izrael",
                  "Jamajka",
                  "Japonia",
                  "Jemen",
                  "Jordania",
                  "Kambodża",
                  "Kamerun",
                  "Kanada",
                  "Katar",
                  "Kazachstan",
                  "Kenia",
                  "Kirgistan",
                  "Kiribati",
                  "Kolumbia",
                  "Komory",
                  "Kongo",
                  "Korea Południowa",
                  "Korea Północna",
                  "Kostaryka",
                  "Kosowo",
                  "Kuba",
                  "Kuwejt",
                  "Laos",
                  "Lesotho",
                  "Liban",
                  "Liberia",
                  "Libia",
                  "Liechtenstein",
                  "Litwa",
                  "Luksemburg",
                  "Łotwa",
                  "Macedonia Północna",
                  "Madagaskar",
                  "Malawi",
                  "Malediwy",
                  "Malezja",
                  "Mali",
                  "Malta",
                  "Maroko",
                  "Mauretania",
                  "Mauritius",
                  "Meksyk",
                  "Mikronezja",
                  "Mjanma",
                  "Mołdawia",
                  "Monako",
                  "Mongolia",
                  "Mozambik",
                  "Namibia",
                  "Nauru",
                  "Nepal",
                  "Niemcy",
                  "Niger",
                  "Nigeria",
                  "Nikaragua",
                  "Norwegia",
                  "Nowa Zelandia",
                  "Oman",
                  "Pakistan",
                  "Palau",
                  "Panama",
                  "Papua-Nowa Gwinea",
                  "Paragwaj",
                  "Peru",
                  "Polska",
                  "Portugalia",
                  "Republika Południowej Afryki",
                  "Republika Środkowoafrykańska",
                  "Republika Zielonego Przylądka",
                  "Rosja",
                  "Rumunia",
                  "Rwanda",
                  "Saint Kitts i Nevis",
                  "Saint Lucia",
                  "Saint Vincent i Grenadyny",
                  "Salwador",
                  "Samoa",
                  "San Marino",
                  "Senegal",
                  "Serbia",
                  "Seszele",
                  "Sierra Leone",
                  "Singapur",
                  "Słowacja",
                  "Słowenia",
                  "Somalia",
                  "Sri Lanka",
                  "Stany Zjednoczone",
                  "Sudan",
                  "Sudan Południowy",
                  "Surinam",
                  "Syria",
                  "Szwajcaria",
                  "Szwecja",
                  "Tadżykistan",
                  "Tajlandia",
                  "Tanzania",
                  "Togo",
                  "Tonga",
                  "Trynidad i Tobago",
                  "Tunezja",
                  "Turcja",
                  "Turkmenistan",
                  "Tuvalu",
                  "Uganda",
                  "Ukraina",
                  "Urugwaj",
                  "Uzbekistan",
                  "Vanuatu",
                  "Watykan",
                  "Wenezuela",
                  "Węgry",
                  "Wielka Brytania",
                  "Wietnam",
                  "Włochy",
                  "Wybrzeże Kości Słoniowej",
                  "Wyspy Marshalla",
                  "Wyspy Salomona",
                  "Zambia",
                  "Zimbabwe",
                  "Zjednoczone Emiraty Arabskie",
                ].map((country) => (
                  <option key={country} value={country}>
                    {country}
                  </option>
                ))}
              </select>
            </div>
            <div className="mb-3">
              <label className="form-label">Miasto</label>
              <input
                type="text"
                className="form-control"
                value={competitionDetails.loc_city}
                onChange={(e) =>
                  setCompetitionDetails({
                    ...competitionDetails,
                    loc_city: e.target.value,
                  })
                }
              />
            </div>
            <div className="mb-3">
              <label className="form-label">Pula nagród</label>
              <input
                type="number"
                className="form-control"
                value={competitionDetails.prize_pool}
                onChange={(e) =>
                  setCompetitionDetails({
                    ...competitionDetails,
                    prize_pool: e.target.value,
                  })
                }
              />
            </div>
            <div className="mb-3">
              <label className="form-label">Plik CSV</label>
              <input
                type="file"
                className="form-control"
                accept=".csv"
                onChange={(e) => setCsvFile(e.target.files?.[0] || null)}
              />
              <small className="form-text text-muted">
                Plik CSV powinien zawierać dane w odpowiednim formacie.
              </small>
            </div>
            <button
              type="button"
              className="btn btn-success"
              onClick={handleCompetitionSubmit}
            >
              Dodaj Zawody
            </button>
          </form>
        </div>
      )}

      {activeSection === "prośba" && (
        <div>
          <h2>Dodaj Prośbę</h2>
          <form>
            <div className="mb-3">
              <label className="form-label">Typ Prośby</label>
              <select
                className="form-control"
                value={requestType || ""}
                onChange={(e) => setRequestType(Number(e.target.value))}
              >
                <option value="">Wybierz typ prośby</option>
                <option value="1">Do superadmina</option>
                <option value="2">Zmień dane</option>
                <option value="3">Usuń występ</option>
              </select>
            </div>
            <div className="mb-3">
              <label className="form-label">Opis Prośby</label>
              <textarea
                className="form-control"
                rows={3}
                value={requestDescription}
                onChange={(e) => setRequestDescription(e.target.value)}
              ></textarea>
            </div>
            <button
              type="button"
              className="btn btn-success"
              onClick={handleRequestSubmit}
            >
              Wyślij Prośbę
            </button>
          </form>
        </div>
      )}

      {activeSection === "mojeProśby" && (
        <div>
          <h2>Moje Prośby</h2>
          {loading && <p>Ładowanie...</p>}
          {!loading && requests.length > 0 && (
            <table className="table table-striped">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Typ</th>
                  <th>Opis</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                {requests.map((req, idx) => (
                  <tr key={idx}>
                    <td>{req.out_id_request}</td>
                    <td>{req.out_type_code}</td>
                    <td>{req.out_req_description}</td>
                    <td>
                      {req.out_fulfilled == null
                        ? "Oczekująca"
                        : req.out_fulfilled
                        ? "Zrealizowana"
                        : "Odrzucona"}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      )}
    </div>
  );
};

export default Page1;
