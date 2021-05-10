DROP DATABASE IF EXISTS products;

-- Create the db
CREATE DATABASE products;

-- Move into the db
\c products

-- Create products table
DROP TABLE IF EXISTS products;

CREATE TABLE products(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  slogan TEXT,
  description TEXT,
	category TEXT NOT NULL,
	default_price INT NOT NULL,
	created_at TIMESTAMP DEFAULT Now(),
	updated_at TIMESTAMP DEFAULT Now()
);

INSERT INTO products(id, name, slogan, description, category, default_price)
VALUES ('0', 'Camo Onesie', 'Blend in to your crowd', 'The So Fatigues will wake you up and fit you in. This high energy camo will have you blending in to even the wildest surroundings.', 'Jackets', '140');

-- Create products table

DROP TABLE IF EXISTS styles;

CREATE TABLE styles(
  id SERIAL PRIMARY KEY,
  product_id INTEGER NOT NULL,
  name TEXT,
  sale_price INT,
  original_price INT NOT NULL,
  default_style INT NOT NULL DEFAULT 0,
  FOREIGN KEY (product_id) REFERENCES products (id)
);

-- Create photos table
DROP TABLE IF EXISTS photos;

CREATE TABLE photos(
  id SERIAL PRIMARY KEY,
  style_id INTEGER NOT NULL,
  url TEXT,
  thumbnail_url TEXT,
  FOREIGN KEY(style_id) REFERENCES styles(id)
);

-- Create skus table
DROP TABLE IF EXISTS skus;

CREATE TABLE skus(
  id SERIAL PRIMARY KEY,
  style_id INTEGER NOT NULL,
  size VARCHAR(10) NOT NULL,
  quantity SMALLINT NOT NULL,
  FOREIGN KEY(style_id) REFERENCES styles(id)
);

-- Create features table
DROP TABLE IF EXISTS features;

CREATE TABLE features(
  id SERIAL PRIMARY KEY,
  product_id INTEGER,
  feature TEXT NOT NULL,
  value TEXT NOT NULL,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

-- Create related table
DROP TABLE IF EXISTS related;

CREATE TABLE related(
  id SERIAL PRIMARY KEY,
  current_product_id INTEGER NOT NULL,
  related_product_id INTEGER NOT NULL
);


COPY products(id, name, slogan, description, category, default_price) FROM '/Users/PeterLiu/code/sdc/cleanData/product.csv' DELIMITER ',' CSV HEADER;
COPY related(id, current_product_id, related_product_id) FROM '/Users/PeterLiu/code/sdc/cleanData/related.csv' DELIMITER ',' CSV HEADER;
COPY features(id, product_id, feature, value) FROM '/Users/PeterLiu/code/sdc/cleanData/features.csv' DELIMITER ',' CSV HEADER;
COPY styles(id, product_id, name, sale_price, original_price, default_style) FROM '/Users/PeterLiu/code/sdc/cleanData/styles.csv' DELIMITER ',' CSV HEADER;
COPY photos(id, style_id, url, thumbnail_url) FROM '/Users/PeterLiu/code/sdc/cleanData/photos.csv' DELIMITER ',' CSV HEADER;
COPY skus(id, style_id, size, quantity) FROM '/Users/PeterLiu/code/sdc/cleanData/skus.csv' DELIMITER ',' CSV HEADER;

ALTER TABLE related ADD CONSTRAINT foreignkey1 FOREIGN KEY(current_product_id) REFERENCES products(id);
ALTER TABLE related ADD CONSTRAINT foreignkey2 FOREIGN KEY(related_product_id) REFERENCES products(id);


CREATE INDEX idx_styles_id ON styles(id);
CREATE INDEX idx_styles_product_id ON styles(product_id);
CREATE INDEX idx_feature_product_id ON features(product_id);
CREATE INDEX idx_photos_style_id ON photos(style_id);
CREATE INDEX idx_skus_style_id ON skus(style_id);
CREATE INDEX idx_related_current_id ON related(current_product_id);