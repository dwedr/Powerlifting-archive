import React, { useState } from "react";
import axios from "axios";

const Page2: React.FC = () => {
  const [viewMode, setViewMode] = useState("update"); // Toggle between 'update' and 'delete'
  const [updateData, setUpdateData] = useState({
    id: "",
    fname: "",
    surname: "",
    country: "",
    date_of_birth: "",
    sex: "",
  });
  const [deleteId, setDeleteId] = useState("");
  const [requests, setRequests] = useState<any[]>([]);
  const [errorMessage, setErrorMessage] = useState("");
  const [loading, setLoading] = useState(false);
  const [usedFunction, setUsedFunction] = useState("");

  const handleUpdateSubmit = async () => {
    try {
      const token = sessionStorage.getItem("token");
      const { id, fname, surname, country, date_of_birth, sex } = updateData;
      const response = await axios.put(
        `http://localhost:3000/api/competitor/${id}`,
        { fname, surname, country, date_of_birth, sex },
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      alert(response.data.message);
    } catch (error: any) {
      console.error("Wystapil blad przy aktaulizacji danych:", error);
      setErrorMessage(
        error.response?.data?.message || "Błąd przy aktualizacji."
      );
    }
  };

  const handleDeleteSubmit = async () => {
    try {
      const token = sessionStorage.getItem("token");
      const response = await axios.delete(
        `http://localhost:3000/api/competitor-start/${deleteId}`,
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      alert(response.data.message);
    } catch (error: any) {
      console.error("Wystapil blad przy usuwaniu danych:", error);
      setErrorMessage(error.response?.data?.message || "Błąd przy usuwaniu.");
    }
  };

  const fetchRequests = async (endpoint: string) => {
    try {
      setLoading(true);
      const token = sessionStorage.getItem("token");
      const response = await axios.get(`http://localhost:3000${endpoint}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setRequests(response.data);
      setErrorMessage("");
    } catch (error: any) {
      console.error("Wystapil blad przy pobieraniu:", error);
      setErrorMessage(error.response?.data?.message || "Błąd przy pobieraniu.");
    } finally {
      setLoading(false);
    }
  };

  const updateFulfillment = async (id: number, fulfilled: boolean) => {
    try {
      const token = sessionStorage.getItem("token");
      await axios.put(
        `http://localhost:3000/api/requests/${id}/fulfillment`,
        { fulfilled },
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      setRequests((prev) =>
        prev.map((req) => (req.id_request === id ? { ...req, fulfilled } : req))
      );
    } catch (error: any) {
      console.error("Wystapil blad przy aktualizacji stanu prosby:", error);
    }
  };

  return (
    <div className="container mt-5">
      <h1>Admin Dashboard</h1>

      {/* Section 1: Update/Delete Competitors */}
      <div className="mb-5">
        <h2>Edytuj lub Usuń Zawodników</h2>
        <div className="btn-group mb-3">
          <button
            className={`btn ${
              viewMode === "update" ? "btn-primary" : "btn-outline-primary"
            }`}
            onClick={() => setViewMode("update")}
          >
            Aktualizuj
          </button>
          <button
            className={`btn ${
              viewMode === "delete" ? "btn-danger" : "btn-outline-danger"
            }`}
            onClick={() => setViewMode("delete")}
          >
            Usuń
          </button>
        </div>

        {viewMode === "update" && (
          <form onSubmit={(e) => e.preventDefault()}>
            <div className="mb-3">
              <label>ID Zawodnika</label>
              <input
                type="text"
                className="form-control"
                value={updateData.id}
                onChange={(e) =>
                  setUpdateData({ ...updateData, id: e.target.value })
                }
              />
            </div>
            <div className="mb-3">
              <label>Imię</label>
              <input
                type="text"
                className="form-control"
                value={updateData.fname}
                onChange={(e) =>
                  setUpdateData({ ...updateData, fname: e.target.value })
                }
              />
            </div>
            <div className="mb-3">
              <label>Nazwisko</label>
              <input
                type="text"
                className="form-control"
                value={updateData.surname}
                onChange={(e) =>
                  setUpdateData({ ...updateData, surname: e.target.value })
                }
              />
            </div>
            <div className="mb-3">
              <label>Kraj</label>
              <input
                type="text"
                className="form-control"
                value={updateData.country}
                onChange={(e) =>
                  setUpdateData({ ...updateData, country: e.target.value })
                }
              />
            </div>
            <div className="mb-3">
              <label>Data Urodzenia</label>
              <input
                type="date"
                className="form-control"
                value={updateData.date_of_birth}
                onChange={(e) =>
                  setUpdateData({
                    ...updateData,
                    date_of_birth: e.target.value,
                  })
                }
              />
            </div>
            <div className="mb-3">
              <label>Płeć</label>
              <input
                type="text"
                className="form-control"
                value={updateData.sex}
                onChange={(e) =>
                  setUpdateData({ ...updateData, sex: e.target.value })
                }
              />
            </div>
            <button className="btn btn-primary" onClick={handleUpdateSubmit}>
              Zaktualizuj
            </button>
          </form>
        )}

        {viewMode === "delete" && (
          <form onSubmit={(e) => e.preventDefault()}>
            <div className="mb-3">
              <label>ID Startu</label>
              <input
                type="text"
                className="form-control"
                value={deleteId}
                onChange={(e) => setDeleteId(e.target.value)}
              />
            </div>
            <button className="btn btn-danger" onClick={handleDeleteSubmit}>
              Usuń
            </button>
          </form>
        )}
      </div>

      {/* Section 2: Requests Management */}
      <div>
        <h2>Rozpatrz Prośby</h2>
        <div className="btn-group mb-3">
          <button
            className="btn btn-outline-primary"
            onClick={() => {
              setUsedFunction("/api/requests/by-admin");
              fetchRequests("/api/requests/by-admin");
            }}
          >
            Dla Ciebie
          </button>
        </div>

        {/* Loading Indicator */}
        {loading && <p>Ładowanie...</p>}

        {/* No Requests Message */}
        {!loading && requests.length === 0 && <p>Brak dostępnych próśb.</p>}

        {/* Requests Table */}
        {!loading && requests.length > 0 && (
          <table className="table table-striped">
            <thead>
              <tr>
                <th>ID</th>
                <th>Typ</th>
                <th>Opis</th>
                <th>Stan</th>
                <th>Akcje</th>
              </tr>
            </thead>
            <tbody>
              {requests.map((req, idx) => (
                <tr
                  key={idx}
                  style={
                    req.fulfilled !== null ? { backgroundColor: "#f0f0f0" } : {}
                  }
                >
                  <td>{req.out_id_request}</td>
                  <td>{req.out_type_code}</td>
                  <td>{req.out_req_description}</td>
                  <td>
                    {req.out_fulfilled === null
                      ? "Oczekuje"
                      : req.out_fulfilled
                      ? "Tak"
                      : "Nie"}
                  </td>
                  <td>
                    {req.out_fulfilled === null && (
                      <>
                        <button
                          className="btn btn-success me-2"
                          onClick={() => {
                            updateFulfillment(req.out_id_request, true);
                            fetchRequests(usedFunction); // Refresh requests after action
                          }}
                        >
                          Potwierdź
                        </button>
                        <button
                          className="btn btn-danger"
                          onClick={() => {
                            updateFulfillment(req.out_id_request, false);
                            fetchRequests(usedFunction); // Refresh requests after action
                          }}
                        >
                          Odrzuć
                        </button>
                      </>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
};

export default Page2;
