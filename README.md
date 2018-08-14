# Box of the month application

Simple json API billing engine used to process subscription of 'Box of the month'.

## Installation

### Set up Rails app

First, install the gems required by the application:

    bundle install

Next, provide proper data to 'config/database.yml' file or use environment variables (for postgres database):
* DATABASE_HOST - Database host
* DATABASE_NAME - Database name
* DATABASE_USER - Database username
* DATABASE_PASS - Database user password
* DATABASE_PORT - Database port

Than, execute the database migrations/schema setup:

    bundle exec rake db:setup

### Run tests

    bundle exec rspec spec

### Start the app

    bundle exec rails server

To start the app in asynchronous mode, don't forget to run sidekiq in parallel with the application.

    bundle exec sidekiq

## Description

### To subscribe for selected plan first you need to register new customer:

Example request:

    POST http://localhost:3000/v1/customers
    Content-Type: application/json
    {
    	"name": "Sample Name",
    	"address": "Sample Address",
    	"zip_code": "01001"
    }

### In response you will receive token which is necessary for authorization to make a subscription.

Example response:

    {
      "href": "http://localhost:3000/v1/customers/1",
      "id": 1,
      "name": "Sample Name",
      "address": "Sample Address",
      "zip_code": "01001",
      "token": "c7fa17f7-1922-4ad0-8861-ec3acf09ce5f"
    }

#### Showing customer data:

    GET http://localhost:3000/v1/customers/1
    Content-Type: application/json
    Authorization: c7fa17f7-1922-4ad0-8861-ec3acf09ce5f

You can only show customer that has provided token.

### Before subscribing you have to choose which 'Box of the month' plan is most suited for you:

    GET http://localhost:3000/v1/plans

### Than you can subscribe:

Example request:

    POST http://localhost:3000/v1/subscriptions
    Content-Type: application/json
    Authorization: c7fa17f7-1922-4ad0-8861-ec3acf09ce5f
    {
      "plan_id": 1,
      "card_number": 4242424242424242,
      "expiration_date": "01/2024",
      "cvv": 123,
      "billing_zip_code": 10100
    }

### Possible errors in synchronous mode:

If your payment is not successful you will receive message like:

    {
        "status": 400,
        "error": "payment_failed",
        "message": "Payment failed.",
        "details": {
            "error_code": 1000001,
            "error": "Invalid credit card number"
        }
    }

Possible error codes:

* 1000001: Invalid credit card number
* 1000002: Insufficient funds
* 1000003: CVV failure
* 1000004: Expired card
* 1000005: Invalid zip code
* 1000006: Invalid purchase amount
* 1000007: Invalid token
* 1000008: Invalid params: cannot specify both token and other credit card params like card_number, cvv, expiration_month, expiration_year or zip .

### In asynchronous mode immediately after request you will receive subscription object with new payment:

    {
      "href": "http://localhost:3000/v1/subscriptions/1",
      "id": 1,
      "plan": {
        "id": 1,
        "name": "Bronze Box",
        "price": 19.99,
        "currency": "USD"
      },
      "status": "new",
      "payments": [
        {
          "id": 1,
          "status": "new",
          "date": "2018-08-12 06:46:49"
        }
      ]
    }

Payment will proces asynchronously so to check it's status. You can do it using valid token:

Example request:

    GET http://localhost:3000/v1/payments/1
    Content-Type: application/json
    Authorization: c7fa17f7-1922-4ad0-8861-ec3acf09ce5f

Example response:

    {
      "href": "http://localhost:3000/v1/payments/28",
      "id": 28,
      "status": "failed",
      "date": "2018-08-14 07:27:11",
      "amount": 19.99,
      "error_code": 1000001,
      "error": "Invalid credit card number"
    }

### Settings
    host: localhost:3000

    async: true

    i18n:
      default_locale: :en
      fallbacks:
        - :en

    payment:
      token: "64146941c4fe1666945e648cf429c0"
      url: "https://www.fakepay.io/purchase"

    cache:
      static_page:
        expires_in: 10.minutes

* host - Host address of your application
* async - Choose if you want to process payments asynchronously
* i18n - Settings of application language
* payment - Settings of payment gateway url and access token.
* cache - Cache settings

## Task description

#### Background
Acme Online sells subscriptions to a “box of the month” service. They offer three products:
* Bronze Box: $19.99/month
* Silver Box: $49.00/month
* Gold Box: $99.00/month
You’ve joined the team that is building Acme Online’s billing engine. As a backend-focused developer, your task is to build an internal API that frontend developers on your team can use to build the subscription signup UI.
#### Your Task
The API should accept a request to create a subscription. Included in the request will be:
* The customer’s shipping information: their name, address, zip code.
* The customer’s billing information: card number, expiration date, CVV, and billing zip code.
* The ID of the plan the customer is subscribing to.
Your API will integrate with the Fakepay payment gateway (https://www.fakepay.io/) with an API key that will be given to you.
When a request to your API endpoint is made with the above data, you will attempt a “purchase” with the customer’s payment information. If the purchase is successful, a new subscription will be created. If it is not, helpful errors should be returned, so that frontend developers can render those to the customer.
The data that is stored upon a successful signup should be sufficient to charge the customer every month for the product they are subscribed to, on their billing date, without any manual intervention. For our purposes, we will bill monthly, from the date of the customer’s signup. You don’t have to write the code that renews customer subscriptions, but you can optionally do so as a bonus
Because of PCI requirements, we cannot store the customer’s credit card number, anywhere. We will only have access to it at their initial signup.
For simplicity’s sake, assume that the frontend will pre-validate customer data before a request is sent to your API endpoint. You don’t need to validate zip codes, for example: if they are present, they are valid.
You have the freedom to design the API (the structure of the parameters it expects, which parameters are required, how it returns errors, etc.) as you see fit.
#### Deliverables
You’ll give us access to a GitHub repo where we can view your coding solution. We should be able to clone your repo and bootstrap the solution so we can test it locally.
#### Bonus
* One customer could have multiple subscriptions. Allow the API to accept some kind of reference to an existing customer, and create the appropriate subscription.
* Write a script that can be used in a cron job to renew any subscriptions who should be billed on a given date.

Here is your API key (token)
api_key: 64146941c4fe1666945e648cf429c0
