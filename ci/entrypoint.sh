#!bin/bash
set -e

BUILD_CONFIG="${BUILD_CONFIG:-Release}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-/artifacts}"
WORKSPACE="/workspace"

echo "Restore..."
dotnet restore

echo "Build..."
dotnet build --no-restore -c $BUILD_CONFIG > build.log
cat build.log

echo "Test..."
dotnet test \
    --no-build \
    -c $BUILD_CONFIG \
    --logger "trx;LogFileName=tests_results.trx" \
    --logger "console;verbosity=normal" \
    --results-directory $ARTIFACTS_DIR 
cat tests_results.trx

echo "Collect artifacts..."
mkdir -p $ARTIFACTS_DIR
cp -r $WORKSPACE/artifacts/* $ARTIFACTS_DIR/ || true

echo "Done."