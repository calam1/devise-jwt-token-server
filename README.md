#### This is a basic implementation of a JWT server using Devise/Warden

Some basic information about this
https://medium.com/@lukerollans/implementing-jwt-authentication-as-a-custom-devise-strategy-54948bddb134

##### How to use
Note: This is not production ready. Secret token isn't secure, etc. Plus payload is just user object, etc

* clone this repo
* run `rails s`
* go to postman or whatever REST client you like

URL - I use a POST, should this be a GET?  maybe not since it returns a bearer token so not idempotent, dunno
```
POST localhost:3000/api/users/login
```
Request Body contains the following
```
{"user":{"email":"fsdfdsfw@test.com", "password":"test123"}}
```

The response header look something like this - just showing a few lines of the header.


| KEY | VALUE |
| ---- | ------ |
|Content-Type |application/json; charset=utf-8|
|Authorization Bearer | eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5NDcwIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTg5NTA5NzcxLCJleHAiOjE1ODk1MTAwNzEsImp0aSI6IjQ4YjY5YmE0LTkyZTQtNGMzYi04ZWQzLTc3ZjhkMGJlYWVmZiJ9.FEGyE04zQ\T9ha5hyvBTzNjN2zTkQ57xVehqywtbkDqE|
|ETag | W/"669b3d72bddc51fd8f879273d8584aaa" | Cache-Control 


The request body contains something like this

```
{
    "id": 9470,
    "email": "jimmy@factor75.com",
    "created_at": "2018-05-01T21:39:20.016Z",
    "updated_at": "2020-05-11T10:50:24.978Z",
    "first_name": "Jim",
    "last_name": "Thakkar",
    "stripe_customer_token": "cus_CmfWKHDh2KveLg",
    "customer_id": null,
    "last_4_digits": null,
    "zip": "60606",
    ...
    ...
```
