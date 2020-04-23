FROM openjdk:14-jdk-buster

#2
WORKDIR /usr/src

#3
ENV HOME=/usr/src

# Definir las versiones
ENV GRADLE_VERSION=6.3 GRADKE_USER_HOME=/usr/local/gradle

# Add Gradle executable s to PATH
ENV PATH=/opt/gradle/gradle-${GRADLE_VERSION}/bin:${PATH}

# descargar Gradle
RUN curl -L -o "gradle-${GRADLE_VERSION}-bin.zip" \
  "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
 && mkdir -p /opt/gradle /usr/local/gradle \
 && unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip \
 && rm -rf "gradle-${GRADLE_VERSION}-bin.zip"