# ⚽ World Cup Database Project

This is a PostgreSQL relational database project built for the FreeCodeCamp Relational Database certification.

It stores World Cup match data and allows SQL queries to analyze teams, matches, and tournament results.

---

## 📁 Project Files

* `games.csv` – Raw match data
* `worldcup.sql` – Database schema and data dump
* `insert_data.sh` – Bash script to import CSV data into PostgreSQL
* `queries.sh` – SQL queries for analysis
* `expected_output.txt` – Expected results for validation

---

## ⚙️ How to Use

### 1. Create database

```bash id="db1"
psql -U postgres -c "CREATE DATABASE worldcup;"
```

### 2. Import database

```bash id="db2"
psql -U postgres -d worldcup -f worldcup.sql
```

### 3. Insert data using script

```bash id="db3"
chmod +x insert_data.sh
./insert_data.sh
```

---

## 📊 Example Queries

### Teams who played in 2014 Eighth-Final:

```sql id="db4"
SELECT DISTINCT name
FROM teams
JOIN games
  ON teams.team_id = games.winner_id
  OR teams.team_id = games.opponent_id
WHERE year = 2014
  AND round = 'Eighth-Final';
```

### Winner of 2018 World Cup:

```sql id="db5"
SELECT t.name
FROM games g
JOIN teams t ON g.winner_id = t.team_id
WHERE g.year = 2018
  AND g.round = 'Final';
```

---

## 🧠 What I Learned

* PostgreSQL relational database design
* Bash scripting for automation
* CSV data import handling
* SQL JOIN operations
* Data normalization (teams vs games)

---

## 📌 Author

Built by Nyenggggg as part of FreeCodeCamp certification.
