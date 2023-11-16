FROM ghcr.io/cirruslabs/flutter:3.16.0
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get -y install php-common php-cli php

COPY ./ ./
RUN flutter build web --renderer canvaskit
ENTRYPOINT php -S localhost:8080 -t ./build/web/
