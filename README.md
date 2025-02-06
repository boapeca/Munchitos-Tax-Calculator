# Munchitos-Tax-Calculator


## Start the app through console
I start developing the app to use the console only, I've kept this here just for posterity and to show previous work and also test the logic before implementing the API

``` ruby .\main.rb ```

## Start the app with API
I have then produced the API with Rails and hooked the backend together

``` cd .\tax_api\ ```

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