q#!/bin/sh
set -e

# Extract server part from DATABASE_URL (remove database name)
SERVER_URL=$(echo "$DATABASE_URL" | sed 's/\/[^/]*$//')

# Render-managed PostgreSQL requires SSL. Enable it for the psql healthcheck.
export PGSSLMODE="${PGSSLMODE:-require}"

# Wait for database to be ready using psql and SERVER_URL
echo "Waiting for PostgreSQL server to be ready at $SERVER_URL..."
until psql "$SERVER_URL" -c '\q' >/dev/null 2>&1; do
  echo "PostgreSQL server is unavailable - sleeping"
  sleep 1
done
echo "PostgreSQL server is ready!"

# Run database migrations
echo "Running database migrations..."
npx prisma migrate deploy

echo "Starting: $*"
exec "$@"
