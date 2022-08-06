FROM rust:1.61 as builder
RUN USER=root

RUN mkdir rocket-docker
WORKDIR /rocket-docker
ADD . ./
RUN cargo clean && cargo build --release

FROM debian:bullseye-slim
ARG APP=/user/src/app
RUN mkdir -p {$APP}

# Copy the compiled binaries into the new container.
COPY --from=builder /rocket-docker/target/release/rocket-docker ${APP}/rocket-docker
COPY --from=builder /rocket-docker/Rocket.toml ${APP}/Rocket.toml

WORKDIR ${APP}

EXPOSE 8000

CMD ["./rocket-docker"]


# config from https://github.com/SergioBenitez/Rocket/discussions/2257#discussioncomment-3336752
