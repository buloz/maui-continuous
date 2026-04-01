#!/bin/bash
set -e

BUILD_CONFIG="${BUILD_CONFIG:-Release}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-/artifacts}"
SLN="${SLN:-src/MauiBlazorApp/MauiBlazorApp.slnx}"

echo "Restore..."
dotnet restore "$SLN"

echo "Build..."
dotnet build "$SLN" \
    --no-restore \
    -c $BUILD_CONFIG
# cat build.log

echo "Test..."
dotnet test "$SLN" \
    --no-build \
    -c $BUILD_CONFIG \
    --logger "trx;LogFileName=test_results.trx" \
    --results-directory $ARTIFACTS_DIR

echo "Collect artifacts..."
mkdir -p $ARTIFACTS_DIR
cp build.log $ARTIFACTS_DIR/ || true

echo "Done."