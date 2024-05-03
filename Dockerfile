# setup working directory
FROM maven:3.5.3 AS build
#RUN mkdir /app
WORKDIR /java-webapp-docker

# maven build
COPY src /java-webapp-docker/src
COPY pom.xml /java-webapp-docker
RUN mvn -f /app/pom.xml clean package

# deploy to tomcat server
FROM tomcat:9.0.44
COPY --from=build /java-webapp-docker/target/simplewebapp.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
