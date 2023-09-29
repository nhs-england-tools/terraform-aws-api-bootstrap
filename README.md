# get_method_api_module

This module is to provide an API in AWS. The module includes the following:

1. API gateway
1. Lambda
1. Cloudwatch logs
1. IAM roles and policies for this infrastructure

The following items may be added to this at a later date:

1. Implement hosted zones to ensure API has a consistent location.
1. Implement CORS - can use the hosted zone from above to achieve this.
1. Implement Cognito User Pools

## Table of Contents

- [Repository Template](#repository-template)
  - [Table of Contents](#table-of-contents)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Contacts](#contacts)
  - [Licence](#licence)

## Setup

Clone the repository

```shell
git clone https://github.com/nhs-england-tools/repository-template.git
cd nhs-england-tools/repository-template
```

## Usage

This module can be called by including the following:

```hcl
module "get_method_api" {
  source               = "github.com/NHSDigital/ee-terraform-modules//get_method_api_module?ref=v0.0.1"
  aws_region           = "eu-west-2"
  project_name         = "my_get_method_api1"
  lambda_function_name = "my_get_method_lambda1"
  lambda_zip_file      = data.archive_file.lambda_1.output_path
  lambda_handler       = "handler.lambda_handler"
}

data "archive_file" "lambda_1" {
  type = "zip"

  source_dir  = "${path.module}/files/lambda1/hello_world"
  output_path = "${path.module}/lambda_archive/hello_world.zip"
}
```

## Contacts

Provide a way to contact the owners of this project. It can be a team, an individual or information on the means of getting in touch via active communication channels, e.g. opening a GitHub discussion, raising an issue, etc.

## Licence

Unless stated otherwise, the codebase is released under the MIT License. This covers both the codebase and any sample code in the documentation.

Any HTML or Markdown documentation is [© Crown Copyright](https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/) and available under the terms of the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
