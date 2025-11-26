$ErrorActionPreference = "Stop"

Write-Host "--------------------------------------------------"
Write-Host "      Talnt Docker - Local Build & Push"
Write-Host "--------------------------------------------------"

# 1. Check if Docker is running
try {
    docker info > $null
} catch {
    Write-Error "Docker is not running! Please start Docker Desktop and try again."
    exit 1
}

# 2. Get Username
$username = Read-Host "Enter your Docker Hub username"
if ([string]::IsNullOrWhiteSpace($username)) {
    Write-Error "Username cannot be empty."
    exit 1
}

# 3. Login
Write-Host "`n[1/3] Logging into Docker Hub..."
docker login -u $username

# 4. Build
$imageName = "$username/talnt-frontend:latest"
Write-Host "`n[2/3] Building image: $imageName..."
docker build -t $imageName .

# 5. Push
Write-Host "`n[3/3] Pushing image to Docker Hub..."
docker push $imageName

Write-Host "`n--------------------------------------------------"
Write-Host "SUCCESS! Image pushed to: $imageName"
Write-Host "--------------------------------------------------"
