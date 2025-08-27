FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update && apt-get install -y \
    wget git build-essential cmake libuv1-dev libssl-dev libhwloc-dev && \
    rm -rf /var/lib/apt/lists/*

# Get xmrig miner
RUN git clone https://github.com/xmrig/xmrig.git && \
    cd xmrig && mkdir build && cd build && \
    cmake .. && make -j$(nproc)

COPY config.json /app/config.json
COPY miner.sh /app/miner.sh

RUN chmod +x /app/miner.sh

CMD ["./miner.sh"]
