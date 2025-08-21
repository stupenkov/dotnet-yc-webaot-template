FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
WORKDIR /src

RUN apk add --no-cache clang gcc musl-dev
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release \
    -r linux-musl-x64 \
    --self-contained true \
    -p:PublishAot=true \
    -o /app/out \
    && rm -f /app/out/*.dbg

FROM alpine
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

COPY --from=build /app/out .
ENTRYPOINT ["./Stupenkov.YandexCloud.Serverless.WebAot"]
