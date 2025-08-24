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

## Local deployment to Yandex Cloud

### Request resources

1. Initializing variables using a bash script

    ```bash
    ./init_vars.sh terraform-backend terraform
    ```

2. Set the variables in the **global.auto.tfvars** files located in the **terraform-backend**, **terraform** directories

3. Install the s3 backend for terraform state

    ```bash
    cd terraform-backend

    terraform init
    
    terraform apply -auto-approve
    ```

4. Set environment variables

    ```bash
    export BUCKET_NAME=$(terraform output -raw bucket) && \
    export ACCESS_KEY=$(terraform output -json cicd_static_access_key | jq -r .access_key) && \
    export SECRET_KEY=$(terraform output -json cicd_static_access_key | jq -r .secret_key)

    ```

5. Install application resources

    ```bash
    cd terraform

    terraform init -backend-config="bucket=$BUCKET_NAME" -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY" 

    terraform apply -auto-approve
    ```

### Destroy resources

**Attention!** If you want to completely delete yandex cloud resources

```bash
terraform destroy -auto-approve
```

## Useful documentation

* [Create a cloud if you need](https://yandex.cloud/ru/docs/resource-manager/operations/cloud/create)
* [Create a folder into cloud](https://yandex.cloud/ru/docs/resource-manager/operations/folder/create)
* [Create a service account](https://yandex.cloud/ru/docs/iam/operations/sa/create)  
* [Assing roles to service account](https://yandex.cloud/ru/docs/iam/operations/sa/assign-role-for-sa)
* [Terraform quik start](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart)
* [Install terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Memo about yandex cloud roles](https://yandex.cloud/ru/docs/iam/roles-reference)

## License

MIT © [Anton Stupenkov](https://github.com/stupenkov)
