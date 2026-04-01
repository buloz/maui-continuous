FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine AS build

RUN apk add --no-cache \
    bash \
    icu-libs \
    libstdc++ \
    git

ENV CI=true

WORKDIR /workspace

RUN dotnet workload install maui-android

COPY . .

RUN sed -i 's/\r$//' ci/entrypoint.sh \
    && chmod +x ci/entrypoint.sh

ENTRYPOINT ["/workspace/ci/entrypoint.sh"]