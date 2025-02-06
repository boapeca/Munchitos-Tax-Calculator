# Munchitos-Tax-Calculator


The multinational Munchitos S.A. is going to launch an online platform to sell a myriad of products and services:
Munchitos S.A. has contacted us to integrate an automated system for calculating taxes on sales made on its platform,
and thus be able to comply with the tax regulations of each country.

This project was to design and implement the above system, a system that is capable of calculating taxes on the sales of products and services.

## Pre-requisites
- Ruby
- Rails
- Bundler (for managing dependencies)

## Getting Started

After cloning the repo run:

``` bundle install ```


## Start the app through console
I start developing the app to use the console only, I've kept this here to show how the project started and how it is and the current state

``` ruby .\main.rb ```

## Start the app with API
I have then produced the API with Rails and hooked the backend together

``` rails server ```

### Testing the API

GET

The API can be reached on:
``` localhost:3000/calculate_tax ```

example payload:

``` 
{
  "buyer_location": "Spain",
  "buyer_type": "individual",
  "product_type": "good",
  "price": 100,
  "service_location": null
} 
```

Payload Requirements:

```buyer_type``` needs to be one of 2 values ```["individual, company]```

```product_type``` needs to be one of 3 values ```["good, service-digital, service-onsite]```

required fields : ```buyer_location, buyer_type, product_type, price ```

If the ```product_type == service-onsite``` then there is an extra validation for ```service_location``` this needs to be provided since it is non a mandatory field but is required for onsite transactions


### Run local tests

```
bundle exec rspec
```

### Run Lint checks
you might need to install rubocop with gem to run this if so run ``` gem install rubocop ```

After it is installed you can simple run ``` rubocop ``` to run the lint checks
