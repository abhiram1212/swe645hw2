# Use the official Tomcat 9 image
FROM tomcat:9.0

# Copy the WAR file to the webapps directory in Tomcat
COPY surveyform.war /usr/local/tomcat/webapps/