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
* [Code your app](#Code-your-app)  

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

