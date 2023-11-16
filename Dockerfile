FROM ghcr.io/cirruslabs/flutter:3.16.0
RUN apt install php-common php-cli
RUN pwd
RUN ls

COPY ./ ./
WORKDIR ./

RUN flutter build web --renderer canvaskit
ENTRYPOINT php -S localhost:8080 -t ./build/web/
