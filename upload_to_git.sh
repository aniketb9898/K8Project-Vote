#!/bin/bash

# Go to the correct project folder
cd ~/Desktop/"Kubernetes Project" || exit

echo "🔁 Setting up project folder..."

# Create the templates folder and move the HTML file
mkdir -p templates
mv templatesvote.html templates/vote.html 2>/dev/null

# Rename the Python files properly
mv frontendapp.py app_frontend.py 2>/dev/null
mv backendapp.py app_backend.py 2>/dev/null

echo "✅ File structure prepared."

# Create Dockerfile for frontend
cat <<EOF > Dockerfile_frontend
FROM python:3.9-slim
WORKDIR /app
COPY app_frontend.py .
COPY templates ./templates
RUN pip install flask requests
CMD ["python", "app_frontend.py"]
EOF

# Create Dockerfile for backend
cat <<EOF > Dockerfile_backend
FROM python:3.9-slim
WORKDIR /app
COPY app_backend.py .
RUN pip install flask redis
CMD ["python", "app_backend.py"]
EOF

echo "🐳 Dockerfiles created."

# Build Docker images
docker build -t vote-frontend -f Dockerfile_frontend .
docker build -t vote-backend -f Dockerfile_backend .

echo "✅ Docker images built successfully."

# Create README.md
cat <<EOF > README.md
# K8Project-Vote

Kubernetes-based secure voting app using Flask and Redis.

## What it does:
- Users vote for AWS, GCP, Azure, or OCI
- Frontend captures vote via unique URL
- Backend stores vote using Redis

## Kubernetes Features:
- Secrets
- RBAC
- NetworkPolicy
- Pod Security Standards
- Trivy image scan

## Run Locally:
http://localhost:5000/vote/<your-name>

## Author:
Aniket B
EOF

# Create .gitignore
echo -e "__pycache__/\n*.pyc\n*.DS_Store" > .gitignore

echo "📝 README and .gitignore created."

# Git commands
git init
git remote add origin https://github.com/aniketb9898/K8Project-Vote.git
git add .
git commit -m "Initial commit with Docker and Flask voting app"
git branch -M main
git push -u origin main

echo "🚀 Project pushed to GitHub: https://github.com/aniketb9898/K8Project-Vote"

