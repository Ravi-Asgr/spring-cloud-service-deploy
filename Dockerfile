# Stage 1: build with Maven and Temurin JDK
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /workspace

# Copy only what is needed for dependency resolution first (speeds up rebuilds)
COPY pom.xml .
COPY src ./src

# Build the application jar (skip tests for faster builds; remove -DskipTests for CI)
RUN mvn -B -DskipTests package

# Stage 2: runtime image using Temurin JRE
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy the fat jar from the builder stage
COPY --from=builder /workspace/target/*.jar app.jar

# Recommended JVM options; tune Xmx for your host
ENV JAVA_OPTS="-Xms256m -Xmx1024m"
ENV PORT=8080

EXPOSE 8080

# Entrypoint uses the PORT env so platforms like Railway/Render pick it up
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /app/app.jar --server.port=${PORT}"]
