#!/bin/sh

cat > .github/workflows/build-and-push.yaml <<EOF
name: Build and Push

on:
  push:
    branches: [ main ]
  schedule:
    - cron: "0 0 * * 5"

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: docker/setup-buildx-action@v2
      - uses: docker/login-action@v2
        with:
          registry: ghcr.io
          username: \${{ secrets.CR_USER }}
          password: \${{ secrets.CR_PAT }}
EOF

for IMAGE in $(ls images); do
cat >> .github/workflows/build-and-push.yaml <<EOF
      - name: Build ${IMAGE}
        continue-on-error: true
        uses: docker/build-push-action@v4
        with:
          context: ./images/${IMAGE}
          push: true
          tags: ghcr.io/fancl20/${IMAGE}:latest
EOF
done