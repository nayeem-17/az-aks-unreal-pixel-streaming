# Update your Docker Hub username here
DOCKER_HUB_USER="n0x41yeem"  # Replace with your actual username
# Update your container registry name here (if applicable)
CONTAINER_REG= $DOCKER_HUB_USER

# Build Matchmaker image
cd Matchmaker/platform_scripts/bash
docker build -t matchmaker:4.27 -f Dockerfile ../..

# Build Signalling image
cd -
cd SignallingWebServer/platform_scripts/bash/
docker build -t signallingwebserver:4.27 -f ./Dockerfile ../..

# Build Unreal Engine App image
cd -
cd Game
docker build -t game:4.27 -f Dockerfile .

# Build TURN Server image
cd -
cd TURN
docker build -t turn -f Dockerfile .

# Build PlayerMonitor image
cd -
cd PlayerMonitor
docker build -t playermonitor -f Dockerfile .

# Build ScaleMonitor Image
cd -
cd ScaleMonitor
docker build -t scalemonitor -f Dockerfile .
cd -

# Tag and push images to Docker Hub
docker tag matchmaker:4.27 $DOCKER_HUB_USER/matchmaker:4.27
docker tag signallingwebserver:4.27 $DOCKER_HUB_USER/signallingwebserver:4.27
docker tag game:4.27 $DOCKER_HUB_USER/game:4.27
docker tag turn $DOCKER_HUB_USER/turn
docker tag playermonitor $DOCKER_HUB_USER/playermonitor
docker tag scalemonitor $DOCKER_HUB_USER/scalemonitor

# Authenticate with Docker Hub
echo "Please enter your Docker Hub password:"
docker login 

# Push images
docker push $DOCKER_HUB_USER/matchmaker:4.27
docker push $DOCKER_HUB_USER/signallingwebserver:4.27
docker push $DOCKER_HUB_USER/game:4.27
docker push $DOCKER_HUB_USER/turn
docker push $DOCKER_HUB_USER/playermonitor
docker push $DOCKER_HUB_USER/scalemonitor

# Optional: If you also want to push to Azure Container Registry
# (Make sure you're logged in to Azure CLI and replace with your registry name)
docker push $CONTAINER_REG/matchmaker:4.27
docker push $CONTAINER_REG/signallingwebserver:4.27
docker push $CONTAINER_REG/game:4.27
docker push $CONTAINER_REG/turn
docker push $CONTAINER_REG/playermonitor
docker push $CONTAINER_REG/scalemonitor
