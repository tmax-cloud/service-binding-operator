FROM quay.io/redhat-developer/go-toolset:builder-golang-1.17 as builder

WORKDIR /workspace
COPY / /workspace/

# Build
RUN make build

FROM quay.io/redhat-developer/servicebinding-operator@sha256:e01016cacae84dfb6eaf7a1022130e7d95e2a8489c38d4d46e4f734848e93849

WORKDIR /
COPY --from=builder /workspace/bin/manager .
USER 65532:65532

# COPY sh /bin/sh
ENTRYPOINT ["/manager", "--zap-encoder=json"]
