# Step 1: Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Step 2: Runtime stage
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Create a non-root user with UID 1000 required by Hugging Face Spaces
RUN useradd -m -u 1000 appuser
USER appuser

# Copy the compiled jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the mandatory Hugging Face port
EXPOSE 7860

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
