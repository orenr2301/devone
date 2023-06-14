# DevOne - Build your containerized app with Terraform GitHub Actions and AWS 
Prior Knowledge to gain or to have:

 - Understanding of container tech and bit Experience of how to build "Docker Images"
 - Basic or prior Terraform Experience/knowledge 
 - Good AWS architecture Understanding
 - A bit of coding/scripting knowledge/experience better have prior knowledge of the following languages, I'm not teaching here how to code from scratch
- [x] Python
- [x] NodeJS
- [x] Bash
- [x] HTML


# Content
**[1.Welcome Aboard](#Welcome-Aboard)**
  * [Introduction](#Introduction)  
  * [Design and Prerequisites](#Design-and-Prerequisites)
    
**[2.Application](#Application)**
  * [Code your app](#Code-your-app)
    
**[3.Build The Infrastructure](#Build-The-Infrastructure)**
  * [IaC with Terraform](#IaC-With-Terraform)

**[4.Deploy The Infrastructure](#Deploy-The-Infrastructure)**
  * [The Power of Github](#The-Power-Of-Github)
    * [Github Pull Request](#Github-Pull-Request)
    * [Github Actions](#Github-Actions)
  * [Ready Set Go CI/CD](#Ready-Set-Go-CI/CD)
    

## Welcome 

![App Screenshot](https://miro.medium.com/v2/resize:fit:1400/1*vInU1g_2FavT-JuV06XwbQ.jpeg)

## Tech Stack  

**Backend IaC:** Terraform

**Container Engine:** Docker

**Cloud Provider:** aws 

**CI/CD Tool:** Githaub Actions

**Code:** Python, NodeJS, Html, Bash, Terraform



# Introduction 
<details><summary>SHOW</summary>

Hello guys, My name is Oren, I am Linux System and infra Engineer who likes the DevOps field.
To combine endpoints systems, and make life easy with good automation and agility mind-set.
From code to opeartion.

I'm here to guide you through, step by step
for Deploying a Simple full CI/CD pipeline, which includes hot topic techs . . .
And most industry-standard tools out there. 

</details> 


# Design and Prerequisites 
* [Design](#Design)
* [Prerequisits](#Prerequisites)

<details><summary>SHOW</summary>

## Design
\\
 lets talk about  Design First 


We Need to perform the following:

    - Building Docker images, 
    
    - Writing the code for our app,
    
    - Using Terraform, and using a CI/CD to deploy our code more efficiently

    - The right idea is that we need to build and store images, then store files app related, and then make a single point that will host of docker containers and will be able to pull files from storage/repos for what we need.
    \
\
    Seebelowo the  Architecture flow:
![image](https://github.com/orenr2301/devone/assets/117763723/6042d14a-d64a-4442-a01e-4d750c3bc2df)

\\

## Prerequisites

1. You need to have an AWS account

   1.1 From your AWS account IAM create an Access and Secret Key

   1.2 Download aws-cli to your pc
2. Visual Studio Code

   2.1 Installed code runtime in order to local machine to  compile our code for test purposes
    2.2 Add interpreterss to  local machine PATH environmentt  
4. Githab Account
5. Terraform Cli - You would like to test Terraform from your local machine to check your code   
6. Coffee and something to eat Next To You. 

</details> 




# Code your app

* [Building Application Code](#Building-Application-Code)
* [Containerize App](#Containerize-App)
* [Compose full app](#Compose-full-app)

A few notes here:

  - Make sure to have already cloned git-repository to your local machine
  - We will push our code to preserve our code
  - In this section, we will write the code with NodeJS and Python
  - Make sure to have Python and NodeJs runtimes already installed on your computer
  - Feel Free to download any extension you think is necessary for you for work


## Building Application Code
* [NodeJS app](#NodeJS-app)
* [Python app](#Python-app)

 <details><summary>SHOW</summary>

### NodeJS app


* Note - since I'm not doing think in NodeJS I took the final absolute code from ChatGTP (Im not familiar with nodeJS that good)

 Our Goal Here is to create a nodejs app that connects to MongoDB container and fetches apples quantity


![image](https://github.com/orenr2301/devone/assets/117763723/f3972ef1-27a4-4dbc-b11d-7cb9ddbeee54)

```javascript
const express = require('express');
const MongoClient = require('mongodb').MongoClient;

const app = express();
const port = 80;

// MongoDB connection URL
const url = 'mongodb://admin:admin@mongodb:27017';
// Database name
const dbName = 'docker_db';

app.get('/', (req, res) => {
  // Connect to MongoDB
  MongoClient.connect(url, (err, client) => {
    if (err) {
      console.error('Error connecting to MongoDB:', err);
      res.send('Error connecting to MongoDB');
      return;
    }

    // Access the "fruits" collection
    const db = client.db(dbName);
    const collection = db.collection('fruits');

    // Find the document with name "apples"
    collection.findOne({ name: 'apples' }, (err, result) => {
      if (err) {
        console.error('Error querying MongoDB:', err);
        res.send('Error querying MongoDB');
        return;
      }

      // Display the quantity of apples in HTML
      const applesQty = result ? result.qty : 'N/A';
      const html = `<h1>Quantity of Apples: ${applesQty}</h1>`;
      res.send(html);

      // Close the MongoDB connection gp
      client.close();
    });
  });
});

app.listen(port, '0.0.0.0', ()=> {
  console.log(`App listening at http://localhost:${port}`);
});
```

Lets make a short review of some points: 


* We are using two modules here: express and Mongo
* Express is the web page html module, its minimal and
* mongo which helps us connect to MongoDB database
* This code is taken from ChatGPT since I'm not usually coding with nodejs.

  I was able to learn and write the code by myself for it, but I had some syntax issues, that alone prevented me to get what I wanted.

  I could've solved it alone, but it was time-consuming so I  took the help of ChatGTP
 
</details>

### Python app
<details><summary>SHOW</summary>
* Since im more fammiliar with python and work with it more often, obviously i will feel more comfortable with it.

  SoIi took all the NodeJS code and Converted it to python to reflect same action and wanted outcome, and also for just in case the NodeJS app wont work.

* This Time we are using flask and pymongo modules, ChatGPT was not involved this time

  
```python
from flask import Flask
from pymongo import MongoClient

app = Flask(__name__)
port = 80
url = "mongodb://admin:admin@mongodb:27017"
db_name = "docker_db"

@app.route("/")
def get_apples_quantity():
   
    client = MongoClient(url)
    db = client[db_name]
    collection = db["fruits"]

   
    result = collection.find_one({"name": "apples"})

    
    apples_qty = result["qty"] if result else "N/A"
    html = f"<h1>Quantity of Apples: {apples_qty}</h1>"

    client.close()

    return html

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=port)

```


* Take a good look over these url we will need it to reference something else
  ~~~bash
   url = "mongodb://admin:admin@mongodb:27017"
  ~~~
</details>


## Containerize App
* [NodeJS Doockerfile](#[NodeJS-Doockerfile)
* [Python Dockerfile](#Python-Dockerfile)



For our CI/CD purposes we want to containerize the application in order to fast deploy. I'm Assuming you are already familiar with Docker file, and image build

### NodeJS Doockerfile
<details><summary>SHOW</summary>

Below NodeJS Docker file

~~~bash
FROM node:14

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

ENV MONGO_INITDB_ROOT_PASSWORD=admin
ENV MONGO_INITDB_ROOT_USERNAME=admin

EXPOSE 80

CMD ["node", "app.js"]
~~~
</details>


### Python Dockerfile
<details><summary>SHOW</summary>

~~~bash
FROM python:3.9

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV MONGO_URL="mongodb://mongodb:27017"
ENV DB_NAME="docker_db"
ENV MONGO_INITDB_ROOT_PASSWORD=admin
ENV MONGO_INITDB_ROOT_USERNAME=admin

EXPOSE 80

CMD ["python", "app.py"]
~~~

</details>

### Compose full app

* [Nodejs Docker compose](#Nodejs-Docker-compose)
* [Python Docker compose](#Python-Docker-compose)
<details><summary>SHOW</summary>
After building the wanted images, we would like to make a single run to deploy our app with mongo image to be our databse which will host our data to be fetched from the nodejs application be built earlier.

Remeber we built only the app. for the mongodb container we will have a container which we will insert the data with js init file.

#### Nodejs Docker compose
~~~bash
version: "3.3"

services:
  app:
    container_name: node-app
    image: nodejsapp:1
    ports:
    - 80:80
    networks:
    - octo_network

  mongodb:
    container_name: mongodb
    image: mongo
    ports:
    - 27017:27017
    restart: always
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=admin
    volumes:
    - ./mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js
    networks:
    - octo_network


networks:
  octo_network:
      external: true
~~~

#### Python docker compose

~~~bash
version: "3.8"

services:
  app:
    container_name: py-app
    image: octo:3
    ports:
    - 80:80
    networks:
    - my_network

  mongodb:
    container_name: mongodb
    image: mongo
    ports:
    - 27017:27017
    restart: always
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=admin
    volumes:
      #- mongoDB:/data/db
    - ./mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js
    networks:
    - my_network


      #volumes:
      #mongoDB: {}

networks:
  my_network:
      external: true
~~~
</details>

# Build The Infrastructure

In Order to Complete my CI/CD flow i had to decide where to deploy my app.

To achive this i needed a way to fast deploy the infrustucture to host my app and also a way to be able to reach my app without manually building it.

For that Purpose picked up Terraform as my IaC, other tools to that can perform IaC are Ansible,AWS CloudFormation, Pulumi, Chef, Saltstack(Common in Openstack environments), Puppet and etc.

## IaC with Terraform

Here where the part of the fun begins.



With Terraform I was able to provision my infrastucture as code to lay down the ground with the compomnents to help me achieve my goal.

The Componenets/Services that im going to provision are:

:diamond_shape_with_a_dot_inside: EC2 instance

:diamond_shape_with_a_dot_inside: ECR (:small_blue_diamond: Elastic Container Regisry)

:diamond_shape_with_a_dot_inside: S3 Bucket

:diamond_shape_with_a_dot_inside: ALB (:small_blue_diamond: Application Load Balancer)


Now lets decouple each components to be explained shortly.

:sparkler: I wont explain each method of  what it's doing. Im assuming you are pretty less or more how to play with terraform well enough to understand what im doing :sparkler:


* [Terraform EC2](#Terraform-EC2)
* [Terraform ECR S3](#Terraform-ECR-S3)
* [Terraform ALB](#Terraform-ALB)



### Terraform EC2

* [ec2 main tf](#ec2-main-tf)
* [ec2 sg tf](#ec2-sg-tf)
* [variables tf](#variables-tf)
* [ec2 auto tfvars](#ec2-auto-tfvars)
* [outputs tf](#outputs-tf)
* [user data tftpl](#user-data.tftpl)
  
<details><summary>SHOW</summary>


Our App will be hosted over docker container on EC2 instance. Therefor i will have to deploy it to my aws account, wanted vpc, security group, policies, IAM roles and user-data to make sure the instance is ready to response to my request when deploy finish so i can say "Look mom. . . no hands at all :smiley:"



#### ec2 main tf

Short Overview:

:basketball: Provider is AWS since im deploying to AWS


:basketball: Creating a template file which store my user data bash script for the ec2 cloud-init at startup


:basketball: Creating the ec2 instance resource with the basic attributes, which ami, which vpc to deploy, the security group to be attached, the instance role to be added, the ssh key pair name, and user-data to use from within respective file including vars which im using in the tptpl file itself


```hcl

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = "eu-central-1"
    profile = "default"
}


data "template_file" "ecr-init" {
  template = "user-data.tpl"

}

resource "aws_instance" "octo" {
  ami = data.aws_ami.octo_ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.ec2-vm.id}"]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile-octo-ec2-role.name
  
  tags = {
    Name = "octopus-vm"
    project = "octo"
  }

  key_name = "aws-internal"

  user_data =  templatefile("user-data.tftpl", { ecr_url = data.aws_ecr_repository.uri.repository_url,  ecr_region = var.aws_region })
  
}

```


#### ec2 sg tf

Short Overview:

:basketball: Creating the Security group of the ec2 instance

:basketball: Defining the inbound and outbound rules

:basketball: Creating the instance profile and IAM role

:basketball: Defining IAM role polciies of what the instance can do or not 

```hcl
resource "aws_security_group" "ec2-vm" {
    name = "ec2-vm-sc"
    description = "Allow Incoming connections"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Incoming HTTP connections"
    }
    
    ingress  {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Incoming HTTPS connections"
    }

    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Incoming SSH connections"
    }


    ingress  {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Incoming icmp connections"
    }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description =  "All egress traffic"
  }

  tags = {
    Name = "terraform-ec2-sg"
  }
}


resource "aws_iam_role" "octo-ec2-role" {
  name = "octo-ec2-ecr"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
  
  tags = {
    project = "octo"
  }
}

resource "aws_iam_instance_profile" "ec2-profile-octo-ec2-role" {
  name = "ec2_pfogile_octo_ec2_role"
  role = aws_iam_role.octo-ec2-role.name
}

resource "aws_iam_role_policy" "octo_ec2_policy" {
  name = "octo_ec2_policy"
  role = aws_iam_role.octo-ec2-role.id

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "octo_ec2_s3_policy" {
  name = "octo_ec2_s3_policy"
  role = aws_iam_role.octo-ec2-role.id

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:DeleteObject"
      ],
      "Sid" : "VisualEditor",
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::*/*",
        "arn:aws:s3:::${var.s3_name}"
      ]
    }
  ]
}
EOF
}

```

#### variables tf

Short Overview:


:basketball: Creating the vars to be used in my terraform code, as if i need to change an attaribute so i have one place to do it


:basketball: You will get to see that im using this all over my files to achieve flexibility 

```hcl
variable "aws_access_key" {
    description = "AWS access key"
    type = string
    default = null
}

variable "aws_secret_key" {
    description =  "AWS secret key"
    type = string
    default = null
}

variable "aws_region" {
    description = "AWS region"
    type = string
    default = "eu-central-1"
}


variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "aws_ec2_ami" {
    description = "AMI image"
    type = string
    default = null
}


variable "set_vpc" {
    type = string
    description = "aws vpc-id" 
    default = null     
}

variable "set_cidr" {
    type = list(string)
    description = "aws vpc cider to set"
    default = null
}


data "aws_ami" "octo_ami" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    }
  
}

variable "s3_name" {
    description = "s3 bucket name"
    type = string
    default = "put-your-bucket-name-here"
}
```

#### ec2 auto tfvars

Short Overview:
:basketball: Defining the variable values which are set as null in the variables file 

```hcl
aws_region = "your-region"
aws_ec2_ami = "ami-id"
set_cidr = ["cidr net of vpc"]
s3_name = "your bucket name(in case you put your default value in s4_name variable as null)"
```


#### outputs tf

Short Overview:

 
 :basketball: Defining data sources to filter specific data
 
 
 :basketball: Defining output soruces to print the filtered data to screen at the end of the apply
 
 
 :basketball: At the output level im also able to get more specific atrribute of the filtered data if i want to

```hcl
output "ec2_public_ip" {
  
  description = "ec2 public ip"
  value = aws_instance.octo.public_ip
}

output "ec2_url" {
    description = "ec2 public url dns"
    value = aws_instance.octo.public_dns
}


data "aws_ecr_repository" "uri" {
  #description = "get ecr devonce repository"
  name = "devone"
  
}

output "ecr-url" {
  description = "ec2 ecr"
  value = "${data.aws_ecr_repository.uri.repository_url}"
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

```

#### user data tftpl

Short Overview:


:basketball: Using user data to install docker engine and docker compose plugin on ec2 instance


:basketball: using tftpl file template variables from ec2 instance resource so i can login ecr


:basketball: Exporting the variables to current tty shell and use this to login to ecr for later pulling images


:basketball: copying needed file to accomplishe docker compose setup


```hcl
#!/bin/bash
set -ex
yum update -y
amazon-linux-extras install docker -y
systemctl enable docker --now
usermod -a -G docker ec2-user
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

export ecr_region=${ecr_region}
export ecr_url=${ecr_url}


/usr/bin/aws ecr get-login-password --region ${ecr_region} | docker login --username AWS --password-stdin ${ecr_url}
docker network create octo_network

aws s3 cp s3://<your-bucket-name>/docker-compose.yaml .
aws s3 cp s3://<your-bucket-name>/mongo-init.js .

docker-compose up -d
```
</details>


### Terraform ECR S3

 * [ecr s3 main tf](#ecr-s3-main-tf) 
 * [ecr s3 variables tf](#ecr-s3-variables-tf)
 * [ecr s3 variables auto tfvars](#ecr-s3-variables-auto-tfvars)
   
<details><summary>SHOW</summary>


Since we built the app, in a way, that we will need to deploy it via containers, I need a place to store them. As I don't have a proper way to upload all files to build from them and do everything on the ec2 machine at startup.

I need to make sure user data is not exceeding 64KB therefore my user data script must be relatively short and to the point. 

I could have done this by uploading all files to S3 and then copying files to the machine, but then I would need to build images, switch directories, make sure each file was in place and etc.

To much Work and pre-ready images are doing the work just fine.

I could also make a predefined bash script deliver to s3 and download from s3 and execute on the server, but Hey . . . If we have a chance to deal and play with other components and develop our skills, then why not.

Easy sometimes and be very boring and not out of the box. A DevOps guy must think out of the box to accomplish new solutions to complex situations.


#### ecr s3 main tf

Short Overview:

:basketball: Creating our ECR repository and its must attributes For Stroing our images

:basketball: Creating our S3 backut to store the additional files

```hcl

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
    /* access_key = var.aws_access_key
    secret_key = var.aws_secret_key */
    region = "eu-central-1"
    profile = "default"
}



resource "aws_ecr_repository" "ecr" {
    for_each = toset(var.ecr_name)
    name = each.key
    image_tag_mutability = var.image_mutability

    encryption_configuration {
      encryption_type = var.encrypt_type
    }

    image_scanning_configuration {
      scan_on_push = false
    }

    tags = var.tags 
  
}

resource "aws_s3_bucket" "octo_s3" {
  bucket = "${var.s3_name}"
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${var.s3_name}"
    Environment = "test"
  }
}

```

#### ecr s3 variables tf

Short Overview:

:basketball: Defining our variables for ecr and s3 resources


```hcl

variable "ecr_name" {

    description = "The list of ecr names to create"
    type = list(string)
    default = null
}

variable "tags" {
    description = "The key value map for tagging"
    type = map(string)
    default = {}
  
}

variable "image_mutability" {
    description = "Provide image mutability"
    type = string
    default = "MUTABLE"
}

variable "encrypt_type" {
    description = "Provider type of encryption here"
    type = string
    default = "KMS"
}

variable "s3_name" {
    description = "s3 bucket name"
    type = string
    default = null
}

```

#### ecr s3 variables auto tfvars

Short Overview:

:basketball: setting variables value for ecr and s3 resources

```hcl
tags = {
    "Environment" = "you-environment name"
}

ecr_name = [
    "your-ecr-repository-name"
]

image_mutability = "IMMUTABLE"

s3_name = "you-bucket-name"
````
</details>


### Terraform ALB

:heavy_dollar_sign:<details><summary>LoadBalancer Short Information and Methods</summary>
 
As many infrastructures are maintained the desired state of having a High Availability in their Environment, and also to load balance between user requests and traffic, in most cloud providers we will use a LoadBalancer component to achieve this.

Also, Load Balancer can be used at the infrastructure edge point to the public, to get user requests from outside and to separate and decouple specific terms of traffic to specific targets inside your LAN 

A good example of a LoadBalancer to get public request is:

Assuming you are having on-prem bare metal Kubernetes cluster, So in order to get public requests we will use Metallb to provide us the ability to load balance requests from public 

An example of a LoadBalancer to achieve High Availability:

Let's assume we are having 3 Servers that are serving the same application or handling the same kind of requests.
The LoadBalancer delivers the same workload to each server 33% each. 

Suddenly one of the servers goes down, but the other 2 are there to keep the application alive and deliver the intended service
In that case, the workload will go by 50% of traffic to each server 


In My case here I was using LoadBlancer for one ec2 instance behind, which isn't that needed since I'm using only 1 instance and the load balancer in aws requires to be in 2 separate subnets for the HA. (But LoadBlancing and EC2 runtime cost money so I was going for the required minimum for it to still work)

</details> 

:heavy_dollar_sign:

* [alb main tf](#alb-main-tf)
* [alb sg tf](#alb-sg-tf)
* [alb variables tf](#alb-variables-tf)
* [alb outputs data tf](#alb-outputs-data-tf)


<details><summary>SHOW</summary>

#### alb main tf

Short Overview:

:basketball: Creating ALB target Group - ALB needs to know which group of ec2 he needs to be pointed/attached to and in which port to deliver requests

:basketball: Creating ALB - must have 2 subnets minimum

:basketball: Defining the type of the LoadBalancer


```hcl
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}


provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = "your-region"
    profile = "default"
}



resource "aws_lb_target_group" "octo-target-group" {
     health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "my-test-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id = "${data.aws_vpc.default_octo.id}"

}


resource "aws_lb_target_group_attachment" "octo-alb-tg-attach" {

    target_group_arn = "${aws_lb_target_group.octo-target-group.arn}"
    target_id = "${data.aws_instance.ec2-octo-instances.id}"
    port = 80
}

resource "aws_lb" "octo-aws-lb" {
    name = "octo-alb"
    internal = false

    security_groups = [
        "${aws_security_group.octo-lb-sg.id}",
    ]


    subnets = [ 
        local.subnet_1,
        local.subnet_2
     ]


    tags = {
      Name = "octo-task-alb"
    }

    ip_address_type = "ipv4"
    load_balancer_type = "application"
}

```


#### alb sg tf

Short Overview:

:basketball: ALB as well requires with Security group - Important note: make sure to have sg anywhere possible in term of security measurments 

:basketball: Creating ALB Security Grouop and type of traffic to listen and action

:basketball: Defining the inboud and outbound rules

```hcl
resource aws_security_group "octo-lb-sg" {
    name = "octo-alb-task-sg"
    vpc_id = "${data.aws_vpc.default_octo.id}"
}


resource "aws_security_group_rule" "octo-in-http" {
    from_port = 80
    protocol = "tcp"
    security_group_id = "${aws_security_group.octo-lb-sg.id}"
    to_port = 80
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
  
}

resource "aws_security_group_rule" "octo-out-all" {
    from_port = 0
    protocol = "-1"
    to_port = 0
    security_group_id = "${aws_security_group.octo-lb-sg.id}"
    type = "egress"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb_listener" "octo-alb-listener" {
    load_balancer_arn = "${aws_lb.octo-aws-lb.arn}"
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = "${aws_lb_target_group.octo-target-group.arn}"
    }
  
}
```

#### alb variables tf

Short Overview:

:basketball: Defining our variables ALB provider login and access

```hcl
variable "aws_access_key" {
    description = "AWS access key"
    type = string
    default = null
}

variable "aws_secret_key" {
    description =  "AWS secret key"
    type = string
    default = null
}

variable "aws_region" {
    description = "AWS region"
    type = string
    default = "your region" 
}

  
}
```

#### alb outputs data tf

Short Overview: 

:basketball: In here i was playing and manipulating with data sources to get specific data

:basketball: I was needing with the output of data source to be used as a variable data to alb resource

:basketball: I was using local vars to save output data and use it in alb resource, i've also sorted it to get the first and second subnet of the region 
each region has availability zone and each avialaibility zone has its own default subnet

![image](https://github.com/orenr2301/devone/assets/117763723/e4d74106-e740-4e91-b760-d853f0071656)

```hcl
variable "vpc_id" {
  default = null
}

data "aws_vpc"  "default_octo" {
  id = var.vpc_id
  
}


output "vpc_id_default" {
  value = data.aws_vpc.default_octo.id
  
}


variable "ec2-id" {
    default = null
}

data "aws_instance" "ec2-octo-instances" {
    instance_id = var.ec2-id
    filter {
      name = "tag:Name"
      values = [ "octopus-vm" ]
      }
    }
    

output "vpc_ec2_id" {
    value =  data.aws_instance.ec2-octo-instances.id
}



data "aws_subnets" "octo-all" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default_octo.id]
  }
}


output "first_subnet_id" {
  value = sort(data.aws_subnets.octo-all.ids)[2]  
}

output "second_subnet_id" {
  value = sort(data.aws_subnets.octo-all.ids)[1] 
  
}



locals {
   subnet_1 = sort(data.aws_subnets.octo-all.ids)[2]
   subnet_2 = sort(data.aws_subnets.octo-all.ids)[1]
}

```

</details>

# The Power Of Github

Great You got this far and have deployed the above code and tried it out manually?!

Then it is now the time to automate for real. . . 

####Hold your Horses, Son . . .

:no_entry_sign: If not yet familiar with git then Stop reading and refer to below:  :point_left:

<a href="https://www.youtube.com/watch?v=3RjQznt-8kE&list=PL4cUxeGkcC9goXbgTDQ0n_4TBzOO0ocPR
" target="_blank"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxIYGSVs7d3C-Hv_2rGg_sh72iCYsUwNbuJg&usqp=CAU" 
alt="Click Me To Learn Git Better" width="400" height="120" border="10" /></a>

| Click On Picture To Lean Git Better |
|-------------------------------------|


:octocat: On day-to-day tasks in teams,  we need to collaborate our code with others in order to enrich and push forward the product we are developing. 

:octocat: Therefore we need an onc source and version control to store our code, created a branch for each stage, to fork the repository in order to make changes per our progress 

:octocat: To be able to make versions of our code, all that helps us to collaborate check each other and still maintain production code 


## Github Pull Request

Some Checks to make: 
- [ ] Code is ready? 
- [ ] I can now push code? 
- [ ] Did the code pass relevant checks ?! 
- [ ] Do I have another branch beside the main branch?
- [ ] Have you looked at your code once more?
      
### Well if at least 2 are answered with no then make sure to prepare your workspace for the PR 

1. If using Windows then download git-bash cmd first
  
2. After Downloading: clone your repository to your local pc


```git clone https://github.com/your-username-name/your-repository.git```

4.  Great, the repository is now downloaded with your code, now I want to fork the repository and make offline changes that won't affect the main code

    1. Create a new branch 

``` git checkout -b new-branch-name ```

   2.  fork the main branch repo 

``` git add mode origin  https://github.com/your-username-name/your-repository.git ```

4. Now your  new branch is "linked" with the main repository

5. Make changes necessary change to your code and then commit and push
 
6.
   ```
   1. Git add 
    
 #### git add . 

     Can be a  specific file

 #### git add my-file.txt 
  

    2. Git commit
       
 #### git commit -m "changed code for prod 

    3. Push your code
       
 #### git push -u origin new-branch-name
 ```  

 7. After Push if you go into your GitHub repository you will see that a pull and merge request is waiting:

    
   
   
   


