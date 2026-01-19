# Start the Evolution API with proper database migration
if [ -f "./Docker/scripts/deploy_database.sh" ]; then
  echo "Running database deployment script..."
  . ./Docker/scripts/deploy_database.sh
fi

echo "Starting Evolution API..."
npm run start:prod
