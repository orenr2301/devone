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

      // Close the MongoDB connection
      client.close();
    });
  });
});

app.listen(port, '0.0.0.0', ()=> {
  console.log(`App listening at http://localhost:${port}`);
});
