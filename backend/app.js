const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
require('dotenv').config();
const pool = require('./db');
const cors = require('cors');

const app = express();

const PORT  = 3000;

app.use(cors());
app.use(bodyParser.json());


  function authenticateToken(req, res, next) {

    let token = req.headers['authorization'];
    if (!token) {
      return res.status(401).json({ message: 'Brak dostepu' });
    }
  
    token = token.split(' ')[1];
  
    // Verify JWT token
    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
      if (err) {
        return res.status(403).json({ message: 'Niewazny token' });
      }
  
      // Attach the user ID and role from the token to the request object
      req.user = { id: decoded.id, role: decoded.role };
  
      // Optionally attach role directly for convenience
      req.role = decoded.role;
  
      next();
    });
  }
  
app.post('/login', async (req, res) => {
    const { username, password } = req.body;
  
    try {
      // Check if the username matches a federation name
      const federationResult = await pool.query(
        'SELECT id_federation, federation_password FROM federations WHERE fed_name = $1',
        [username]
      );
  
      if (federationResult.rows.length > 0) {
        const federation = federationResult.rows[0];
  
        if (password === federation.federation_password) {
          // Create a JWT for federation-level access (0)
          const token = jwt.sign(
            { id: federation.id_federation, role: 0 },
            process.env.JWT_SECRET,
            { expiresIn: process.env.JWT_EXPIRATION }
          );
          return res.status(200).json({ token, role: 0 });
        }
      }
  
      // Check if the username matches an admin login
      const adminResult = await pool.query(
        'SELECT id_admin, admin_password, superadmin FROM admins WHERE admin_login = $1',
        [username]
      );
  
      if (adminResult.rows.length > 0) {
        const admin = adminResult.rows[0];
  
        if (password === admin.admin_password) {
          const role = admin.superadmin ? 2 : 1; // 2 for superadmins, 1 for regular admins
          // Create a JWT for admin-level access
          const token = jwt.sign(
            { id: admin.id_admin, role },
            process.env.JWT_SECRET,
            { expiresIn: process.env.JWT_EXPIRATION }
          );
          if(role === 1) return res.status(201).json({ token, role });
          else return res.status(202).json({ token, role });
        }
      }
  
      // If neither federation nor admin matches
      return res.status(400).json({ message: 'Zle dane logowania.' });
    } catch (err) {
      console.error('Blad podczas logowania:', err.message);
      res.status(500).json({ message: 'Wystapil blad podczas logowania.' });
    }
  });
  


// Fetch Top 100 Male Results
app.get('/api/top-100-male-results', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM top_100_male_results;');
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Wstapil blad podczas pobierania top100 mezczyzn:', err.message);
      res.status(500).json({ message: 'Wstapil blad podczas pobierania top100 mezczyzn.' });
    }
  });
  
  // Fetch Top 100 Female Results
  app.get('/api/top-100-female-results', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM top_100_female_results;');
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Wstapil blad podczas pobierania top100 kobiet:', err.message);
      res.status(500).json({ message: 'Wstapil blad podczas pobierania top100 kobiet.' });
    }
  });
  
  // Fetch Top 100 Overall Athletes
  app.get('/api/top-100-athletes', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM top_100_athletes;');
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Wstapil blad podczas pobierania top100:', err.message);
      res.status(500).json({ message: 'Wstapil blad podczas pobierania top100.' });
    }
  });

  app.post('/api/fetch-athlete-details', async (req, res) => {
    const { comp_type, age, weight_class, sex_input, limit_amount } = req.body;
  
    // Validate required parameters
    if (!comp_type || !age || !weight_class || !limit_amount) {
      return res.status(400).json({
        message: 'Brak danych: comp_type, age, weight_class, and limit_amount are mandatory.',
      });
    }
  
    try {
      // Query the database using the function
      const query = `
        SELECT * FROM fetch_athlete_details($1, $2, $3, $4, $5);
      `;
      const values = [comp_type, age, weight_class, sex_input, limit_amount];
      const result = await pool.query(query, values);
  
      // Return results
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });

  app.post('/api/count-athletes', async (req, res) => {
    const { input_sex } = req.body;
  
    try {
      // Query the database using the function
      const query = `
        SELECT * FROM count_athletes_by_sex_and_country($1);
      `;
      const values = [input_sex];
      const result = await pool.query(query, values);
  
      // Return the results as JSON
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });

  app.post('/api/count-federation-competitions', async (req, res) => {
    const { competition_type_input } = req.body;
  
    try {
      // Query the database using the function
      const query = `
        SELECT * FROM count_federation_competitions($1);
      `;
      const values = [competition_type_input];
      const result = await pool.query(query, values);
  
      // Return the results as JSON
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });
  
  app.post('/api/fetch-athlete-details-by-name', async (req, res) => {
    const { athlete_name, athlete_surname } = req.body;
  
    // Validate required parameters
    if (!athlete_name || !athlete_surname) {
      return res.status(400).json({
        message: 'Brakujace parametry: athlete_name and athlete_surname are mandatory.',
      });
    }
  
    try {
      // Query the database using the function
      const query = `
        SELECT * FROM fetch_athlete_details_by_name($1, $2);
      `;
      const values = [athlete_name, athlete_surname];
      const result = await pool.query(query, values);
  
      // Return the results as JSON
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });
  
  app.post('/api/fetch-competitions-by-federation', async (req, res) => {
    const { federation_name } = req.body;
  
    // Validate required parameters
    if (!federation_name) {
      return res.status(400).json({
        message: 'Brakujace parametry: federation_name is mandatory.',
      });
    }
  
    try {
      // Query the database using the function
      const query = `
        SELECT * FROM fetch_competitions_by_federation($1);
      `;
      const values = [federation_name];
      const result = await pool.query(query, values);
  
      // Return the results as JSON
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });
  
  app.get('/api/get-distinct-weight-categories', async (req, res) => {
    try {
      // Query the database using the function
      const query = `
        SELECT * FROM get_distinct_weight_categories();
      `;
      const result = await pool.query(query);
  
      // Return the results as JSON
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });
  app.post('/api/list-competitors-by-competition', async (req, res) => {
    const { competition_name_input } = req.body;
  
    // Validate required parameter
    if (!competition_name_input) {
      return res.status(400).json({
        message: 'Brakujace parametry: competition_name_input is mandatory.',
      });
    }
  
    try {
      // Query the database using the function
      const query = `
        SELECT * FROM list_competitors_by_competition($1);
      `;
      const values = [competition_name_input];
      const result = await pool.query(query, values);
  
      // Return the results as JSON
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });
  app.post('/api/get-competitor-details', async (req, res) => {
    const { fname, surname, country } = req.body;
  
    // Validate required parameters
    if (!fname || !surname || !country) {
      return res.status(400).json({
        message: 'Brakujace parametry: fname, surname, and country are mandatory.',
      });
    }
  
    try {
      // Query the database
      const query = `
        SELECT id_competitor, date_of_birth
        FROM competitors
        WHERE fname = $1 AND surname = $2 AND country = $3;
      `;
      const values = [fname, surname, country];
      const result = await pool.query(query, values);
  
      // Check if a competitor was found
      if (result.rows.length === 0) {
        return res.status(404).json({ message: 'Nie znaleziono zawodnika.' });
      }
  
      // Return the competitor details
      res.status(200).json(result.rows[0]);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });
      
  app.get('/api/requests/unfulfilled', authenticateToken, async (req, res) => {
    try {
      // Query the database using the list_requests_unfulfilled function
      const query = `
        SELECT * FROM list_requests_unfulfilled();
      `;
      const result = await pool.query(query);
  
      // Return the list of unfulfilled requests
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });

  app.get('/api/requests', authenticateToken, async (req, res) => {
    try {
      // Query the database using the list_all_requests function
      const query = `
        SELECT * FROM list_all_requests();
      `;
      const result = await pool.query(query);
  
      // Return the list of all requests
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });

  app.put('/api/requests/:id/fulfillment', authenticateToken, async (req, res) => {
    const { id } = req.params;
    const { fulfilled } = req.body;
  
    // Validate input
    if (typeof fulfilled !== 'boolean') {
      return res.status(400).json({ message: 'Zly input: "fulfilled" musi byc boolean.' });
    }
  
    try {
      // Execute the update_request_fulfillment function
      const query = `
        SELECT update_request_fulfillment($1, $2);
      `;
      const values = [id, fulfilled];
      await pool.query(query, values);
  
      // Confirm the update
      res.status(200).json({ message: 'Zaaktualizowano stan prosby.' });
    } catch (err) {
      console.error('Blad przy aktualizacji danych:', err.message);
      res.status(500).json({ message: 'Blad przy aktualizacji danych.' });
    }
  });

  app.get('/api/requests/by-admin', authenticateToken, async (req, res) => {
    try {
      // Extract admin_id from JWT (stored in req.user.id)
      const admin_id = req.user.id;
  
  
      // Query the database using the list_requests_by_admin function
      const query = `
        SELECT * FROM list_requests_by_admin($1);
      `;
      const values = [admin_id];
      const result = await pool.query(query, values);
  
      // Return the results as JSON
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({ message: 'Blad przy pobieraniu danych.' });
    }
  });


  app.post('/api/requests/make', authenticateToken, async (req, res) => {
    const {type_number, description } = req.body;
  
    // Validate required parameters
    if (type_number == null || !description) {
      return res.status(400).json({
        message: 'Brakujace parametry: federation_id, type_number, and description are mandatory.',
      });
    }
   
    try {
      // Execute the make_request function
      const query = `
        SELECT make_request($1, $2, $3);
      `;
      const values = [ req.user.id, type_number, description];
      await pool.query(query, values);
  
      // Confirm successful request creation
      res.status(201).json({ message: 'Prośba zostałą wysłana.' });
    } catch (err) {
      console.error('Blad przy tworzeniu prosby:', err.message);
      res.status(500).json({ message: 'Blad przy tworzeniu prosby.' });
    }
  });

  app.post('/api/competitions', authenticateToken, async (req, res) => {
    const { competition_details, competitors } = req.body;
    console.log(competition_details);
    console.log(competitors);
    // Validate the request body
    if (!competition_details || !Array.isArray(competitors)) {
      return res.status(400).json({
        message: 'Niepoprawne dane w body.',
      });
    }
  
    const federation_id = req.user.id; // Federation ID from JWT
  
    try {
      // Insert the competition
      const competitionQuery = `
        SELECT insert_competition($1, $2) AS competition_id;
      `;
      const competitionResult = await pool.query(competitionQuery, [federation_id, competition_details]);
      const competition_id = competitionResult.rows[0]?.competition_id;
  
      if (!competition_id) {
        return res.status(500).json({
          message: 'Blad podczas wprowadzania danych. Sprawdz poprawnosc inputu.',
        });
      }
  
      // Process each competitor in the array
      for (const competitor of competitors) {
        const {
          competitor_details,
          competitor_weight,
          weight_class,
          squat_details,
          bench_details,
          deadlift_details,
        } = competitor;
  
        try {
          const competitorQuery = `
            SELECT insert_competition_related(
              $1, $2, $3, $4, $5, $6, $7
            );
          `;
          await pool.query(competitorQuery, [
            competition_id,
            competitor_details,
            competitor_weight,
            weight_class,
            squat_details,
            bench_details,
            deadlift_details,
          ]);
        } catch (err) {
          console.error(
            `Blad przy wprowadzaniu danych ${JSON.stringify(
              competitor_details
            )}: ${err.message}`
          );
          return res.status(500).json({
            message: `Blad przy wprowadzaniu danych : ${JSON.stringify(
              competitor_details
            )}.`,
          });
        }
      }
  
      // All operations completed successfully
      res.status(201).json({
        message: 'Dane zostaly wprowadzone poprawnie.',
        competition_id,
      });
    } catch (err) {
      console.error('Blad przy wprowadzaniu danych:', err.message);
      res.status(500).json({
        message: 'Blad przy wprowadzaniu danych.',
      });
    }
  });
  
  app.post('/api/query', authenticateToken, async (req, res) => {
    const { query } = req.body;
  
    // Validate that the query is provided
    if (!query || typeof query !== 'string') {
      return res.status(400).json({ message: 'Podaj poprawne polecenie.' });
    }
  
    // Ensure the user is authorized to execute queries
    if (req.user.role !== 2) { // Assuming role 2 is superadmin
      return res.status(403).json({ message: 'Brak dostepu.' });
    }
  
    try {
      // Execute the query
      const result = await pool.query(query);
  
      // Return the result
      res.status(200).json({
        message: 'Wykonano pomyslnie.',
        result: result.rows,
      });
    } catch (err) {
      console.error('Blad podczas wykonywania polecenia:', err.message);
      res.status(500).json({
        message: 'Blad podczas wykonywania polecenia.',
        error: err.message,
      });
    }
  });
  

  app.get('/api/requests-by-federation', authenticateToken, async (req, res) => {
    const federationId = req.user.id; // Assuming federation_id comes from the authenticated token payload
  
    try {
      // Query the database using the function
      const query = `
        SELECT * FROM get_requests_by_federation($1);
      `;
      const values = [federationId];
  
      const result = await pool.query(query, values);
  
      // Return the results as JSON
      res.status(200).json(result.rows);
    } catch (err) {
      console.error('Blad przy pobieraniu danych:', err.message);
      res.status(500).json({
        message: 'Blad przy pobieraniu danych.',
      });
    }
  });
  

// DELETE /api/competitor-start/:start_id
app.delete('/api/competitor-start/:start_id', authenticateToken, async (req, res) => {
  const { start_id } = req.params;

  try {
    const query = 'SELECT delete_competitor_start($1);';
    await pool.query(query, [start_id]);

    res.status(200).json({ message: `Start z ID ${start_id} zostal pomyslnie usuniety.` });
  } catch (err) {
    console.error('Blad podczas usuwania:', err.message);
    res.status(500).json({ message: 'Blad podczas usuwania.' });
  }
});

app.put('/api/competitor/:id', authenticateToken, async (req, res) => {
  const { id } = req.params;
  const { fname, surname, country, date_of_birth, sex } = req.body;

  if (!fname || !surname || !country || !date_of_birth || !sex) {
    return res.status(400).json({ message: 'Niekompletne dane' });
  }

  try {
    const query = `
      SELECT update_competitor_data($1, $2, $3, $4, $5, $6);
    `;
    const values = [id, fname, surname, country, date_of_birth, sex];
    await pool.query(query, values);

    res.status(200).json({ message: `Dane zawodnika o ID ${id} zostały pomyślnie zaaktualizowane.` });
  } catch (err) {
    console.error('Błąd podczas aktualizowania:', err.message);
    res.status(500).json({ message: 'Błąd podczas aktualizowania.' });
  }
});


app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
  