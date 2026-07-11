###############
# COMPILATION #
###############

FROM docker.io/library/debian:bookworm-slim AS BUILDER

ARG SYSTEM=linux
ARG ARCH=x86_64
ARG STAGE=alpha
ARG ACTION=compile

ENV SYSTEM=${SYSTEM}
ENV ARCH=${ARCH}
ENV STAGE=${STAGE}
ENV ACTION=${ACTION}

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    clang \
    make \
    ca-certificates \
    pkg-config \
    gcc-i686-linux-gnu \
    gcc-arm-linux-gnueabi \
    gcc-riscv64-linux-gnu \
    gcc-x86_64-w64-mingw32 \
    gcc-i686-w64-mingw32 \
    gcc-x86-64-linux-gnu \
    gcc-aarch64-linux-gnu \
    gcc-arm-linux-gnueabihf \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /project

# COPY data/ ./data/
#
# COPY tool/ ./tool/
#
# COPY external/ ./external/
#
# COPY Makefile ./
#
# COPY test/ ./test/
#
# COPY internal/ ./internal/
#
# COPY main.c ./main.c

RUN make SYSTEM=${SYSTEM} ARCH=${ARCH} STAGE=${STAGE} -j$(nproc) ${ACTION}

#############
# EXECUTION #
#############

FROM gcr.io/distroless/base-nossl-debian12

ARG ARCH=amd64
ENV ARCH=${ARCH}

RUN useradd -r -u 1001 -g users appuser

WORKDIR /app

COPY --from=BUILDER /build/program /app/program

RUN chown -R appuser:users /app && chmod 0755 /app/program

USER appuser

ENV PATH="/app:${PATH}"

ENTRYPOINT ["./program"]
