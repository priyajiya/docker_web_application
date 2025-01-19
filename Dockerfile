# Stage 1: Build the backend application
FROM maven:3.8.7-openjdk-17 AS backend-build
WORKDIR /backend
COPY backend/pom.xml .
COPY backend/src ./src
RUN mvn clean package -DskipTests

# Stage 2: Build the frontend application
FROM node:18-alpine AS frontend-build
WORKDIR /frontend
COPY frontend/package.json frontend/package-lock.json ./

# Remove node_modules if it exists and install dependencies
RUN rm -rf /frontend/node_modules
RUN npm cache clean --force
RUN npm install -g npm@latest
RUN npm ci --prefer-offline --no-audit --loglevel verbose

COPY frontend ./ 
RUN npm run build

# Stage 3: Create the final runtime image
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the backend JAR file
COPY --from=backend-build /backend/target/*.jar backend.jar

# Copy the frontend build files
COPY --from=frontend-build /frontend/build /frontend

# Expose backend and frontend ports
EXPOSE 8080 80

# Start the backend application
CMD ["java", "-jar", "backend.jar"]

