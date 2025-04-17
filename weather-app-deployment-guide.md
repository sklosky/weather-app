# Weather App Deployment Guide for Windows
## Prerequisites

Before deploying the Weather App, ensure you have the following installed on your Windows system:

1. **Docker Desktop for Windows**
   - Download from [Docker's official website](https://www.docker.com/products/docker-desktop)
   - Make sure Docker Desktop is running before proceeding

2. **Windows PowerShell** (included with Windows 10/11)

## Deployment Instructions

### Step 1: Load the Weather App Docker Image

1. Open Windows PowerShell as Administrator
   - Right-click on the Start button
   - Select "Windows PowerShell (Admin)"

2. Navigate to the directory containing the weather-app.tar file
   ```powershell
   cd "c:\path\to\weather app"
   ```

3. Load the Docker image from the TAR file
   ```powershell
   docker load -i weather-app.tar
   ```
   
4. Verify the image was loaded successfully
   ```powershell
   docker images
   ```
   You should see "weather-app:latest" in the list of images

### Step 2: Run the Weather App Container

1. Start the container with the following command
   ```powershell
   docker run -d -p 3000:3000 --name weather-app-container weather-app:latest sh -c "cd /app/weather && npm start"
   ```

2. Verify the container is running
   ```powershell
   docker ps
   ```
   You should see "weather-app-container" in the list of running containers

3. Access the Weather App in your browser
   - Open your web browser
   - Navigate to [http://localhost:3000](http://localhost:3000)
   - The Weather App interface should appear

## Operating the Weather App

### Viewing Weather Forecasts

1. Enter your city and state in the input fields
2. The app will display the current weather and forecast options
3. Weather data is fetched from OpenWeather API

### Container Management Commands

#### View Application Logs
```powershell
docker logs weather-app-container
```

#### Stop the Container
```powershell
docker stop weather-app-container
```

#### Start the Container (after stopping)
```powershell
docker start weather-app-container
```

#### Remove the Container (when no longer needed)
```powershell
docker stop weather-app-container
docker rm weather-app-container
```

## Troubleshooting

### If the app fails to load in the browser
1. Check if the container is running
   ```powershell
   docker ps
   ```

2. Check container logs for errors
   ```powershell
   docker logs weather-app-container
   ```

3. Restart the container
   ```powershell
   docker restart weather-app-container
   ```

### If weather data doesn't appear
1. Verify you have internet connectivity
2. Check if the OpenWeather API key is functioning correctly
   - The app uses API key: `c99cc0cf008c04431230b61cef6181a4`
   - If needed, you can update the API key in the app's configuration

### If the container keeps restarting
1. Check logs for errors
   ```powershell
   docker logs weather-app-container
   ```

2. Try rebuilding the container with an interactive shell to troubleshoot
   ```powershell
   docker run -it --name weather-app-debug weather-app:latest sh
   cd /app/weather
   npm start
   ```

## System Requirements

- **Windows 10/11** (64-bit: Pro, Enterprise, or Education)
- **Docker Desktop for Windows**
- Minimum 4GB RAM allocated to Docker
- At least 10GB free disk space
- Internet connection for fetching weather data from API

## Backing Up Your Container Data

If you've made configuration changes or added data you want to preserve:

```powershell
docker commit weather-app-container weather-app:backup
docker save -o weather-app-backup.tar weather-app:backup
```

## Support

For issues with the Weather App deployment or functionality, please contact your system administrator or the development team.