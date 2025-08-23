# Yandex Cloud Serverless Web App (AOT) Template

[![NuGet](https://img.shields.io/nuget/v/Stupenkov.YandexCloud.Serverless.WebAot.Template.svg)](https://www.nuget.org/packages/Stupenkov.YandexCloud.Serverless.WebAot.Template)
[![dotnet](https://img.shields.io/badge/dotnet-blue)](https://dotnet.microsoft.com/)

📦 A .NET project template for creating web applications 
optimized for **Yandex Cloud Serverless Containers** with **Native AOT compilation**.

## Installation

Install the template globally:

```sh
dotnet new install Stupenkov.YandexCloud.Serverless.WebAot.Template
````

Verify installation:

```sh
dotnet new list yc
```

## Usage

Create a new project:

```sh
dotnet new yc-webaot -n MyWebApp
```

Where:

* `yc-webaot` — short name of the template
* `MyWebApp` — the name of your new project

## Features

* 🚀 Ready to deploy into **Yandex Cloud Serverless Containers**
* 🔥 Supports **Native AOT** for minimal size and fast startup
* 🌐 Based on ASP.NET Core minimal APIs
* 🐳 Includes Dockerfile for container build and deployment

## Deployment to Yandex Cloud

* [Terraform quik start](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart)
* [Install terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## License

MIT © [Anton Stupenkov](https://github.com/stupenkov)
