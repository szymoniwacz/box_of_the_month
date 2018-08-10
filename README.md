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
