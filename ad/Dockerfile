FROM registry-cn-zhangjiakou.ack.aliyuncs.com/acs/vpa-admission-controller:1.0.0 AS builder


FROM registry-cn-hangzhou.ack.aliyuncs.com/dev/alpine:3.20-update
COPY --from=builder /admission-controller /admission-controller

ENTRYPOINT ["/admission-controller"]
CMD ["--v=4", "--stderrthreshold=info"]