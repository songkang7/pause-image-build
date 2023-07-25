# 使用支持多架构的基础镜像
FROM --platform=$BUILDPLATFORM docker.io/library/debian:latest as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG BUILDARCH
ARG TARGETPLATFORM
ARG TARGETARCH
# 设置工作目录
WORKDIR /app

COPY pause.c .

RUN apt-get update -y

RUN if [ $BUILDPLATFORM = "linux/amd64" ]; then \
        apt-get install -y gcc; \
        gcc -o pause pause.c; \
    fi

RUN if [ $BUILDPLATFORM = "linux/arm64" ]; then \
            apt-get install -y gcc-aarch64-linux-gnu libc6-dev-arm64-cross; \
            aarch64-linux-gnu-gcc -o pause pause.c; \
    fi


RUN echo "I am running on $BUILDPLATFORM $BUILDARCH, building for $TARGETPLATFORM $TARGETARCH" > /log

FROM --platform=$BUILDPLATFORM docker.io/library/debian:latest

# 复制可执行文件
COPY --from=builder /app/pause /pause

# 设置默认执行命令
ENTRYPOINT ["/pause"]