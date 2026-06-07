# Use a stable Temurin JDK base
FROM eclipse-temurin:17-jdk-jammy

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

ENV JAVA_OPTS="-Xms256m -Xmx1024m"
ENV PORT=8080

EXPOSE 8080

ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /app.jar --server.port=${PORT}"]
