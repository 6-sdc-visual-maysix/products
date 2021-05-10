const express = require('express');

const app = express();

const cors = require('cors');

const {
  getProducts,
  getProduct,
  getRelated,
  getStyles,
} = require('./controllers/product.js');

// middleware
app.use(cors());
app.use(express.json());

app.set('port', 3000);

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
  app.listen(app.get('port'));
  console.log('Listening on', app.get('port'));
}

module.exports.app = app;