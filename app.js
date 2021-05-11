const express = require('express');

const app = express();

const cors = require('cors');

const {port} = require('./config');

require('newrelic');

const {
  getProducts,
  getProduct,
  getRelated,
  getStyles,
} = require('./controllers/product.js');

// middleware
app.use(cors());
app.use(express.json());

// get id's of related products
app.get('/products/:product_id/related', getRelated);

// get all styles available for the given product
app.get('/products/:product_id/styles', getStyles);

// get all product level info for a specific product id
app.get('/products/:product_id', getProduct);

// get all products default page(1) count(5)
app.get('/products', getProducts);

app.get('/',
  (req, res) => {
    res.status(200).send('');
  });

if (!module.parent) {
  app.listen(port);
  console.log('Listening on', port);
}

module.exports.app = app;