FROM crystallang/crystal

RUN apt-get update && \
    apt-get install -y postgresql-client

WORKDIR /app

COPY . .

RUN shards install
RUN crystal build --release src/api.cr -o api


CMD ["./api"]