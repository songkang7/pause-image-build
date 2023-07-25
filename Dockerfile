FROM --platform=$BUILDPLATFORM docker.io/library/debian:latest as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG BUILDARCH
ARG TARGETARCH
# 设置工作目录
WORKDIR /app

RUN apt-get update -y && apt-get install -y gcc && \
    apt-get install -y gcc-aarch64-linux-gnu libc6-dev-arm64-cross

COPY pause.c .

RUN if [ $TARGETARCH = "linux/amd64" ]; then \
        gcc -o pause pause.c; \
    fi

RUN if [ $TARGETARCH = "linux/arm64" ]; then \
        aarch64-linux-gnu-gcc -o pause pause.c; \
    fi

RUN echo "I am running on $BUILDPLATFORM $BUILDARCH, building for $TARGETPLATFORM $TARGETARCH" > /log

FROM --platform=$TARGETPLATFORM docker.io/library/debian:latest

COPY --from=builder /app/pause /pause

ENTRYPOINT ["/pause"]