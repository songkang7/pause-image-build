FROM registry-cn-zhangjiakou-vpc.ack.aliyuncs.com/acs/vpa-updater:1.0.0 AS builder


FROM registry-cn-hangzhou.ack.aliyuncs.com/dev/alpine:3.20-update
COPY --from=builder /updater /updater

ENTRYPOINT ["/updater"]
CMD ["--v=4", "--stderrthreshold=info"]