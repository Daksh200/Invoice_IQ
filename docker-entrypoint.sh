#!/bin/sh
set -e

# Render-managed PostgreSQL requires SSL. Enable it for the psql healthcheck.
export PGSSLMODE="${PGSSLMODE:-require}"

# Wait for database to be ready using psql and the full DATABASE_URL
# (which includes the database name, so psql connects to an existing DB).
echo "Waiting for PostgreSQL server to be ready at $DATABASE_URL..."
until psql "$DATABASE_URL" -c '\q' >/dev/null 2>&1; do
  echo "PostgreSQL server is unavailable - sleeping"
  sleep 1
done
echo "PostgreSQL server is ready!"

# Run database migrations
echo "Running database migrations..."
npx prisma migrate deploy

echo "Starting: $*"
exec "$@"
