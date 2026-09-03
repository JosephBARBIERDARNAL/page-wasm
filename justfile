default:
    @just --list

fmt:
    cargo fmt --all
    npm run format

fmt-check:
    cargo fmt --all -- --check
    npm run format:check

lint:
    cargo clippy --all-targets --all-features -- -D warnings
    npm run lint

build:
    npm run build

test:
    cargo test --all-features
    npm test

check: fmt-check lint test

