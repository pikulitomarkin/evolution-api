export_env_vars() {
    if [ -f .env ]; then
        # Salvar variáveis importantes do Railway antes de carregar o .env
        RAILWAY_DATABASE_URL="$DATABASE_URL"
        RAILWAY_PORT="$PORT"
        
        while IFS='=' read -r key value; do
            if [[ -z "$key" || "$key" =~ ^\s*# || -z "$value" ]]; then
                continue
            fi

            key=$(echo "$key" | tr -d '[:space:]')
            value=$(echo "$value" | tr -d '[:space:]')
            value=$(echo "$value" | tr -d "'" | tr -d "\"")

            # Não sobrescrever DATABASE_URL ou PORT se já existirem (Railway)
            if [[ "$key" == "DATABASE_URL" || "$key" == "DATABASE_CONNECTION_URI" ]] && [ -n "$RAILWAY_DATABASE_URL" ]; then
                continue
            fi
            if [[ "$key" == "PORT" ]] && [ -n "$RAILWAY_PORT" ]; then
                continue
            fi

            export "$key=$value"
        done < .env
        
        # Restaurar variáveis do Railway e garantir DATABASE_CONNECTION_URI
        if [ -n "$RAILWAY_DATABASE_URL" ]; then
            export DATABASE_URL="$RAILWAY_DATABASE_URL"
            export DATABASE_CONNECTION_URI="$RAILWAY_DATABASE_URL"
        fi
        if [ -n "$RAILWAY_PORT" ]; then
            export PORT="$RAILWAY_PORT"
        fi
    else
        echo ".env file not found"
        exit 1
    fi
}
