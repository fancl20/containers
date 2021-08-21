#!/bin/sh

cat > .github/workflows/build-and-push.yaml <<EOF
name: build and push

on:
  push:
    branches: [ main ]
  schedule:
    - cron: "0 0 * * 0"

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: docker/setup-buildx-action@v1
      - uses: docker/login-action@v1
        with:
          registry: ghcr.io
          username: \${{ secrets.CR_USER }}
          password: \${{ secrets.CR_PAT }}
EOF

for IMAGE in $(ls images); do
cat >> .github/workflows/build-and-push.yaml <<EOF
      - uses: docker/build-push-action@v2
        with:
          context: ./images/${IMAGE}
          push: true
          tags: ghcr.io/fancl20/${IMAGE}:latest
EOF
done