FROM --platform=$BUILDPLATFORM docker.io/library/debian:latest as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG BUILDARCH
ARG TARGETARCH

# 设置工作目录
WORKDIR /app

COPY recommender-${TARGETARCH} recommender

RUN echo "I am running on $BUILDPLATFORM $BUILDARCH, building for $TARGETPLATFORM $TARGETARCH" > /log

FROM --platform=$TARGETPLATFORM registry-cn-hangzhou.ack.aliyuncs.com/dev/alpine:3.20-update

COPY --from=builder /app/recommender /recommender
ENTRYPOINT ["/recommender"]
CMD ["--v=4", "--stderrthreshold=info", "--prometheus-address=http://prometheus.monitoring.svc"]


