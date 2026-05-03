# E-commerce Database

This repository contains the database schema and migration scripts for the E-commerce project. The project uses PostgreSQL as its core database and relies on [Flyway](https://flywaydb.org/) for robust, schema-based version control and database migrations.

## 🏗️ Project Architecture

The database is modularized into distinct schemas to maintain a clean separation of concerns. Flyway migrations are configured to run out-of-order safely, allocating specific version ranges per schema:

- **`identity`** (`V0001` - `V0999`): Handles user accounts, authentication sessions, and roles.
- **`sales`** (`V1000` - `V1999`): Manages user carts, orders, and order products.
- **`inventories`** (`V2000` - `V2999`): Manages products, variants (colors, sizes), categories, images, and stocks.

## 📂 Directory Structure

```text
e-commerce-database/
├── dev-workspace/
│   ├── create-database.bat       # Script to spin up Postgres via Docker
│   └── create-migration.bat      # CLI tool to generate new Flyway migration files
├── env/
│   └── flyway.local.conf         # Local environment DB connection configurations
├── migrations/
│   ├── identity/                 # Identity schema migrations
│   │   ├── data/                 # Seed data (DML)
│   │   └── structure/            # Table definitions (DDL)
│   ├── inventories/              # Inventories schema migrations
│   │   ├── data/
│   │   └── structure/
│   └── sales/                    # Sales schema migrations
│       ├── data/
│       └── structure/
├── docker-compose.yaml           # Docker setup for local PostgreSQL
├── flyway.conf                   # Global Flyway configuration
└── README.md
```

## 🚀 Getting Started

### 1. Start the Local Database

Ensure Docker Desktop is running on your machine. You can use the provided batch script to automatically spin up the Docker container and initialize the database instance safely:

```bash
# Run the database setup script from the project root
.\dev-workspace\create-database.bat
```

_(Alternatively, you can manually run `docker compose up -d`)_

### 2. Run Database Migrations

To apply the database structures and create all schemas and tables, execute Flyway with the local configuration file:

```bash
flyway -configFiles="flyway.conf","env/flyway.local.conf" migrate
```

## 🛠️ Commonly Used Commands

### Flyway CLI Commands

- **Apply Migrations** (Sync your database with the latest SQL files):
  ```bash
  flyway -configFiles="flyway.conf","env/flyway.local.conf" migrate
  ```
- **Check Migration Status** (View applied and pending migrations):
  ```bash
  flyway -configFiles="flyway.conf","env/flyway.local.conf" info
  ```
- **Clean Database** (⚠️ Drops all objects - use for local resets only):
  ```bash
  flyway -configFiles="flyway.conf","env/flyway.local.conf" clean
  ```

### Developer Helper Scripts

We provide built-in scripts in the `dev-workspace/` directory to automate daily tasks:

- **`create-migration.bat`**: Run this script to interactively generate a new `.sql` migration file. It will prompt you for the ticket number, description, and target schema, then automatically calculate the next available version number (e.g., `V1001`) based on the schema's assigned range.

## 🔗 Cross-Schema Dependencies

Foreign key constraints between different schemas (e.g., `sales.carts` referencing `inventories.products`) are consolidated into a final migration script (`V2001__inventories_structure__create_foreign_keys.sql`). Because Flyway executes migrations sequentially by version number, this guarantees that all baseline tables across all schemas (V0001, V1000, V2000) are fully established before relationships are mapped out, preventing table-not-found errors.
