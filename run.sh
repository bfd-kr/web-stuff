#!/bin/bash

# Build and Run Script for Web Apps
# This script builds the Docker image and runs the container in detached mode

set -e  # Exit on error

CONTAINER_NAME="web-apps-container"
IMAGE_NAME="web-apps"
PORT="8080"

echo "🏗️  Building Docker image..."
nerdctl build -t $IMAGE_NAME .

echo ""
echo "🧹 Cleaning up any existing containers..."
# Stop and remove existing container if it exists (ignore errors if it doesn't)
nerdctl stop $CONTAINER_NAME 2>/dev/null || true
nerdctl rm $CONTAINER_NAME 2>/dev/null || true

echo ""
echo "🚀 Starting container..."
nerdctl run -d \
  --name $CONTAINER_NAME \
  -p $PORT:80 \
  $IMAGE_NAME

echo ""
echo "✅ Container is running!"
echo "📱 Access the application at: http://localhost:$PORT"
echo "🏁 View the Name Race game at: http://localhost:$PORT/name-race.html"
echo ""
echo "To stop and remove the container, run:"
echo "   nerdctl stop $CONTAINER_NAME && nerdctl rm $CONTAINER_NAME"
echo ""
echo "To view logs, run:"
echo "   nerdctl logs -f $CONTAINER_NAME"
