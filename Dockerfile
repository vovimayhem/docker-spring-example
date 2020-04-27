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

  #step  Define default command: son los comandos que se ejecutan por default
 CMD ["gradle", "bootRun"] 

# STAGE TESTING ==========================================================================================================

FROM development AS testing

COPY . /usr/src

CMD ["gradle", "test"]

# STAGE BUILDER ==========================================================================================================

FROM testing AS builder

RUN gradle build -x test

# STAGER RELEASE Release se comienza con a imagen oficiakl y en lugar de instalar todo solo copiamos lo que sirve de la maquina anterior, el jar
FROM openjdk:14-jdk-buster AS release

COPY --from=builder /usr/src/build/libs/demo-0.0.1-SNAPSHOT.jar .

CMD [ "java", "-jar", "demo.0.0.1-SNAPSHOT.jar" ]

# Comandos Default