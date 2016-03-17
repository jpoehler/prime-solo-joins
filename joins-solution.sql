--1. Get all customers and their addresses.
SELECT customers.id, customers.first_name, customers.last_name, addresses.street, addresses.city, addresses.state, addresses.zip, addresses.address_type
FROM addresses
JOIN customers
ON addresses.customer_id=customers.id
--2. Get all orders and their line items.
SELECT orders.id, orders.order_date, orders.total, line_items.unit_price, line_items.quantity
FROM orders
JOIN line_items
ON orders.id=line_items.order_id
--3. Which warehouses have cheetos?
SELECT products.*, warehouse.*, warehouse_product.*
FROM warehouse_product
JOIN warehouse
  ON warehouse_product.warehouse_id=warehouse.id
JOIN products
  ON warehouse_product.product_id=products.id
WHERE products.description='cheetos'
--4. Which warehouses have diet pepsi?
SELECT products.*, warehouse.*, warehouse_product.*
FROM warehouse_product
JOIN warehouse
  ON warehouse_product.warehouse_id=warehouse.id
JOIN products
  ON warehouse_product.product_id=products.id
WHERE products.description='diet pepsi'
--5. Get the number of orders for each customer.
--NOTE: It is OK if those without orders are not included in results.
--NOTE: I came up with 2 soulutions to this question - here's one
SELECT SUM(orders.total)
  FROM customers
  JOIN addresses
    ON customers.id=addresses.customer_id
  JOIN orders
    ON addresses.id=orders.address_ID
  WHERE orders.total>0
  GROUP BY customers.id
--NOTE:And here's the other
SELECT SUM(orders.total)
  FROM customers
  JOIN addresses
    ON customers.id=addresses.customer_id
  JOIN orders
    ON addresses.id=orders.address_ID
  WHERE orders.total>0
  GROUP BY customers.id
--6. How many customers do we have?
SELECT COUNT(*)
FROM customers
--7. How many products do we carry?
SELECT COUNT(*)
FROM products
--8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM(warehouse_product.on_hand)
FROM warehouse_product
JOIN warehouse
  ON warehouse_product.warehouse_id=warehouse.id
JOIN products
  ON warehouse_product.product_id=products.id
WHERE products.description='diet pepsi'
GROUP BY products.description
