
#FROM mcr.microsoft.com/dotnet/aspnet:runtime:5.0 AS base
#WORKDIR /app
FROM mcr.microsoft.com/dotnet/runtime:5.0 AS base
WORKDIR /app

EXPOSE 80
EXPOSE 443

#FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
WORKDIR /src
COPY ["nagp-devops-dotnet/nagp-devops-dotnet.csproj", "nagp-devops-dotnet/"]
RUN dotnet restore "nagp-devops-dotnet/nagp-devops-dotnet.csproj"
COPY "/nagp-devops-dotnet/" "/src/nagp-devops-dotnet/"
WORKDIR "/src/nagp-devops-dotnet"
RUN dotnet build "nagp-devops-dotnet.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "nagp-devops-dotnet.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "nagp-devops-dotnet.dll"]
