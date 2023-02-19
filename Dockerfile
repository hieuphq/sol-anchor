# FROM --platform=linux/arm64 debian:buster
# FROM ubuntu:20.04 as amd64
# FROM arm64v8/ubuntu:20.04

FROM --platform=linux/amd64 hieuphq/sol:latest

# RPC JSON
EXPOSE 8899/tcp
# RPC pubsub
EXPOSE 8900/tcp
# entrypoint
EXPOSE 8001/tcp
# (future) bank service
EXPOSE 8901/tcp
# bank service
EXPOSE 8902/tcp
# faucet
EXPOSE 9900/tcp
# tvu
EXPOSE 8000/udp
# gossip
EXPOSE 8001/udp
# tvu_forwards
EXPOSE 8002/udp
# tpu
EXPOSE 8003/udp

# tpu_forwards
EXPOSE 8004/udp
# retransmit
EXPOSE 8005/udp
# repair
EXPOSE 8006/udp
# serve_repair
EXPOSE 8007/udp
# broadcast
EXPOSE 8008/udp

ARG ANCHOR_VERSION=0.26.0
# Install anchor-cli
RUN . ~/.cargo/env && echo $PATH && \
    cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
RUN . ~/.cargo/env && echo $PATH && avm install ${ANCHOR_VERSION} && avm use ${ANCHOR_VERSION}
# avm use ${ANCHOR_VERSION}


# ARG ANCHOR_VERSION=0.26.0
# RUN . ~/.cargo/env && echo $PATH && \
#     cargo install --git https://github.com/coral-xyz/anchor --tag v${ANCHOR_VERSION} anchor-cli --locked


# RUN git clone --branch v${ANCHOR_VERSION} https://github.com/project-serum/anchor.git && \
#     cd anchor/cli && \
#     cargo install --path . --locked --force --features="no-self-update"

# ENV PATH=/opt/anchor/target/release:/opt/solana-${SOLANA_VERSION}/bin:$PATH

# # Update bashrc
# RUN echo 'PATH=$PATH:/$PATH:/opt/solana-${SOLANA_VERSION}/bin' >> ~/.bashrc

# there can be only one CMD instruction
CMD ["/bin/bash"]
# CMD ["tail", "-f", ""]