FROM bitnami/git AS git-s7comm
RUN git clone https://github.com/nicolasme/s7comm.git

FROM golang:1.22.0-alpine AS binary-s7comm
COPY --from=git-s7comm ./s7comm/ /s7comm/
WORKDIR /s7comm
RUN sed -i 's/false/true/' cmd/main.go && go build -o s7comm cmd/main.go

FROM telegraf:1.29.4-alpine
COPY --from=binary-s7comm /s7comm/s7comm /usr/local/bin/s7comm
