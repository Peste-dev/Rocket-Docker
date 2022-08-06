FROM rust:1.61 as builder
RUN USER=root

RUN mkdir rocket-docker-test
WORKDIR /rocket-docker-test
ADD . ./
RUN cargo clean && cargo build --release

FROM debian:bullseye
ARG APP=/user/src/app
RUN mkdir -p {$APP}

# Copy the compiled binaries into the new container.
COPY --from=builder /rocket-docker-test/target/release/rocket-docker-test ${APP}/rocket-docker-test
COPY --from=builder /rocket-docker-test/Rocket.toml ${APP}/Rocket.toml

WORKDIR ${APP}

EXPOSE 80

CMD ["./rocket-docker-test"]


# config from https://github.com/SergioBenitez/Rocket/discussions/2257#discussioncomment-3336752


# FROM alpine:latest
# RUN apk --no-cache add ca-certificates
# COPY ./webapp /bin/
# COPY ./Rocket.toml .
# ENV ROCKET_ENV development
# EXPOSE 8000
# ENTRYPOINT ["/bin/webapp"]
