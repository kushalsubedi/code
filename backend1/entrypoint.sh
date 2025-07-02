#!/bin/sh

if [ -f .env ]; then
  echo "🔄 Loading environment variables from .env"
  export $(grep -v '^#' .env | xargs)
fi

echo "⏳ Waiting for DB on $DB_HOST:$DB_PORT..."

until nc -z "$DB_HOST" "$DB_PORT"; do
  sleep 1
done

echo "✅ DB is ready!"

echo "🚀 Running migrations..."
yarn migrate

echo "✅ Starting the server..."
yarn start

