#syntax=docker/dockerfile:1.2
FROM alpine:3.13.5 as builder

ARG GH_VERSION=1.10.3
RUN apk add --no-cache git libc6-compat wget rsync && \
    wget https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz && \
    tar -zxvf gh_${GH_VERSION}_linux_amd64.tar.gz && \
    chmod +x gh_${GH_VERSION}_linux_amd64/bin/gh && \
    rsync -az --remove-source-files gh_${GH_VERSION}_linux_amd64/bin/ /usr/bin

FROM alpine:3.13.5 as gh

COPY --from=builder /usr/bin/git /usr/bin/gh /usr/bin/

RUN gh --version

ENTRYPOINT ["/usr/bin/gh"]
