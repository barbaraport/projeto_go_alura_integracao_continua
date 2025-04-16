FROM golang:1.22-alpine AS build

WORKDIR /app

COPY ./controllers/ /app/controllers/
COPY ./database/ /app/database/
COPY ./models/ /app/models/
COPY ./routes/ /app/routes/
COPY ./main.go /app/main.go
COPY ./go.mod /app/go.mod
COPY ./go.sum /app/go.sum

RUN go build main.go

FROM alpine:latest AS production

ARG APP_IMAGE_PORT
ARG DB_HOST_PORT
ARG DB_HOST
ARG DB_USER
ARG DB_PASSWORD
ARG DB_NAME

ENV DB_HOST=${DB_HOST}
ENV DB_USER=${DB_USER}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV DB_NAME=${DB_NAME}
ENV DB_PORT=${DB_HOST_PORT}

EXPOSE ${APP_IMAGE_PORT}

WORKDIR /app

COPY ./assets/ /app/assets/
COPY ./templates/ /app/templates/

COPY --from=build /app/main /app/main

CMD [ "./main" ]