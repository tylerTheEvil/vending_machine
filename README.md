# Vending Machine

Virtual vending machine application which should emulate the goods buying operations and change calculation.

Functional and technical requirements:

- Allow user to select a product from a provided machine’s inventory;
- Allow user to insert coins into a vending machine;
- Once the product is selected and the appropriate amount of coins inserted - it should return the product;
- It should return change (coins) if inserted too much;
- Change should be returned with the minimum amount of coins possible;
- It should notify the customer when the selected product is out of stock;
- It should return inserted coins in case it does not have enough change.

## Installation
Clone this git repository via ssh or https and navigate to the root directory
```
git clone git@github.com:tylerTheEvil/vending_machine.git
cd vending_machine
```
## Configuration
There are 2 files in config folder where you can change initial setup of products and coins.
```
config/coins.yml
config/products.yml
```

## How to run

You can run this program in docker environment usin docker-compose tool.
```
docker-compose build app
docker-compose run app ruby start.rb
```
To check specs you can use `test` service:
```
docker-compose build test
docker-compose up test
```
### Standalone application
To use it as standalone application without docker you will need to run `bundle install` in root directory and then run `ruby start.rb`.
