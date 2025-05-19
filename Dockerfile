# Build stage
FROM maven:latest
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Deploy stage
FROM tomcat:9.0.56-jdk17
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8081
ENTRYPOINT ["catalina.sh", "run"]

