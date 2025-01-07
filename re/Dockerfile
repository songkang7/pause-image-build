FROM registry-cn-zhangjiakou.ack.aliyuncs.com/acs/vpa-recommender:1.0.0 AS builder


FROM registry-cn-hangzhou.ack.aliyuncs.com/dev/alpine:3.20-update
COPY --from=builder /recommender /recommender

ENTRYPOINT ["/recommender"]
CMD ["--v=4", "--stderrthreshold=info", "--prometheus-address=http://prometheus.monitoring.svc"]