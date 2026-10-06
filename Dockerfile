FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["CleofeDavePortfolio.csproj", "./"]
RUN dotnet restore "CleofeDavePortfolio.csproj"

COPY . .
RUN dotnet publish "CleofeDavePortfolio.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "CleofeDavePortfolio.dll"]
