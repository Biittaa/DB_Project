# Banking System - Database Project

This project is a simple banking system designed to simulate core banking functionalities using SQL and Python. It includes database design, CRUD operations, and query handling.

## Features

- 🏦 Account and user management
- 💳 Deposit, withdrawal, and transfer operations
- 🔐 Access control and user roles
- 📄 Structured SQL files for tables, functions, and access
- ⚙️ Python scripts for handling CRUD and user requests

## Project Structure

| File / Folder               | Description                            |
|----------------------------|----------------------------------------|
| `DB_TABLES_PHASE1.session.sql` | Defines core tables for accounts, users, and transactions |
| `DB_INSERT_PHASE2.session.sql` | Contains initial and insert data queries |
| `access.session.sql`       | Defines access control and permissions |
| `functions.session.sql`    | Implements stored procedures and logic |
| `queries.session.sql`      | Read and write queries for banking operations |
| `CRUD.py` / `check_CRUD.py`| Python scripts for handling database operations |
| `request.py`               | Request handling logic                 |
| `models.py`                | Data models and database connection    |

## How to Run

1. Set up a PostgreSQL or MySQL database.
2. Run the `.sql` files in order:
   - `DB_TABLES_PHASE1.session.sql`
   - `access.session.sql`
   - `functions.session.sql`
   - `DB_INSERT_PHASE2.session.sql`

