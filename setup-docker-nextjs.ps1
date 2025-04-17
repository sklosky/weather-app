# Create docker-compose.yml file
$composeContent = @"
services:
  app:
    image: node:alpine
    container_name: nextjs-typescript-dev
    working_dir: /app
    ports:
      - "3000:3000"
    tty: true
    stdin_open: true
"@

$composeFilePath = "docker-compose.yml"
Set-Content -Path $composeFilePath -Value $composeContent
Write-Host "✅ Created docker-compose.yml with Alpine Linux Node.js configuration" -ForegroundColor Green

# Build and start the container
Write-Host "🔄 Building and starting Docker container..." -ForegroundColor Yellow
docker-compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to start Docker container" -ForegroundColor Red
    exit 1
}

# Wait a moment for container to fully start
Start-Sleep -Seconds 3

docker exec -it nextjs-typescript-dev sh -c "cd /app && npm install -g npm@latest"
docker exec -it nextjs-typescript-dev sh -c "cd /app && npx create-next-app@latest --ts --no-git --use-npm --yes weather"