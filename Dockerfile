#1
FROM openjdk:14-jdk-buster AS development

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

  #Comandos que se ejecutan por default
 CMD ["gradle", "bootRun"] 

# Testing

FROM development AS testing

COPY . /usr/src

CMD ["gradle", "test"]

# Builder

FROM testing AS builder

RUN gradle build -x test

# Realease
FROM openjdk:14-jdk-buster AS release

COPY --from=builder /usr/src/build/libs/demo-0.0.1-SNAPSHOT.jar .

CMD [ "java", "-jar", "demo.0.0.1-SNAPSHOT.jar" ]

# Comandos Default