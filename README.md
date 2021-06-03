# RoR technical assignment

## Problem

We want to build a marketplace for warm intros: requestors can ask for intros to particular companies and departments they want to sell for, and connectors can then make the bridge to connect the requestor with the requested company.

We have a list of intro requests for different companies, and every intro contains company name, price and may contain many departments.

## Assignment

We have 4 types of offers: classic user-moderated ones, perfect-match offers, good-match offers and offers from API.

Example records:

```
User (
  id: 5,
  name: 'Anton',
  company: 'Amazon'
)

Offer (
  id: 5,
  created_at: ...,
  price: 500,
  company:  "Google",
)

Department (
  id: 3,
  name: "Marketing"
)

Department (
  id: 4,
  name: "Engineering"
)

OfferDepartments(
  offer_id: 5,
  department_id: 3
)

OfferDepartments(
  offer_id: 5,
  department_id: 4
)

UserDepartments(
  user_id: 5,
  department_id: 3
)
```

This is the endpoint you should use for collecting offers *from API* (use [request.company](http://request.company)  for company name):

```
https://bravado.co/api/api/opportunity/intros.json?page=1
```

The only parameter this endpoint accepts is *page*.

## Task

We expect you to create a RoR application with API endpoint that accepts the following parameters:

### Parameters accepted by API endpoint

|Parameter      |Description                                                                         |Hint    |
|---------------|------------------------------------------------------------------------------------|--------|
|user_id        |User id from users table                                                            |        |
|page           |API response is paginated by 30 records and this parameter contains the current page|optional|
|query          |Company name or part of company name to filter by                                   |optional|
|department_id[]|Can contain several department ids to filter by                                     |optional|
|sort           |Sorting by price (asc, desc)                                                        |optional|


The API endpoint should return paginated offers list filtered by params passed with the following rules:

1. On top it should be offers with `perfect_match` label. This offers have match with user's company (offer.company == user.company) and have at least 1 department match with user's departments
2. Then we should have `good_match` offers. This offers have only company name match (offer.company == user.company)
3. Then goes top 5 offers suggested by API (They can also be matched as perfect and good matches)
4. Then goes all other offers from offers table sorted by price

You are suggested to solve this task and design RoR application with an API endpoint that can effectively merge search results from all the sources (perfect and good matches, API recommendations and all other offers) and provide them via json. Something like this:

```
[{
  id: 5,
  price: 555,
  company: "Google",
  label: "perfect_match"
}, {
  id: 6,
  price: 333,
  company: "Apple",
  label: "good_match"
}, {
  id: 93,
  price: 100,
  company: "Amazon",
  label: "from_api"
}, ..., {
  id: 103,
  price: 90,
  company: "BN",
  label: "offer"
}]
```

*No need to build authentication system

## Highlights

- Important thing here is class decomposition and implementation of single responsibility principle. Please feel free to create separate classes responsible for doing one thing instead of putting everything together in a single file
- Feel free to use any gem or additional technology that helps to solve this task
- The endpoint response time is important

## Seed

Feel free to use the following seed data for testing:

[https://gist.github.com/allaud/7c92f8ac7b1ad9e3ff77206eef65b5f5](https://gist.github.com/allaud/7c92f8ac7b1ad9e3ff77206eef65b5f5)
