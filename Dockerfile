FROM ghcr.io/cirruslabs/flutter:3.16.0
RUN uname -a
RUN apt-get update && apt-get -y install php-common php-cli php
RUN pwd
RUN ls

COPY ./ ./
WORKDIR ./

RUN flutter build web --renderer canvaskit
ENTRYPOINT php -S localhost:8080 -t ./build/web/
