FROM --platform=$BUILDPLATFORM docker.io/library/debian:latest as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG BUILDARCH
ARG TARGETARCH

# 设置工作目录
WORKDIR /app

COPY pause-linux-${TARGETARCH} pause

RUN echo "I am running on $BUILDPLATFORM $BUILDARCH, building for $TARGETPLATFORM $TARGETARCH" > /log

FROM --platform=$TARGETPLATFORM scratch

COPY --from=builder /app/pause /pause
USER 65535:65535
ENTRYPOINT ["/pause"]