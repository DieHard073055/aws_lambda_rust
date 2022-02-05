#! /bin/bash
LAMBDA_ARCH="linux/arm64"
RUST_TARGET="aarch64-unknown-linux-gnu"
RUST_VERSION="latest"
PROJECT_NAME="aws_lambda_rust"

al2build() {
    echo sudo docker run --platform ${LAMBDA_ARCH} \
        --rm --user "$(id -u)":"$(id -g)" \
        -v "${PWD}":/usr/src/myapp -w /usr/src/myapp rust:${RUST_VERSION} \
        cargo build release --target ${RUST_TARGET}
}

zipRustLambda() {
    cp ./target/${RUST_TARGET}/release/${PROJECT_NAME} ./bootstrap \
        && zip lambda.zip bootstrap \
        && rm bootstrap
}

al2build
