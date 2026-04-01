# Image SDK .NET (preview si .NET 10)
FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine AS build

RUN apk add --no-cache \
    bash \
    icu-libs \
    libstdc++ \
    git

RUN dotnet workload install maui-blazor

WORKDIR /workspace

COPY . .

RUN chmod +x /ci/entrypoint.sh

ENTRYPOINT ["/ci/entrypoint.sh"]