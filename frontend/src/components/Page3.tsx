import React, { useState } from "react";
import axios from "axios";

const Page3: React.FC = () => {
  const [query, setQuery] = useState("");
  const [queryResult, setQueryResult] = useState<any[]>([]);
  const [requests, setRequests] = useState<any[]>([]);
  const [errorMessage, setErrorMessage] = useState("");
  const [errorMessage2, setErrorMessage2] = useState("");
  const [loading, setLoading] = useState(false);
  const [loading2, setLoading2] = useState(false);
  const [used_function, setUsedFunction] = useState("");
  // Handle query execution
  const handleQuerySubmit = async () => {
    try {
      setLoading(true);
      const token = sessionStorage.getItem("token");
      const response = await axios.post(
        "http://localhost:3000/api/query",
        { query },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      setQueryResult(response.data.result);
      setErrorMessage("");
    } catch (error: any) {
      setErrorMessage(
        error.response?.data?.message || "Błąd przy wykonywaniu polecenia"
      );
    } finally {
      setLoading(false);
    }
  };

  // Fetch unfulfilled, all requests, or requests by admin
  const fetchRequests = async (endpoint: string) => {
    try {
      setLoading2(true);
      const token = sessionStorage.getItem("token");
      const response = await axios.get(`http://localhost:3000${endpoint}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setRequests(response.data);
      setErrorMessage2("");
    } catch (error: any) {
      setErrorMessage2(error.response?.data?.message || "Błąd przy pobieraniu");
    } finally {
      setLoading2(false);
    }
  };

  // Update request fulfillment
  const updateFulfillment = async (id: number, fulfilled: boolean) => {
    try {
      const token = sessionStorage.getItem("token");
      await axios.put(
        `http://localhost:3000/api/requests/${id}/fulfillment`,
        { fulfilled },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      // Refresh requests after update
      setRequests((prev) =>
        prev.map((req) => (req.id_request === id ? { ...req, fulfilled } : req))
      );
    } catch (error: any) {
      setErrorMessage(
        error.response?.data?.message || "Błąd przy aktualizacji danych"
      );
    }
  };
  return (
    <div className="container mt-5">
      <h1>SuperAdmin Dashboard</h1>

      {/* Section 1: Query Execution */}
      <div className="query-section mb-5">
        <h2>Query</h2>
        <textarea
          className="form-control"
          rows={4}
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Napisz zapytanie..."
        ></textarea>
        <button className="btn btn-primary mt-3" onClick={handleQuerySubmit}>
          Wykonaj
        </button>
        {loading && <p>Ładuje...</p>}
        {errorMessage && <p className="text-danger">{errorMessage}</p>}
        {queryResult.length > 0 && (
          <div className="mt-4">
            <h3>Rezultat:</h3>
            <table className="table table-striped">
              <thead>
                <tr>
                  {Object.keys(queryResult[0]).map((key) => (
                    <th key={key}>{key}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {queryResult.map((row, idx) => (
                  <tr key={idx}>
                    {Object.values(row).map((val: any, colIdx) => (
                      <td key={colIdx}>{val}</td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Section 2: Requests Management */}
      <div className="requests-section">
        <h2>Rozpatrz prośby</h2>
        <div className="btn-group mb-3">
          <button
            className="btn btn-outline-success"
            onClick={() => {
              setUsedFunction("/api/requests/by-admin");
              fetchRequests("/api/requests/by-admin");
            }}
          >
            Dla ciebie
          </button>
          <button
            className="btn btn-outline-primary"
            onClick={() => {
              setUsedFunction("/api/requests/unfulfilled");
              fetchRequests("/api/requests/unfulfilled");
            }}
          >
            Wszystkie
          </button>
          <button
            className="btn btn-outline-secondary"
            onClick={() => {
              setUsedFunction("/api/requests");
              fetchRequests("/api/requests");
            }}
          >
            Historia
          </button>
        </div>
        {loading2 && <p>Ładuje...</p>}
        {errorMessage2 && <p className="text-danger">{errorMessage2}</p>}
        {requests.length > 0 && (
          <div>
            <h3>Prośby:</h3>
            <table className="table table-striped">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Opis</th>
                  <th>Stan wykonania</th>
                  {requests[0]?.out_fulfilled === null && <th>Działania</th>}
                </tr>
              </thead>
              <tbody>
                {requests.map((req, idx) => (
                  <tr key={idx}>
                    <td>{req.out_id_request}</td>
                    <td>{req.out_req_description}</td>
                    <td>
                      {req.out_fulfilled === null
                        ? "Oczekuje"
                        : req.out_fulfilled
                        ? "Tak"
                        : "Nie"}
                    </td>
                    {req.out_fulfilled === null && (
                      <td>
                        <button
                          className="btn btn-success btn-sm me-2"
                          onClick={async () => {
                            try {
                              await updateFulfillment(req.out_id_request, true);
                              fetchRequests(used_function); // Fetch updated list after accepting
                            } catch (error) {
                              console.error("Error accepting request:", error);
                            }
                          }}
                        >
                          Potwierdź
                        </button>
                        <button
                          className="btn btn-danger btn-sm"
                          onClick={async () => {
                            try {
                              await updateFulfillment(
                                req.out_id_request,
                                false
                              );
                              fetchRequests(used_function); // Fetch updated list after denying
                            } catch (error) {
                              console.error("Error denying request:", error);
                            }
                          }}
                        >
                          Odrzuć
                        </button>
                      </td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
};

export default Page3;
