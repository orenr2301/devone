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
**[2.Application](#Application)
  *[Code your app](#Code-your-app)
**[3.Build The Infrastructure](#Build-The-Infrastructure)
  *[IaC with Terraform](#IaC-With-Terraform)
    

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

*[Terraform EC2](#Terraform-EC2)
*[Terraform ECR](#Terraform-ECR)
*[Terraform S3](#Terraform-S3)
*[Terraform ALB](#Terraform-ALB)



### Terraform EC2
<details><summary>SHOW</summary>

 *[ec2-main.tf](#ec2-main.tf)
 *[ec2-sg.tf](#ec2-sg.tf)
 *[variables.tf](#variables.tf)
 *[ec2.auto.tfvars](#ec2.auto.tfvars)
 *[outputs.tf](#outputs.tf)
 *[user-data.tftpl](#user-data.tftpl)
 

Our App will be hosted over docker container on EC2 instance. Therefor i will have to deploy it to my aws account, wanted vpc, security group, policies, IAM roles and user-data to make sure the instance is ready to response to my request when deploy finish so i can say "Look mom. . . no hands at all :smiley:"



#### ec2-main.tf

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


#### ec2-sg.tf

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

#### variables.tf

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

#### ec2.auto.tfvars

Short Overview:
:basketball: Defining the variable values which are set as null in the variables file 

```hcl
aws_region = "your-region"
aws_ec2_ami = "ami-id"
set_cidr = ["cidr net of vpc"]
s3_name = "your bucket name(in case you put your default value in s4_name variable as null)"
```


#### outputs.tf

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

#### user-data.tftpl

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
