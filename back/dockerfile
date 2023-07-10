FROM maven:3.8.3-openjdk-17

WORKDIR /app
COPY pom.xml pom.xml
RUN mvn dependency:go-offline
COPY ./ ./
RUN mvn package

FROM openjdk:17-jdk-alpine
copy --from=0 /app/target/*.jar ./app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
