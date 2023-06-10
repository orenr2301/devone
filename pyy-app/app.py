from flask import Flask
from pymongo import MongoClient

app = Flask(__name__)
port = 80

# MongoDB connection URL
url = "mongodb://admin:admin@mongodb:27017"
# Database name
db_name = "docker_db"

@app.route("/")
def get_apples_quantity():
    # Connect to MongoDB
    client = MongoClient(url)
    db = client[db_name]
    collection = db["fruits"]

    # Find the document with name "apples"
    result = collection.find_one({"name": "apples"})

    # Display the quantity of apples in HTML
    apples_qty = result["qty"] if result else "N/A"
    html = f"<h1>Quantity of Apples: {apples_qty}</h1>"

    # Close the MongoDB connection
    client.close()

    return html

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=port)
