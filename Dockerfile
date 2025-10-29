\
    # Multi-stage Dockerfile for .NET 8 - TracelyTag (Web + API)
    FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
    WORKDIR /src

    # copy everything
    COPY . .

    # detect web project (Microsoft.NET.Sdk.Web) and publish it
    RUN set -eux; \
        WEB_PROJ=$(grep -rl "<Project Sdk=\"Microsoft.NET.Sdk.Web\"" --include=*.csproj || true | head -n 1); \
        if [ -z "$WEB_PROJ" ]; then echo "ERROR: Could not find a Web SDK csproj"; exit 1; fi; \
        echo "Detected Web project: $WEB_PROJ"; \
        dotnet restore "$WEB_PROJ"; \
        dotnet publish "$WEB_PROJ" -c Release -o /app/publish

    FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
    WORKDIR /app
    COPY --from=build /app/publish .

    ENV ASPNETCORE_URLS=http://+:8080
    EXPOSE 8080

    ENTRYPOINT [\"sh\",\"-lc\",\"dotnet \\\"$(ls | grep -m1 -E '.*\\.dll$')\\\"\"]
