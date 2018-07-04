---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - errors
  - warnings
  - successes

search: true
---




# Introduction

Welcome to XRM/MP API.

## Environments

* *LIVE - <b>api.fantasticservices.com*</b>
* *STAGE - <b>middlepoint-stg.1dxr.com*</b>
* *DEV - <b>middlepoint-dev.1dxr.com*</b>

In this document `{{BASE_URL}}` is used as a placeholder for current environment.

## Namespaces

Namespace is added after version.

* *CLIENT USER - <b>/client</b>*
* *PRO USER - <b>/unit</b>*
* *GLOBAL FOR SYSTEM - <b>/shared</b>*

Example:

<b>*api.fantasticservices.com/v2/client*</b>

In this document namespace is included in examples.


## Applications identifying tokens

To access API all request must include identifying token header field.

`X-Application: {{APPLICATION_TOKEN}}`

<aside class="notice">
You must replace <code>{{APPLICATION_TOKEN}}</code> with your personal APP token.
</aside>

## Profile identifying tokens

To access profile specific data request should include identifying profile header field.

`X-Profile: {{PROFILE_ID}}`

<aside class="notice">
You must replace <code>{{PROFILE_ID}}</code> with your personal profile id.
</aside>


## Authentication

To access user specific data request should include authorization header field.

`Authorization: {{AUTHORIZATION_TOKEN}}`

<aside class="notice">
You must replace <code>{{AUTHORIZATION_TOKEN}}</code> with your personal authorization token.
</aside>




# Communication Protocol

## Request


All requests to the API have `path` component. It's used to access resources and actions. For resources it can be followed by an `id` to get resource by id. At the end query parameters (`params`) can be added to further modify the response.

`https://api.fantasticservices.com/v2/client/{{path}}/{{id}}?{{params}}`

Accepted request `method`s are:

* `GET` - read data
* `POST` - create and update data
* `DELETE` - delete data

### `params`

When passing an array, index number is optional. For example the array `foo = ["a", "b", "c"]` can be passed both ways - `foo[]=a&foo[]=b&foo[]=c` or `foo[0]=a&foo[1]=b&foo[2]=c`

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`expand` | *array* | *null* | By default child objects are returned as id. With this attribute they can be returned as full objects. Send array of attribute names to expand.<br><br> Keywords:<br><br>all - *expands all first level attributes*<br>all.all - *expands all second level attributes*<br/><br/>Examples:<br/><br/>to expand only services in a category<br/>`expand[0]=services`<br/><br/>to expand all child elements of a category<br/>`expand[0]=all`<br/><br/>to expand all child elements of a category and their child elements<br/>`expand[0]=all.all`<br/><br/>to expand only services in a category and all services child element<br/>`expand[0]=services.all`<br/><br/>to expand only services and infos in a category<br/>`expand[0]=services&expand[1]=infos`
`fields` | *array* | *all* | Attributes to receive in response
`exclude_fields` | *array* | *null* | Attributes to exclude from response
`include_fields` | *array* | *null* | Attributes to add to response which are not returned by default
`return_meta` | *boolean* | *false* | Weather response includes `meta`
`paging`<br>*optional* | *object* | *null* | Information about paged results
`paging.offset` | *integer* | *0* | Page starting element
`paging.limit` | *integer* | *10* | Page size
`filter` | *object* | *null* | Paramters for filtering results. Object has the same structure as the result.<br/><br/>Examples<br/><br/>to filter services by type 1<br/>`filter[type]=1`<br/><br/>to filter services by type 1 or 2<br/>`filter[type][0]=1&filter[type][1]=2`<br/><br/>to filter services by payment_method.type Stripe<br/>`filter[payment_methods][type]=Stripe`<br/><br/>to filter services by payment_method.type Stripe or PayPal<br/>`filter[payment_methods][type][0]=Stripe&filter[payment_methods][type][1]=PayPal`<br/><br/>to filter services by type 1 and payment_method.type Stripe<br/>`filter[payment_methods][type][0]=1&filter[payment_methods][type][1]=Stripe`<br/><br/>Filter parameter filters only the last node.
`query` | *object* | *null* | Custom parameters


## Response


> JSON response structured

```json
{
  "data": null,
  "paging": {
    "offset": 0,
    "limit": 10,
    "total": 224
  },
  "success": [
    {
      "code": 1020,
      "message": "Address created.",
      "debug_message": "postal_code missing.",
      "debug_id": 213124
    }
  ],
  "meta": {
    "db_version": 25,
    "latest_build": 27
  }
}
```

All responses are with HTTP status 200 and contain `data` parameter. Optionally there can be `success`, `error` and `warning` message elements, `meta` element and `paging`.


### Response object parameters

Parameter | Type | Description
--------- | ---- | -----------
`data`<br>*optional* | *array or object* | Content of response. `data` holds array of objects when requesting resources with plural names (e.g. addresses).`data` holds object when requesting resources with singular names  (e.g. profile).
`paging`<br>*optional* | *object* | Information about paged result as requested
`paging.total` | *integer* | Total elements count
`success`, `warning`, `error`<br>*optional* | *array* | Messages with information for the request. More than one type of message can be returned in a response. `success` and `error` can't come in the same response. `warning` can be combined with `success` or `error`.
`meta`<br>*optional*  | *object* | Parameter containing information for the system.


### `meta`

Parameter | Type | Description
--------- | ---- | -----------
`db_version` | *integer* | Version of database model
`latest_build` | *integer* | Latest application build release


## Read

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/services/1"
```

> The above command returns JSON structured like this:

```json
{
  "data": [
    {
      "id": 1,
      "sort": 100,
      "title": "Cleaning",
      "description": "Free up more time for you and your family. The skilled cleaning experts will take care of your home.",
      "short_description": "One-off cleaning",
      "keywords": [
        "clean",
        "one-off",
        "fantastic"
      ],
      "list_image": null,
      "phone": "02034044444",
      "choice_views": [
        338,
        339,
        340,
        341,
        342
      ],
      "updated_at": 1459492785
    }
  ]
}
```

Read data by using `method: GET` and specifying `path` to resource you want to access. Get object by id with suffix `/{{id}}`

`"path": "services"`


## Create/Update

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "address_line_1": "9 Apt.",
  "address_line_2": "24 Red Lion Street",
  "postcode": "SW12 2TN",
  "lat": 51.604903,
  "lng": -0.457022
}'\
 "https://{{BASE_URL}}/v2/client/addresses?return=object"
```

> The above request success response is:

```json
{
  "data": {
    "id": 255,
    "address_line_1": "9 Apt.",
    "address_line_2": "24 Red Lion Street",
    "postcode": "SW12 2TN",
    "lat": 51.604903,
    "lng": -0.457022
  },
  "success": [
    {
      "code": 1020,
      "message": "Address created.",
      "debug_message": "postal_code missing.",
      "debug_id": 213124
    }
  ]
}
```


Create objects by using `method: POST` and specifying `path` to resource you want to create. Add suffix `/{{id}}` to update existing objects.

`"path": "addresses"`

If operation is successful created/updated object is returned.

### `params`

Parameter | Type | Description
-------- | ----- | -------
`return`<br>*optional*<br>*default `none`* | *string* | Determines response content for successfully created/updated object:<br><br>`id` - returns the id of the created/updated object<br>`object` - returns the full created/updated object<br>`none` - returns only response status


## Delete

```shell
curl\
 -X DELETE\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d ''\
 "https://{{BASE_URL}}/v2/client/addresses/255"
```

> The above request success response is:

```json
{
  "success": [
    {
      "code": 1021,
      "message": "Address deleted.",
      "debug_message": null,
      "debug_id": 213124
    }
  ]
}
```

Delete objects by using `method: DELETE` and specifying `path` and `/{{id}}` suffix for object to delete.

`"path": "addresses"`

If object is deleted successfully `"success"` is returned.


## Batched requests

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "requests": [
    {
      "method": "GET",
      "path": "services",
      "params": {
        "expand": [
          "all"
        ],
        "include_fields": [
          "logic_js"
          "choices.customize"
        ],
        "filter": {
          "type": 1,
          "payment_methods": {
            "type": ["Stripe, "PayPal"]
          }
        },
        "paging": {
          "offset": 30,
          "limit": 10
        },
        "query": {
          "with_promotions": true
        },
        "return_meta": true
      },
      "data": null
    }
  ]
}' "https://{{BASE_URL}}/v2/client"
```


Requests can be combined in batches. Server processes them in the order they are received and returns [batched responses] (#batched-responses) in the same order.

To send batched requests you should POST at `https://{base URL}/{version}/{namespace}` endpoint parameter `requests` holding array of request objects.

### Request object parameters

Parameter | Type | Description
-------- | ----- | -------
`method`<br>*required* | *string* | Request type.<br><br>*<b>POST</b> - write data to server (create/update)*<br>*<b>GET</b> - read data from server*<br>*<b>DELETE</b> - delete data on server*
`path`<br>*required* | *string* | Path to resource to access
`params`<br>*optional* | *object* | Parameters for the request
`data`<br>*optional* | *object* | Data to post to server


## Batched responses


> JSON response structured

```json
{
  "responses": [
    {
      "data": null,
      "success": [
        {
          "code": 1020,
          "message": "Address created.",
          "debug_message": "postal_code missing.",
          "debug_id": 213124
        }
      ]
    }
  ]
}
```

The response from batched requests is returned as batched response. It contains parameter `responses` that is array holding response objects.


### Response object parameters

Parameter | Type | Description
--------- | ---- | -----------
`data`<br>*optional* | *array* | Array of data objects returned in the result of the request
`success`, `warning`, `error`<br>*optional* | *array* | Messages with information for the request. More than one type of message can be returned in a response. `success` and `error` can't come in the same response. `warning` can be combined with `success` or `error`.
`meta`<br>*optional*  | *object* | Parameter containing information for the system.

In batched responses `meta` is returned once at the end.



# Profiles


## Configuration


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/configuration"
```

> The above request success response is:

```json
{
  "data": {
    "template_name": "default",
    "brand_name": "Local Cleaners",
    "phone": "+442221123123",
    "default_category_id": 1,
    "default_service_id": 3,
    "currency_code": "GBP",
    "locale": "en_GB",
    "website_url": "http://domainname.com/",
    "terms_and_conditions_url": "https://gofantastic.com/terms-and-conditions.html",
    "privacy_policy_url": "https://gofantastic.com/privacy-policy.html",
    "show_manage_membership_section": true,
    "referral_bonus_formatted": "£20",
    "payment_methods": [
      1,
      3,
      5
    ]
}
```

> The above request app profile success response is:

```json
{
  "data": {
    "default_category_id": 1,
    "default_service_id": 3,
    "phone": "+442221123123",
    "currency_code": "GBP",
    "locale": "en_GB",
    "terms_and_conditions_url": "https://gofantastic.com/terms-and-conditions.html",
    "privacy_policy_url": "https://gofantastic.com/privacy-policy.html",
    "show_manage_membership_section": true,
    "show_service_search": true,
    "show_membership_reminder_always": true,
    "most_booked_search_section": [1, 2, 3],
    "referral_bonus_formatted": "£20",
    "membership_section_content" : "{\"join_the_club_screen\":{\"title\":\"Join the Fantastic Club and Start Saving Now!\",\"description\":\"Enjoy the exclusive perks of being a member of the Fantastic Club for an annual fee of <b>only \\u00a349<\\/b>.\",\"how_to_title\":\"How to join?\",\"club_member_benefits\":{\"title\":\"Club Member Benefits\",\"benefits\":[{\"image_url\":\"\",\"title\":\"Flat 10% discount on 25+ Fantastic services\",\"description\":\"Fantastic Club Members get a fixed 10% OFF 25+ Fantastic services*, as well as access to members only deals and slots.\"},{\"image_url\":\"\",\"title\":\"Save over \\u00a3400 a year with our preferential domestic cleaning rates.\",\"description\":\"Book domestic cleaning services at a special rate of \\u00a312\\/h and one-off cleaning at \\u00a314\\/h \"},{\"image_url\":\"\",\"title\":\"Money back guarantee and no cancellation fees\",\"description\":\"100% money-back guarantee on your membership within 30 days of purchase and no bookings cancellation fee for an entire year.\"}],\"additional_details\":\"* Minimum charges per service, slot and area apply. Does not apply to already existing bookings and quotes. For all services discount applies to labour cost only.\"},\"join_button_title\":\"JOIN THE CLUB FOR \\u00a349\\/year\",\"button_description\":\"100% money-back guarantee on your membership within 30 days of purchase\"},\"how_to_join_screen\":{\"description\":\"Becoming a Fantastic Club member is really easy! Simply select the button at the bottom of this page. We\\u2019ll send you an email with more information regarding your membership fee payment.\\n\\nYou can also become a member by following these four steps:\",\"steps\":[\"Choose the service you want to book and pick your desired time slot.\",\"Select the discounted prices for members by tapping the switch at the top of the screen.\",\"Press proceed and select Join the Club to add the annual \\u00a349 Fantastic Club membership fee to your booking. The price of the service will then be automatically updated with the discounted price for members.\",\"Finish your booking by completing your payment by credit card. The next time you book a service, you will automatically see your discounted member price.\"],\"join_button_title\":\"JOIN THE CLUB FOR \\u00a349\\/year\",\"button_description\":\"100% money-back guarantee on your membership within 30 days of purchase\"},\"become_a_member_section\":{\"title\":\"Become a Member for only \\u00a349\",\"description\":\"Join now to continue booking at the discounted rates for members. Your annual membership will be added to the total of your booking and valid for one year from the time of purchase.\"}}",
    "request_login_step": 5,
    "banners": [
      {
        "type": 1,
        "image_url": "https://files.dxr.cloud/pG0cOtlAnWPq9PPH1dOaRGiq1g1o17QLE2zFTFxhyiNcgpmDd4b6hkvEFgb4",
        "link": "GoFantstic://bookings",
        "sort": 1
      },
      {
        "type": 2,
        "category_id": 74,
        "image_url": "https://files.dxr.cloud/pG0cOtlAnWPq9PPH1dOaRGiq1g1o17QLE2zFTFxhyiNcgpmDd4b6hkvEFgb4",
        "link": "https://accounts.fantasticservices.com/login",
        "sort": 1
      }
    ],
    "register_popup_titles": [
      {
        "position": "app_start",
        "title": "Hello there"
      },
      {
        "positions": "before_summary",
        "title": "Hello there too"
      }
    ],
    "template_name": "default",
    "brand_name": "Local Cleaners",
    "website_url": "http://domainname.com/",
    "payment_methods": [
      1,
      3,
      5
    ],
    "show_phone": true,
    "cta_color": "#6c391c",
    "logo_url": "http://domainname.com/images/logo.jpg"
  }
}
```

Configuration object parameters for initial settings in the client side based on the `X-Profile`

`"path": "configuration"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`template_name` | *string* | If you want to customize an existing template it will help you decide which template needs to be loaded.
`brand_name` | *string* | If you need website title to display
`phone` | *string* | Default website phone number
`default_category_id` | *integer* | Configuration for default selected category in the interface
`default_service_id` | *integer* | Configuration for default selected service in the interface
`currency_code` | *string* | Configuration for the currency code
`locale` | *string* | Configuration for the locale
`website_url` | *string* | Configuration for the full website url with protocol Ex.: https://domainname.com/
`terms_and_conditions_url` | *string* | Configuration of full url in website for terms and conditions
`privacy_policy_url` | *string* | Configuration of full url in website for privacy and policy]
`show_manage_membership_section` | *boolean* | Configuration for hiding or showing managing membership section in account
`referral_bonus_formatted` | *string* | Formatted amount of bonus client receives when another client registers with their referral code and book a service.
`payment_methods` | *array\<[payment_methods](#payment-methods)\>* | Payment methods for profile

### App profiles additional response parameters

Parameter | Type | Description
-------- | ----- | -------
`referral_bonus_formatted` | *string* | Referral program bonus amount formatted
`membership_section_content` | *string* | JSON with membership section content in account tab and on timeslots purchase.
`show_service_search` | *boolean* | Configuration for hiding or showing search servide field
`show_membership_reminder_always` | *boolean* | Configuration for membership reminder behaviour
`most_booked_search_section` | *array\<integer\>* | List of service/deals ids
`request_login_step` | *integer* | Determines where user has to login to continue:<br>*<b>1</b> - on welcome screen*<br>*<b>2</b> - after welcome screen*<br>*<b>3</b> - after coverage*<br>*<b>4</b> - before timeslots*<br>*<b>5</b> - after timeslots*<br>
`banners` | *array\<banner\>* | List of banners for the application
`banners.type` | *integer* | Determines where to show the banner:<br>*<b>1</b> - categories list*<br>*<b>2</b> - services list*<br>
`banners.category_id` | *integer* | Category in which to show the banner
`banners.image_url` | *string* | URL for image to display in banner
`banners.sort` | *integer* | Order in list of categories or services
`register_popup_titles` | *array\<register_popup_titles\>* | List of titles for registration popup
`register_popup_titles.position` | *string* | Position of register popup:<br/>*<b>categories</b> - at categories list*<br>*<b>account_tab</b> - on tapping of account tab*<br>*<b>deal</b> - on tapping a deal*<br>*<b>membership</b> - on tapping membership in account tab*<br>*<b>referral</b> - on tapping referral in account tab*<br>*<b>before_timeslots</b> - before showing timeslots (request_logi_step:4)*<br>*<b>before_summary</b> - before showing summary(request_logi_step:5)*
`register_popup_titles.title` | *string* | Title of register popup for the position

### Web profiles additional response parameters

Parameter | Type | Description
-------- | ----- | -------
`show_phone` | *boolean* | Configuration for hiding or showing website phone number in the interface
`cta_color` | *string* | Configuration if you want to customize Call to Action colors in the template
`logo_url` | *string* | Configuration full path of the website logo Ex.: https://domainname.com/images/logo.png

## Validations


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/validations"
```

> The above request success response is:

```json
{
  "data": [
    {
      "path": "register",
      "fields": [
        {
          "name": "username",
          "regex": "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)",
          "required": true
        },
        {
          "name": "password",
          "regex": "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)",
          "required": true
        }
      ]
    },
    {
      "path": "addresses",
      "fields": [
        {
          "name": "address_line_one",
          "regex": "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)",
          "required": true
        },
        {
          "name": "address_line_two",
          "regex": "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)",
          "required": false
        }
      ]
    }
  ]
}
```

Validation object should be used for client side validation of fields before posting to server.

`"path": "validations"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`path` | *string* | Path at which fields to validated will be posted
`fields` | *array* | Array of field validation objects
`fields.name` | *string* | Field key name in json
`fields.regex` | *string* | Regex used to validate the field
`fields.required` | *boolean* | Is field required for the path

# Account

## Login


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -d '{
        "username": "test@test.com",
        "password": "1234"
}'\
 "https://{{BASE_URL}}/v2/client/login"
```

> The above request success response is :

```json
{
  "data": [
    {
      "session": {
        "sid": "1cjkidhfqoihoufu18j0ncoy0jl7eu0d4ge1kslggp4outkh",
        "create_time": 1429863734,
        "expire_time": 1429906934
      }
    }
  ],
  "success": [
    {
      "code": 2000,
      "message": "Success",
      "debug_message": null,
      "debug_id": null
    }
  ]
}
```


To login you can use username and password or social login. For each social network there are specific attributes.

`"path": "login"`

### Username and password login request parameters

Parameter | Type | Description
-------- | ----- | -------
`username`<br>*required* | *string* | Username of the account to login
`password`<br>*required* | *string* | Password of the account to login

### Facebook login request parameters

Parameter | Type | Description
-------- | ----- | -------
`social.oauth_id`<br>*required* | *string* | Obtained facebook user access token 
`social.social_provider_id`<br>*optional* | *integer* | Social login provider id. Check [user](#user).`social_login_provider`.

### `params`

Parameter | Type | Description
-------- | ----- | -------
`query.return_user`<br>*optional, default <b>false</b>* | *boolean* | Return user object with expanded avatar, phones, addresses, payment details and last 10 bookings.

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`session.sid` | *string* | Your session id. Use for `Authorization` header.
`user` | *object* | Logged in user with expanded avatar, phones, addresses, payment details and last 10 bookings.

This endpoint returns:

* [Common errors](#common-errors)
* [Login errors](#login-errors)


## Register

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -d '{
        "title_id": 1,
        "first_name": "Nikolay",
        "last_name": "Georgiev",
        "phone": "+442071234567",
        "email": "test@test.com",
        "password": "1234",
        "referrer_code": "JOHND1234B",
        "social": {
          "oauth_id": "EAAEo0IpvAQcBAK1gy3VjCJPZCp6vidasdvEvEtxmO0gjFFjtz3jd8omEuhVhg3Y3ZAzIjSLQVMMZBaWwIZBRY9U8B7XZCFvGpledf38DPUTfeHNA2PCZALtPFTjXYFD1aPeB6IK4oo8dJWAIMAcpKPmFATTtXABljEA02jIDExTAp5brMUuNLMQlQr48ISRhbNy4hbKyI6plbO6ZCd1iHJ9kxd09PfpiwcZD",
          "social_provider_id": 1
        },
        "type_id": 1,
        "preferences": {
          "allow_mk_all": true,
          "allow_mk_push_notification": true,
          "allow_mk_sms": true,
          "allow_mk_email": true,
          "allow_mk_call": true,
          "allow_mk_letter": true
        }
}'\
 "https://{{BASE_URL}}/v2/client/register"
```

> The above request success response is:

```json
{
  "data": [
    {
      "session": {
        "sid": "1cjkidhfqoihoufu18j0ncoy0jl7eu0d4ge1kslggp4outkh",
        "create_time": 1429863734,
        "expire_time": 1429906934
      }
    }
  ],
  "success": [
    {
      "code": 2010,
      "message": "Successful register",
      "debug_message": null,
      "debug_id": null
    }
  ]
}
```

To create account all required fields must be sent (except anonymous accounts which need only the right `type_id`). For social sign in set the correct `type_id` and fields in `social` object (they vary for different social medias). Missing details from social sign in must be collected from user to satisfy required fields.

`"path": "register"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`title_id`<br>*required* | *integer* | Selected title `id` from `user_titles`
`first_name`<br>*required* | *string* | User's first name (no special characters allowed)
`last_name`<br>*required* | *string* | User's last name (no special characters allowed)
`phone`<br>*required* | *integer* | User's phone number validated for the region (UK/AUS/USA etc.)
`email`<br>*required* | *string* | User's email with validated structure (e.g. xxxx@xxx.xxx)
`referrer_code`<br>*optional* | *string* | Referral code from another user
`social`<br>*optional* | *[object](#facebook-login-request-parameters)* | Social login attributes. Same are used for login (check <b>Facebook login request parameters</b>).
`type_id`<br>*optional* | *integer* | Type of registration id. Check [user](#user).`type`.
`preferences.allow_mk_all`<br>*optional* | *boolean* | Sets all preferences to true.



### `params`

Parameter | Type | Description
-------- | ----- | -------
`query.return_user`<br>*optional, default <b>false</b>* | *boolean* | Return user object with expanded phones objects.

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`login` | *[object](#login)* | Object containing session information. Same is returned on login.
`user` | *object* | Created user after registration

This endpoint returns:

* [Common errors](#common-errors)
* [Registration errors](#register-errors)



## Logout


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 "https://{{BASE_URL}}/v2/unit/logout"
```

> The above request success response is :

```json
{
  "success": [
    {
      "code": 2000,
      "message": "Success",
      "debug_message": null,
      "debug_id": null
    }
  ]
}
```

Deletes user session.

`"path": "logout"`

This endpoint returns:

* [Common errors](#common-errors)


## Request reset password


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -d '{
        "email": "test@test.com"
}'\
 "https://{{BASE_URL}}/v2/client/request_reset_password"
```

> The above request success response is:

```json
{
  "data": null,
  "success": [
    {
      "code": 2000,
      "message": "Success",
      "debug_message": null,
      "debug_id": null
    }
  ]
}
```

Initiate sending an email with link for resetting password

`"path": "request_reset_password"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`email`<br>*required* | *string* | Email address to which a link for reset password will be sent

This endpoint returns:

* [Common errors](#common-errors)
* [Request reset password](#request-reset-password-errors)

## Read user details on password reset


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 "https://{{BASE_URL}}/v2/client/reset_password_user_details?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
```

> The above request success response is:

```json
{
  "data": [
    {
      "title": "Mr",
      "first_name": "John",
      "last_name": "Doe"
    }
  ]
}
```


Get user name to greet him upon changing password.

`"path": "reset_password_user_details"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`token`<br>*required* | *string* | Token received via email for resetting password


### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`title` | *string* | Title of the user
`first_name` | *string* | First name for user with reset password token
`last_name` | *string* | Last name for user with reset password token

This endpoint returns:

* [Common errors](#common-errors)
* [Reset password user details](#reset-password-user-details-errors)

## Reset password


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -d '{
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
        "password": "jamie",
        "confirm_password": "jamie",
}'\
 "https://{{BASE_URL}}/v2/client/reset_password"
```

> The above request success response is:

```json
{
  "data": {
    "username": "john_doe@test.test"
  },
  "success": [
    {
      "code": 2000,
      "message": "Success",
      "debug_message": null,
      "debug_id": null
    }
  ]
}
```

Reset password of user.

`"path": "reset_password"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`token `<br>*required* | *string* | Token for resetting password received via email
`password`<br>*required* | *string* | Client new password
`confirm_password`<br>*optional* | *string* | Password confirmation for server check

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`username ` | *string* | Login email address of client who resetted their password

This endpoint returns:

* [Common errors](#common-errors)
* [Reset password](#reset-password-errors)


## Change password


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
        "old_password": "jamie",
        "new_password": "jamie1",
        "confirm_new_password": "jamie1"
}'\
 "https://{{BASE_URL}}/v2/client/change_password"
```

> The above request success response is:

```json
{
  "success": [
    {
      "code": 2000,
      "message": "Success",
      "debug_message": null,
      "debug_id": null
    }
  ]
}
```

Change password of user.

`"path": "change_password"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`old_password `<br>*required* | *string* | Client current password of account
`new_password`<br>*required* | *string* | Client new password
`confirm_new_password`<br>*required* | *string* | Confirmation of client new password

This endpoint returns:

* [Common errors](#common-errors)



## Register token infos


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 "https://{{BASE_URL}}/v2/client/register_token_infos/id:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
```

> The above request success response is:

```json
{
  "data": [
    {
      "first_name": "John",
      "last_name": "Doe",
      "email": "johndoe@test.test",
      "phone": "07123456789"
    }

  ]
}
```


Get registration details for a token.

`"path": "register_token_infos"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`first_name` | *string* | First name for registrationuser with reset password token
`last_name` | *string* | Last name for registration
`email` | *string* | Email for registration
`phone` | *string* | Phone number for registration

This endpoint returns:

* [Common errors](#common-errors)
* [Register token info errors](#register-token-infos-errors)


## Request delete account


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
        "password": "yourPasswordHere",
        "comment": "I don`t want to use your services anymore"
}'\
 "https://{{BASE_URL}}/v2/client/request_delete_account"
```

> The above request success response is :

```json
{
  "success": [
    {
      "code": 2000,
      "message": "Success",
      "debug_message": null,
      "debug_id": null
    }
  ]
}
```


Request account deletion.

`"path": "request_delete_account"`


### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`password`<br>*required* | *string* | Account password
`comment`<br>*optional* | *string* | Reason for requesting account deletion



# Service data




## Categories


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/categories"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 27,
      "sort": 200,
      "title": "Cleaning",
      "phone": "+442221123123",
      "short_description": "This service is very nice",
      "keywords": [
        "clean",
        "uk",
        "domestic",
        "regular"
      ],
      "list_image_url": "http://www.image.com/1jsklfas.jpg",
      "thumbnail_image_url": "http://www.image.com/1jsklfas.jpg",
      "infos": [
        3,
        4,
        5
      ],
      "services": [
        21,
        36,
        89
      ],
      "profile_config": {
        "url": "https://www.fantasticservices.com/cleaning/one-off"
      },
    }
  ]
}
```

Categories group services.


`"path": "categories"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`sort` | *integer* | Order of item in list
`title` | *string* | Category title text
`phone` | *string* | Category phone number
`short_description` | *string* | Category short description text
`keywords` | *array\<string\>* | List of keywords for category
`list_image_url` | *string* | Link to list image
`thumbnail_image_url` | *string* | Link to thumbnail image. Used for search results in spotlight or in app service search.
`infos` | *array\<info\>* | List of infos for the category
`services` | *array\<[service](#services)\>* | List of services for the category
`profile_config` | *object* | Key-value pairs of custom attributes with different values for each Profile

### `params`

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`query.covering_postcode` | *string* | *null* | Filters response to return only services that cover the postcode



## Services


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/services"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 79,
      "sort": 300,
      "type": 1,
      "title": "Domestic Cleaning",
      "phone": "+44222233333",
      "description": "Domestic Cleaning is very nice.",
      "short_description": "Domestic Cleaning service",
      "keywords": [
        "domestic",
        "fantastic"
      ],
      "list_image_url": "http://www.image.com/1jsklfas.jpg",
      "booking_image_url": "http://www.image.com/1jsklfas.jpg",
      "inactive_booking_image_url": "http://www.image.com/1jsklfas.jpg",
      "info_image_url": "http://www.image.com/1jsklfas.jpg",
      "thumbnail_image_url": "http://www.image.com/1jsklfas.jpg",
      "infos": [
        4,
        5,
        6
      ],
      "choices": [
        78,
        90
      ],
      "payment_methods": [
        1,
        2
      ],
      "customize": {
        "tooltip": "Click here",
        "search_keywords": "[\"fantastic\", \"cleaning\"]"
      },
      "profile_config": {
        "url": "https://www.fantasticservices.com/cleaning/one-off"
      },
      "logic_js": "function getRequiredActionForState(items) { if (items[0].choice_item_id == \"1092\" && items[0].choice_item_value == 2) { return { \"action\": \"service_redirect\", \"redirect_message_title\": \"This is more like EOT. Wanna go?\", \"redirect_message\": \"This is more like EOT. Wanna go?\", \"OK_title\": \"Go there\", \"cancel_title\": \"Not really\", \"service_id\": 23 }; } else { return null; } }"
    }
  ]
}
```

Services


`"path": "services"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`sort` | *integer* | Order of item in list
`type` | *integer* | *<b>1</b> - Service*<br>*<b>2</b> - Deal*
`title` | *string* | Service title text
`phone` | *string* | Service phone number
`description` | *string* | Service detailed description text
`short_description` | *string* | Service short description text
`keywords` | *array\<string\>* | List of keywords for service
`list_image_url` | *string* | Link to list image. Used to show a list of services. Could be square or rectangle based on layout.
`info_image_url` | *string* | Link to info image. Used in web sites in side panel above the info text section/
`booking_image_url` | *string* | Link to booking image. Used in booking cards for upcoming appointments.
`inactive_booking_image_url` | *string* | Link to inactive booking image. Used in booking cards for past appointments.
`thumbnail_image_url` | *string* | Link to thumbnail image. Used for search results in spotlight or in app service search.
`infos` | *array\<info\>* | List of infos for the services
`choices` | *array\<[choice](#choices)\>* | List of questions to book the service
`payment_methods` | *array\<[payment_methods](#payment-methods)\>* | List of available payment methods for the service
`customize` | *object* | Key-value pairs of custom attributes
`customize.search_keywords` | *string* | Represents array of search keywords for the service
`profile_config` | *object* | Key-value pairs of custom attributes with different values for each Profile
`logic_js` | *string* | JavaScript containing functions for modification of booking process

### `params`

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`filter.visible` | *boolean* | *[true, false]* | Filters services by `visible` flag. If no filter is passed all services are returned.


## Choices


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/choices"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 338,
      "sort": 100,
      "position": "init",
      "title": "have the tradesmen left the property?",
      "summary_title": "tradesman _left",
      "required": true,
      "choice_items": [
        24,
        54,
        94
      ]
    }
  ]
}
```


Questions the user needs to answer to book a service.


`"path": "choices"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`sort` | *integer* | Order of item in list
`position` | *string* | Determines where the choice should be dislpayed in the booking process:<br/>*<b>init</b> - begining of booking process. Minimum requirement to create a [booking_transaction](#booking-transactions)*<br>*<b>configurator</b> - choices describing service configuration*<br>*<b>before_summary</b> - middle scree before showing the booking summary*<br>*<b>on_summary</b> - choices at the summary screen (e.g. cross sell)*<br>*<b>before_confirmation</b> - before user confirms the booking (e.g. last minute upsells)*
`title` | *string* | Question text
`summary_title` | *string* | Question short title text in summary
`required` | *boolean* | Should the question be answered to book
`choice_items` | *array\<[choice_item](#choice-items)\>* | List of answers for the question


### `params`

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`filter.position` | *string* | *configurator* | Filters choices by `position`. If no filter is passed only `configurator` choices are returned. To filter choices by more than one position pass an array of positions e.g. `["configurator", "init"]`


## Choice items


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/choice_items"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 1110,
      "sort": 100,
      "parent_id": 0,
      "type": 1,
      "max_value": 0,
      "min_value": 0,
      "value": 0,
      "duration": 0,
      "required": false,
      "summary_title": "",
      "is_in_summary": false,
      "title": "1 bedroom",
      "choice_items": null,
      "image_url": "http://image.url/here.jpg",
      "customize": null
    }
  ]
}
```


Answers to the questions the user needs to answer to book a service.


`"path": "choice_items"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Object id
`sort` | *integer* | Order of item in list
`parent_id` | *integer* | Parent answer (if answer is sub-answer)
`type` | *integer* | *<b>1</b> - Check*<br>*<b>2</b> - Radio*<br>*<b>3</b> - Stepper (incremental value)*<br>*<b>4</b> - Text field*<br>*<b>5</b> - Hours (total hours for current booking configuration)*<br>*<b>6</b> - Drop down*<br>*<b>7</b> - Multi select (autocomplete with quantity)*<br>*<b>8</b> - Distance*<br>*<b>9</b> - Always Apply*<br>*<b>10</b> - Price per hour*<br>*<b>11</b> - Decimal Text*<br>*<b>12</b> - Photo attachment*<br>*<b>14</b> - Address. Accepts [address](#addresses) object*
`max_value` | *integer* | Maximum value of answer
`min_value` | *integer* | Minimum value of answer
`value` | *integer* | Default value of answer
`duration` | *integer* | Minutes added to booking estimated time from the answer
`required` | *boolean* | Determines weather choice item requires child to be selected
`summary_title` | *string* | Answer short title text in summary
`is_in_summary` | *boolean* | Should the answer be included in the summary of booking
`title` | *string* | Title of answer
`choice_items` | *array\<[choice_item](#choice-items)\>* | List of sub-answers for the answers
`image_url`| *string* | List image for choice item
`customize` | *object* | Key-value pairs of custom attributes

## Infos


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/infos"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 487,
      "title": "About the service:",
      "sort": 1,
      "contents": [
        {
          "id": 1744,
          "text": "The Game Console & Drone Evaluation service is provided by one of our Trusted Partners. Basically, send your device using the post to one of their labs and a skilled technician will take a look at it and then we'll tell you about what repairs are needed.",
          "sort": 1
        }
      ]
    }
  ]
}
```

Information for categories and services.


`"path": "infos"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`title` | *string* | Info title text
`sort` | *integer* | Order of item in list
`contents` | *array\<[info content](#info-contents)\>* | List of info contents



## Info contents


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/info_contents"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 487,
      "title": "About the service:",
      "sort": 1,
      "contents": [
        {
          "id": 1744,
          "text": "The Game Console & Drone Evaluation service is provided by one of our Trusted Partners. Basically, send your device using the post to one of their labs and a skilled technician will take a look at it and then we'll tell you about what repairs are needed.",
          "sort": 1
        }
      ]
    }
  ]
}
```

Information contents for categories and services.


`"path": "info_contents"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`text` | *string* | Text content
`sort` | *integer* | Order of item in list

## Payment methods


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/services/2/payment_methods"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 1,
      "sort": 100,
      "default": true,
      "title": "Cash",
      "type": "None",
      "data": null,
      "payment_provider_id": null,
      "icon_image_url": "http://image.url/here.jpg"
    },
    {
      "id": 2,
      "sort": 200,
      "default": false,
      "title": "Card",
      "type": "Stripe",
      "payment_provider_id": 3,
      "data": {
        "stripe_key": "kdj9DSA923131safdfd89a7fklj`cxzc"
      },
      "icon_image_url": "http://image.url/here.jpg"
    },
    {
      "id": 3,
      "sort": 300,
      "default": false,
      "title": "PayPal",
      "type": "PayPal",
      "payment_provider_id": 15,
      "data": {
        "paypal_key": "kdj9DSA923131safdfd89a7fklj`cxzc"
      },
      "icon_image_url": "http://image.url/here.jpg"
    }
  ]
}
```

Available payment methods for service


`"path": "services/{service id}/payment_methods"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`sort` | *integer* | Order of item in list
`default` | *boolean* | Is this payment method the default
`title` | *string* | Display name of payment method
`type` | *string* | *<b>None</b> - No processing needed (e.g. Cash payment)*<br>*<b>Stripe</b> - Card payment via Stripe*<br>*<b>PayPal</b> - PayPal via Braintree*
`payment_provider_id` | *integer* | Identifier for the the account used for the payment method (e.g. Stripe UK, Stripe AUS etc.)
`data`<br>*optional* | *object* | Based on the payment provider different data may be provided (such as keys, tokens etc.)
`data.stripe_key`<br>*optional* | *string* | Stripe API authorization key
`data.paypal_key`<br>*optional* | *string* | PayPal Braintree authorization key
`icon_image_url` | *string* | Icon image for payment method


## Treats


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/treats"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 45,
      "title": "Free pickup on your next <b>Quickup</b>",
      "description": "Save some precious time with </b>Quickup</b>. They shop, pickup and drop everything you need.",
      "note": "* Partners T&C applies.",
      "image": 223,
      "image_url": "https://files.dxr.cloud/qYvi51mYq98Bvj1wk94RQSCNAuOvY4GXhEjqMdNRAFKYpckaFnTipz8YwJyT",
      "link": "http://www.google.com",
      "sort": 100
    }
  ]
}
```


Treats are affiliate deals. They are shown in a list. Tapping on one opens a link in a browser.

`"path": "treats"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`title` | *string* | Treat title text.
`description` | *string* | Treat detailed description text.
`note` | *string* | Small additional description text.
`image` | *integer* | Treat image object id. If expanded image full object is returned.
`image_url` | *string* | Treat image direct link.
`link` | *string* | Link to treat website.
`sort` | *integer* | Order of item in list


## Topics


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/topics"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 45,
      "title": "Best app ever",
      "image_url": "https://files.dxr.cloud/qYvi51mYq98Bvj1wk94RQSCNAuOvY4GXhEjqMdNRAFKYpckaFnTipz8YwJyT",
      "sort": 100
    }
  ]
}
```


Topics used at startup of app to show benefits.

`"path": "topics"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`title` | *string* | Topic title text
`image_url` | *string* | Topic image direct link
`sort` | *integer* | Order of item in list



## Reschedule reasons


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/reschedule_reasons"
```

> The above request success response is:

```json
{
  "data": [
      {
          "id": 1,
          "name": "Pro delay",
          "requires_comment": true,
          "sort": 100
      },
      {
          "id": 2,
          "name": "Client personal reasons",
          "requires_comment": false,
          "sort": 200
      }

  ]
}
```

Client chooses the reasons to reschedule from a list of reschedule reasons

`"path": "reschedule_reasons"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`name` | *string* | Reschedule reason title text
`requires_comment` | *boolean* | Determines weather comment is required to reschedule with this reason
`sort` | *integer* | Order of item in list

## Cancel reasons


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/cancel_reasons"
```

> The above request success response is:

```json
{
  "data": [
      {
          "id": 1,
          "name": "I don't need the service anymore",
          "requires_comment": true,
          "sort": 100
      },
      {
          "id": 2,
          "name": "I found a better price",
          "requires_comment": false,
          "sort": 200
      }

  ]
}
```

Client chooses the reasons to cancel from a list of cancel reasons

`"path": "cancel_reasons"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`name` | *string* | Reschedule reason title text
`requires_comment` | *boolean* | Determines weather comment is required to cancel with this reason
`sort` | *integer* | Order of item in list


## Edit booking reasons


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/edit_booking_reasons"
```

> The above request success response is:

```json
{
  "data": [
      {
          "id": 1,
          "name": "Pro delay",
          "requires_comment": true,
          "sort": 100
      },
      {
          "id": 2,
          "name": "Client personal reasons",
          "requires_comment": true,
          "sort": 200
      }

  ]
}
```

Client chooses the reasons to edit a booking from a list of edit reasons

`"path": "edit_booking_reasons"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`name` | *string* | Edit reason title text
`requires_comment` | *boolean* | Determines weather comment is required to edit booking with this reason
`sort` | *integer* | Order of item in list

## Edit regular plan reasons


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/edit_regular_plan_reasons"
```

> The above request success response is:

```json
{
  "data": [
      {
          "id": 1,
          "name": "Pro delay",
          "requires_comment": true,
          "sort": 100
      },
      {
          "id": 2,
          "name": "Client personal reasons",
          "requires_comment": true,
          "sort": 200
      }

  ]
}
```

Client chooses the reasons to edit a regular plan from a list of edit reasons

`"path": "edit_regular_plan_reasons"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`name` | *string* | Edit reason title text
`requires_comment` | *boolean* | Determines weather comment is required to edit regular plan with this reason
`sort` | *integer* | Order of item in list



# Clients


## User

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/user"
```

> The above request success response is:

```json
{
  "data": {
    "id": 1,
    "first_name": "John",
    "last_name": "Doe",
    "username": "johndoe@mail.com",
    "social_provider": 1,
    "type_id": 2,
    "social_key": "@johndoe",
    "credit": 55.5,
    "credit_formatted": "£55.5",
    "referral_code": "johnd1234b",
    "created_at": 1433489660,
    "membership": 1,
    "avatar": 1,
    "last_profile_keyword": "UnitedKingdomGF",
    "delete_account_requested": false,
    "preferences": {
      "id": 1,
      "preferences_submitted": true,
      "allow_mk_all": true,
      "allow_mk_push_notification": true,
      "allow_mk_sms": true,
      "allow_mk_email": true,
      "allow_mk_call": true,
      "allow_mk_letter": true
    },
    "addresses": [
      1
    ],
    "phones": [
      1
    ],
    "paymethods": [
      1
    ],
    "user_applications": [
      1
    ],
    "bookings": [
      1
    ]
  }
}
```

User contains client details

`"path": "user"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`first_name`<br>*editable* | *string* | Client first name
`last_name`<br>*editable* | *string* | Client first name
`username` | *string* | Client email used for login
`social_provider` | *integer* | Social provider client used to register:<br/>*<b>1</b> - Facebook*
`type_id` | *integer* | *<b>1</b> - Anonymous*<br>*<b>2</b> - Generic (register form)*<br>*<b>3</b> - Social (Facebook)*
`social_key` | *string* | Social identifier used on registration (e.g. @joe for Twitter or 23253414234 for Facebook)
`credit` | *double* | Client credit amount in the region
`credit_formatted` | *string* | Client credit amount formatted in the region currency
`referral_code` | *string* | Referral code to send to other clients
`created_at` | *integer* | Client regisgration UTC timestamp.
`membership` | *object<[membership](#membership)>* | Current purchased membership
`avatar`<br>*editable* | *object<[avatar](#avatar)>* | Client avatar image
`last_profile_keyword` | *string* | Keyword of last chosen profile for the client
`delete_account_requested`<br>*read-only*  | *boolean* | True if user requested account deletion
`preferences` | *object* | Flags with user preferences for marketing
`preferences.preferences_submitted`<br>*read-only*  | *boolean* | True if user has set their initial preferences
`preferences.allow_mk_all`<br>*write-only* | *object* | When set all preferences are set to true (except preferences_submitted)
`addresses`<br>*editable* | *array<[address](#addresses)>* | Client addresses
`phones`<br>*editable* | *array<[phone](#phones)>* | Client phones
`paymethods`<br>*editable* | *array<[paymethod](#paymethods)>* | Client payment methods
`user_applications`<br>*editable* | *array<[user_application](#user-applications)>* | Platforms the client used the system on
`bookings` | *array<[booking](#bookings)>* | Client bookings


## Addresses

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/user/addresses"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 1,
      "address_line_one": "24 Red Lion Street",
      "address_line_two": "Brooklands",
      "postcode": "SW12 2TH",
      "city": "London",
      "country": "United Kingdom",
      "default": true,
      "sort": 100
    }
  ]
}
```

Addresses of the client

`"path": "user/addresses"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier of the address
`address_line_one`<br>*editable* | *string* | Street name and number
`address_line_two`<br>*editable* | *string* | Flat, House number etc.
`postcode`<br>*editable* | *string* | Post code of the address
`city`<br>*editable* | *string* | City of the address
`country`<br>*editable* | *string* | Country of the address
`default`<br>*editable* | *boolean* | Client preference for default address
`sort` | *integer* | Order in list


## Phones

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/user/phones"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 1,
      "value": "+4423213213",
      "default": true,
      "sort": 100
    }
  ]
}
```

Phoned of the client

`"path": "user/phones"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier of the phone
`value`<br>*editable* | *string* | Phone number
`default`<br>*editable* | *boolean* | Client preference for default contact phone
`sort` | *integer* | Order in list


## Paymethods

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/user/paymethods"
```

> The above request success response is:

```json
{
  "id": 1,
  "description": "Business card",
  "label": "**** **** **** 1234",
  "type": "Stripe",
  "payment_provider_id": 3,
  "data": {
    "token": "231231jsklfhaksj231§2",
    "device_data": "shdyjtyruhdfgfsdgfdsgdsf",
    "brand": "visa",
    "last_four_digit": "3344",
    "expiration_year": "2016",
    "expiration_month": "2"
  },
  "default": true,
  "sort": 100
}
```

Paymethods for a client

`"path": "user/paymethods"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`description`<br>*editable* | *string* | User description for the paymethod
`label` | *string* | Generated description for the paymethod
`type` | *string* | Type of paymethod. Check [payment_method](#payment-methods).`type`.
`payment_provider_id` | *integer* | Type of payment provider. Check [payment_method](#payment-methods).`payment_provider_id`.
`default`<br>*editable* | *boolean* | Client preference for default paymethod
`data` | *object* | Custom data of paymethod.
`data.token` | *string* | Token from Stripe/PayPal for paymethod creation
`data.device_data` | *string* | Token from PayPal anti-fraud system
`data.brand` | *string* | Brand for the paymethod (e.g. VISA, MasterCard etc.)
`data.last_four_digit` | *string* | Last 4 digits of a credit card
`data.expiration_month` | *string* | Expriation month of credit card
`data.expiration_year` | *string* | Expriation year of credit card
`sort` | *integer* | Order in list

### `params`

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`filter.type` | *string* | *Stripe* | Filters paymethods by `type`. If no filter is passed `Stripe` paymethods are returned. To filter paymethods by more than one type pass an array of types e.g. `["Stripe", "PayPal"]`


## Bookings

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/user/bookings"
```

> The above request success response is:

```json
{
  "id": "laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas",
  "reference_number": "1042MB",
  "timeslot": 1525343435,
  "timeslot_formatted": "2015-03-24 10:00",
  "price": {
    "type": "no_price",
    "description": "Maximum price reached",
    "choices": [
      {
        "id": 1,
        "choice_items": [
          {
            "id": 1,
            "value": 1
          }
        ]
      }
    ],
    "price_breakdown": [
      {
        "name": "Membership price",
        "value": "£49",
        "description": "Yearly fee payed once upon booking",
        "type": "membership"
      },
      {
        "name": "Service price",
        "value": "£80",
        "description": null,
        "type": "service_price"
      },
      {
        "name": "Voucher discount",
        "value": "-£5",
        "description": "Reached minimum for service",
        "type": "voucher"
      },
      {
        "name": "Credit used",
        "value": "£25",
        "description": "All available credit is used for this booking",
        "type": "credit"
      },
      {
        "name": "Total:",
        "value": "£99",
        "description": "All available credit is used for this booking",
        "type": "total"
      }
    ]
  },
  "email": "john.doe@test.test",
  "phones": [
    1
  ],
  "work_time": 120,
  "payment_method": 3,
  "payment_method_title": "Cash",
  "paymethod": 1,
  "voucher": "GO10OFF",
  "feedback_rate": 0,
  "online": true,
  "online_status": 20,
  "source": {
    "phone": "07123456789",
    "domain_url": "fantasticcleaners.com"
  },
  "service": {
    "id": 1,
    "title": "One-off",
    "choices": [
      {
        "id": 338,
        "sort": 100,
        "title": "have the tradesmen left the property?",
        "summary_title": "tradesman _left",
        "required": true,
        "choice_items": [
          {
            "id": 1110,
            "sort": 100,
            "parent_id": 0,
            "type": 1,
            "max_value": 0,
            "min_value": 0,
            "value": 0,
            "duration": 0,
            "summary_title": "",
            "is_in_summary": false,
            "title": "1 bedroom",
            "required": true,
            "choice_items": null,
            "image_url": "http://image.url/here.jpg",
            "customize": null
          }
        ]
      }
    ]
  },
  "can_reschedule_until": 1459953968,
  "can_cancel_until": 1459953968,
  "address_display_text": "SW12 2TH, Red Lion Street 24",
  "comments": [
    {
      "id": 123,
      "created_at": 15433454354,
      "text": "i have a big dog"
    }
  ],
  "client_attached_files": [
    {
      "url": "http://image.url.jpg",
      "token": "_ft5_cfq_o7_t2_r_iq_ywj_h_wq3s_vrp_r_r7f9_yyy85_p8a_pgc_m_y_c5ywke1f_v_pe_btfeys_p",
      "note": ""
    },
    {
      "url": "http://image.url.jpg",
      "token": "_ft5_cfq_o7_t2_r_iq_ywj_h_wq3s_vrp_r_r7f9_yyy85_p8a_pgc_m_y_c5ywke1f_v_pe_btfeys_p"
    }
  ],
  "documents": [
    {
      "type": 1,
      "title": "_invoice _s_t_l9099",
      "num": "_s_t_l9099",
      "date_formatted": "01.01.2018",
      "url": "http://doc.url",
      "mime_type": "application/pdf"
    },
    {
      "type": 2,
      "title": "_credit note _i_n_v-_s_t_l0316",
      "num": "_c_n-_s_t_l0316",
      "url": "http://doc.url",
      "mime_type": "application/pdf"
    },
    {
      "type": 3,
      "title": "_proform _p9099",
      "num": "_p9099",
      "url": "http://doc.url",
      "mime_type": "application/pdf"
    }
  ],
  "service_summary": [
    {
      "title": "_one-off",
      "type": "service"
    },
    {
      "title": "1 _bedroom",
      "type": "property"
    },
    {
      "title": "_hoover and mop floor",
      "type": "item"
    },
    {
      "title": "_dust tops, lampshades, pictures",
      "type": "item"
    },
    {
      "title": "_clean and wipe skirting board",
      "type": "item"
    }
  ]
}
```


Bookings for a client

`"path": "user/bookings"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *string* | Unique identifier
`reference_number` | *string* | Unique identifier for processed booking
`timeslot`<br>*editable* | *integer* | Appointment time in UTC time zone
`timeslot_formatted`<br>*editable* | *string* | Appointment time in local time zone
`email`<br>*editable* | *string* | Client email collected during booking process
`phones`<br>*editable* | *array<[phones](#phones)>* | Client phones collected during booking process
`price` | *object<[price](#price)>* | Selected price breakdown
`price.type` | *string*| Price type:<br/>*<b>no_price</b> - when user reached maximum price and will create a quote*<br>*<b>voucher_applied</b> - when prices are with applied voucher*
`price.description` | *string* | Description text for the price
`price.choice_items` | *array\<[choice_item](#choice-items)\>* | Price choice items selected on availability
`price.price_breakdown` | *object* | Breakdown of how price was calculated
`price.price_breakdown.name` | *string* | Name of field
`price.price_breakdown.value` | *string* | Value of field
`price.price_breakdown.description` | *string* | Description text for field
`price.price_breakdown.type` | *string* | Type of breakdown element:<br/>*<b>membership</b> - price of a membership*<br>*<b>service</b> - price of a service after membership discount*<br>*<b>voucher</b> - discount from vouchers applied*<br>*<b>credit</b> - discounts from credits applied*<br>*<b>total</b> - total price after discounts*
`work_time` | *integer* | Service duration in minutes
`payment_method`<br>*editable* | *object<[payment_method](#payment-methods)>* | Selected payment method for the booking
`payment_method_title` | *string* | Display text for payment method
`paymethods`<br>*editable* | *object<[paymethod](#paymethods)>* | Selected paymethod for the booking (particular credit card etc.)
`voucher`<br>*editable* | *string* | Discount voucher code used for booking
`feedback_rate`<br>*editable* | *integer* | Rating of client for booking service
`online` | *boolean* | Determines weather booking was made online or via the phone
`online_status` | *integer* | Status of the booking:<br/>*<b>10</b> - Quote*<br>*<b>20</b> - Booked*<br>*<b>30</b> - Cancelled*
`source` | object | Tracking source of the booking for marketing campaigns or website. You can create a tracking source after you've purchased your tracking phone number(s) and then assign that new tracking source to specific tracking.
`source.phone` | string | Tracking source phone of the website or marketing campaigns
`source.domain_url` | string | Source domain name of the booking without www. and http/https protocols
`service`<br>*editable* | *object<[service](#services)>* | Booking service
`can_reschedule_until` | *integer* | The time up untilclient can reschedule the service in UTC
`can_cancel_until` | *integer* | The time up until the client can cancel the service in UTC
`address_display_text` | *string* | Display text of main booking address
`comments`<br>*editable* | *array* | Comments left by the client
`client_attached_files`<br>*editable* | *array* | Files uploaded from the client
`documents` | *array* | Documents related to the booking
`service_summary` | *array* | Summary for processed booking


## Avatar

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/user/avatar"
```

> The above request success response is:

```json
{
  "data": {
    "token": "euaoisd1273892173dsahjd",
    "url": "https://server.com/image.jpg"
  }
}
```

Avatar of the client

`"path": "user/avatar"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`token`<br>*editable* | *string* | Token for image file on file server
`url`<br>*editable* | *string* | URL address of image file


## Purchase membership

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
       "client_paymethod_id": 12345,
       "client_paymethod": {
          "payment_provider_id": 12,
          "token": "hzkchvkuhzgxcvkjhsbdfnaljJGKJbdasnbdLJHDs"
       },
       "source_id": 11426,
       "domain_url": "fantasticcleaners.com",
       "source_phone": "02037460906"
}'\
 "https://{{BASE_URL}}/v2/client/purchase_membership"
```

Clients can purchase membership by providing card details. Card can be created upon purchase or existin card id can be provided upon purchase.

`"path": "purchase_membership"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`client_paymethod_id`<br>*required (if no `client_paymethod`)* | *integer* | Object id of paymethod (card saved as user payment detail)
`client_paymethod`<br>*required (if no `client_paymethod_id`)* | *object* | Details for creating new paymethod
`client_paymethod.payment_provider_id`<br>*required* | *integer* | Stripe account id
`client_paymethod.token`<br>*required* | *string* | Card token from Stripe
`source_id`<br>*optional* | *integer* | Object id of source
`domain_url`<br>*optional* | *string* | Source domain url
`source_phone`<br>*optional* | *string* | Source phone number

* [Common errors](#common-errors)


## Purchase membership payment methods


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/purchase_membership_payment_methods"
```


[Payment methods](#payment-methods) for puchasing membership.

`"path": "purchase_membership_payment_methods"`

# Booking process

## Booking transactions

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/booking_transactions/laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas"
```

```shell
Example setting address:

curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "service": {
    "id": 1,
    "choices": [
      {
        "id": 338,
        "position": "init",
        "choice_items": [
          {
            "id": 1110,
            "value": {
              "address_line_one": "24 Red Lion Street",
              "address_line_two": "Brooklands",
              "postcode": "SW12 2TH"
            }
          }
        ]
      }
    ]
  }
}'\
"https://{{BASE_URL}}/v2/client/booking_transactions/laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas"
```


```shell
Example setting price:

curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "timeslot_formatted": "2015-03-24 10:00",
  "price": {
    "choices": [
      {
        "id": 1,
        "choice_items": [
          {
            "id": 1,
            "value": 1
          }
        ]
      }
    ]
  }
}'\
"https://{{BASE_URL}}/v2/client/booking_transactions/laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas"
```

```shell
Example setting new paymethod:

curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "payment_method": 3,
  "paymethod": {
    "payment_provider_id": 3,
    "data": {
      "token": "231231jsklfhaksj231§2"
    }
  }
}'\
"https://{{BASE_URL}}/v2/client/booking_transactions/laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas"
```

```shell
Example setting existing paymethod:

curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "payment_method": 3,
  "paymethod": 5
}'\
"https://{{BASE_URL}}/v2/client/booking_transactions/laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas"
```

Booking transactions are representation of an ongoing booking process. They are similar to a [booking](#bookings) object with additional `confirmed` field. When client confirms their booking it's set to true. Then server validates if all required fields are filled and allows it.

`"path": "booking_transactions"`

### Creating booking transaction

Booking transaction can be created in two ways:

* `session`, `service`, all `init` choices for the service - minimum to create a booking transaction for booking a service is logged in user, service and values for all choices with position `init`. `session` is taken from `Authorization` header of the request, `service` value should be object id. Choices should be sent with their filled choice items. Any other fields can be passed in addition if available.
* `reference_number` - creates booking transaction to edit an existing booking. Any other fields can be passed in addition.

### Set addresses

Address is set as value for choice items. An object is passed that should minumum contain `postcode`. Value can be further updated with other attributes as `address_line_1` etc. Addresses are validated based on the service coverage.

### Set price

To set price you need to:

* Get [avaialbility](#availabilty)
* Pick time of the service by selecting an object from `availabilities.timeslots`
* Combine `availabilities.date` with `availabilities.timeslots.time` and set `booking_transaction.timeslot_formatted` matching it`s format
* From the selected `avilability.timeslots` object pick objects from `chocies.choice_items` and set `booking_transaction.price.choices` matching it`s structure

### Set paymethod

Paymethod can be set by:

* Passing new paymethod details - set at least `payment_provider_id` and `data.token` at `booking_transaction.paymethod` to create new paymethod for the booking transaction. Optionally other fields as `description`, `default` or `sort` can be passed.
* Passing existing paymethod id - if you want to use existing paymethod set it's `id` at `booking_transaction.paymethod`

### Booking configuration

Each transaction holds a service object. It contains the choice and choice item objects needed to book the service. Editing booking has pre-filled choice items.

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`confirmed` | *boolean* | Marks when booking transaction is confirmed by client and accepted by server

This endpoint returns:

* [Common errors](#common-errors)
* [Booking process errors](#booking-process-errors)
* [Booking process warning](#booking-process-warnings)


## Availability


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
        "transaction_id": "laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas"
}'\
 "https://{{BASE_URL}}/v2/client/availability"
```

> The above request success response is :

```json
{
  "data": {
    "price": {
      "type": "no_price",
      "description": "Maximum price reached."
    },
    "availabilities": [
      {
        "date": "2015-03-24",
        "timeslots": [
          {
            "time": "10:00",
            "available": true,
            "tags": [
              "carbon",
              "members_only"
            ],
            "choices": [
              {
                "id": 1,
                "choice_items": [
                  {
                    "id": 1110,
                    "sort": 100,
                    "type": 1,
                    "max_value": 0,
                    "min_value": 0,
                    "value": 0,
                    "name": "Regular price",
                    "image_url": "http://image.url/here.jpg",
                    "customize": {
                      "price_formatted": "£140"
                    }
                  },
                  {
                    "id": 1110,
                    "sort": 100,
                    "type": 1,
                    "max_value": 0,
                    "min_value": 0,
                    "value": 0,
                    "name": "Membership price",
                    "image_url": "http://image.url/here.jpg",
                    "customize": {
                      "price_formatted": "£120"
                    }
                  }
                ]
              }
            ]
          }
        ],
        "special_timeslots": {
          "asap": "2015-03-24 10:00",
          "best_price": "2015-03-24 12:00"
        }
      }
    ]
  }
}
```


Returns available slots for performing a service.

`"path": "availability"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`transaction_id` | *string* | Identifier for transaction to check availability for


### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`price` | *object* | Description of the price
`price.type` | *string* | Type of the price (check [booking](#bookings)`.price.type`).
`price.description` | *string* | Description text for the price
`availabilities` | *array* | List of days the service is available
`availabilities.date` | *string* | Date of availability
`availabilities.timeslots` | *array* | List of timeslots for the day
`availabilities.timeslots.time` | *string* | Time of timeslot
`availabilities.timeslots.available` | *boolean* | Determines weather slot can be booked
`availabilities.timeslots.tags` | *array\<string\>* | Visual customization of timeslot:<br/>*<b>carbon</b> - carbon slot*<br>*<b>members_only</b> - members only slot*<br>*<b>fully_booked</b> - fully booked*<br>*<b>non_working_day</b> - non working day for service*
`availabilities.timeslots.choice_items` | *array<[choice_item](#choice-items)>* | Timeslot price options as choice items
`special_timeslots` | *object* | Special timeslots
`special_timeslots.asap` | *string* | First available slot
`special_timeslots.best_price` | *string* | Slot with lowest price

### `params`

Parameter | Type | Default | Description
-------- | ----- | ----- | -------
`query.from_date` | *string* | *today* | Filter availability from this date on (date string with format 2018-02-25)
`query.to_date` | *string* | *a week from today* | Filter availability to this date (date string with format 2018-02-25)

* [Common errors](#common-errors)


## Cancel booking


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
        "cancel_reason_id": 123,
        "comment": "Don`t need the service anymore"
}'\
 "https://{{BASE_URL}}/v2/client/bookings/123/cancel"
```

To cancel booking pick a "[cancel reasons](#cancel-reasons)" and pass it with a comment (if required for the reason)

`"path": "bookings/{{id}}/cancel"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`cancel_reason_id`<br>*required* | *integer* | [Cancel reason](#cancel-reasons) user selected from a list of reasons
`comment` | *string* | Comment left by the client (if comment is required for the selected reason)

This endpoint returns:

* [Common errors](#common-errors)


# Units

## Profile


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/profile"
```

> The above request success response is:

```json
{
  "data": {
    "id": 12,
    "username": "john_doe@example.com",
    "name": "John Doe",
    "address": "SW12 2TH Tooley Street",
    "postcode": "SW12 2TH",
    "rating": 4.5,
    "birthdate": 1504857514,
    "gender": "Male",
    "team": "Rusat",
    "country_code": "+44",
    "language_code": "en",
    "phones": [
      {
        "id": 1,
        "value": "07123456789",
        "default": false,
        "sort": 100
      }
    ],
    "avatar": {
      "token": "2331xfasf23423rt43fsdfasDAS",
      "url": "https://files.dxr.cloud/PVk0poyRIuRG2"
    },
    "permissions": {
      "can_message_client": true,
      "can_call_client": true,
      "cannot_decline_jobs": true,
      "can_take_ondemand_jobs": true,
      "has_to_send_summary_on_checkout": true,
      "do_not_track_location": false,
      "do_not_track_geofence": false,
      "can_set_availability": false
    },
    "user_applications": [
      1
    ]
    "created_at": 1504857514
  }
}
```


Profile contains unit details and permissions

`"path": "profile"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`username`<br>*editable* | *string* | Unit email for login
`name`<br>*editable* | *string* | First name and last name of unit
`address`<br>*editable* | *string* | Full address of unit (e.g. street name, building number etc.)
`postcode`<br>*editable* | *string* | Postcode of the unit
`rating` | *double* | Performance score of Unit (1-5)
`birthdate`<br>*editable* | *integer* | Timestamp of unit date of birth
`gender`<br>*editable* | *string* | Gender of the unit
`team` | *string* | Name of team the unit is assigned to
`country_code` | *string* | Country code of area the Unit operates in
`language_code`<br>*editable* | *string* | Language code user chose from Settings in XRM or app. List of languages received at [system_languages](#system-languages)
`phones`<br>*editable* | *array* | List of phone numbers of unit
`phones.id` | *int* | Unique identifier
`phones.value`<br>*editable* | *string* | Phone number
`phones.default`<br>*editable* | *boolean* | Is the phone the default used by the system for receiving calls and SMS
`phones.sort`<br>*editable* | *string* | Order in list
`avatar.token`<br>*editable* | *string* | File server token
`avatar.url` | *string* | URL to avatar image
`permissions` | *array* | List of permissions of unit
`permissions.can_message_client` | *boolean* | Can unit send SMS messages to clients
`permissions.can_call_client` | *boolean* | Can unit call clients
`permissions.cannot_decline_jobs` | *boolean* | Can unit decline jobs
`permissions.can_take_ondemand_jobs` | *boolean* | Can unit receive jobs on-demand via notifications that require response
`permissions.has_to_send_summary_on_checkout` | *boolean* | Should unit send summary on checkout
`permissions.do_not_track_location` | *boolean* | Stops unit from sending updates for current location
`permissions.do_not_track_geofence` | *boolean* | Stops unit from sending updates for entering and leaving areas around bookings
`permissions.can_set_availability` | *boolean* | Can unit set it's availability
`created_at` | *integer* | Timestamp of unit registration




## Jobs


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/jobs"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 2584075,
      "currency_code": "GBP",
      "payment_method": {
        "id": 1,
        "name": "Cash"
      },
      "app_time": 1504620000,
      "flexible_from": null,
      "flexible_to": null,
      "insufficient_travel_time_warning_time": 1504616400,
      "total_formatted": "£97",
      "require_summary": 4,
      "work_time": 120,
      "contacts": [
        {
          "id": 203,
          "value": "02034042956",
          "type": 1,
          "description": "Customer Service",
          "display_positions": [
            2,
            3,
            7,
            8,
            10
          ]
        }
      ],
      "message_templates": [
        {
          "id": 15,
          "title": "In front of the property",
          "message": "Dear [CLIENT_NAME], I am in front of your property. Please let me in or call our office on 02034041930. Your Fantastic Professional",
          "vars": [
            {
              "variable": "CLIENT_NAME",
              "type": "auto",
              "field": "clientName"
            }
          ],
          "destination_option_title": "to office"
        }
      ],
      "decline_reasons": [
        {
          "id": 1,
          "title": "Car is broken",
          "response": "Please contact Stanimir Tomov on 07472761402 - he can find you another.",
          "sort": 100
        }
      ],
      "icons": [
        {
          "name": "Key:",
          "note": "Yes"
        },
        {
          "name": "Alarm:",
          "note": "2351"
        }
      ],
      "service_details": [
        {
          "id": 1,
          "name": "Gardening",
          "prop": [
            {
              "name": "Additional charges such as team compensation,parking,congestion",
              "sort": 1,
              "opt": [
                {
                  "name": "Charges",
                  "sort": 1,
                  "attr": [
                    {
                      "name": "Administration fee",
                      "sort": 1,
                    }
                  ]
                }
              ]
            }
          ]
        }
      ],
      "checklists": [
        123,
        345
      ],
      "checklist_reports": [
        1,
        2
      ],
      "attachments": [
        {
          "mime_type": "image/jpeg",
          "app_token": "231312rfjsa;dkfjsldkjf",
          "thumbnail_url": "http://file.com/31231298301289",
          "url": "http://file.com/31231298301289",
          "note": "This is a comment",
          "lat": 23.4324324,
          "lng": 23.4324324,
          "event_time": 1431936812
        }
      ],
      "summary": {
        "id": 20,
        "work_time": 360,
        "comment": null,
        "money_collected": 0,
        "event_time": 1431936812
      },
      "services_price_modifiers": [
        {
          "service_title": "One-Off cleaning",
          "price_modifiers": [
            {
              "id": 41,
              "name": "Parking",
              "description": "How much was the parking?",
              "type": 11,
              "sort": 100,
              "type_options": {
                "min": 0,
                "max": 80,
                "step": 0.5,
                "value": 0,
                "select_options": [
                  {
                    "id": 6000,
                    "name": "Chairs"
                    },
                    {
                      "id": 6001,
                      "name": "Sofa"
                    }
                ]
              }
            }
          ]
        }
      ],
      "geofence_radiuses": [
        {
          "id": 1,
          "distance": 150
        }
      ],
      "can_change_payment_method": true,
      "can_edit_booking_price": true,
      "can_cross_sell": true,
      "client_contacts": [
        {
          "id": 2197447,
          "info": "07568***919",
          "type": 1,
          "sort": 1
        }
      ],
      "events": [
        {
          "type": 20,
          "event_time": 1504610238
        },
        {
          "type": 70,
          "radius": 1,
          "lat": 23.4324324,
          "lng": 23.4324324,
          "event_time": 1431936812
        },
        {
          "type": 70,
          "note": "This is a comment",
          "lat": 23.4324324,
          "lng": 23.4324324,
          "event_time": 1431936812
        },
        {
          "type": 70,
          "note": "This is a comment",
          "lat": 23.4324324,
          "lng": 23.4324324,
          "event_time": 1431936812
        }
      ],
      "performed": 0,
      "client": {
        "name": "Leigh Turner",
        "stop_sms_channel": true,
        "stop_phone_channel": false
      },
      "client_confirmed_job": true,
      "status": "Booked",
      "paid": false,
      "company_name": "Fantastic Services",
      "company_phone": "02034045188",
      "brand": "Fantastic Services",
      "addresses": [
        {
          "postcode": "UB7 7LQ",
          "contact_person": "",
          "address": "75 Drayton Gardens, WEST DRAYTON, Middlesex, UB7 7LQ",
          "address_note": "",
          "flat": "",
          "parking": "Irrelevant",
          "station": "",
          "lat": 51.50565968,
          "lng": -0.4719201,
          "sort": 100
        }
      ],
      "comments": [
        {
          "id": 1,
          "comment": "This is a comment",
          "lat": 23.4324324,
          "lng": 23.4324324,
          "event_time": 1431936812,
          "created_at": 1431936812,
          "tags": [
            {
              "name": "Pro",
              "color": "#232323"
            },
            {
              "name": "System",
              "color": "#343434"
            }
          ]
        }
      ]
    }
  ],
  "meta": {
    "databaseVersion": 70,
    "iOSLatestApplicationBuild": 300,
    "androidLatestApplicationBuild": 1,
    "urid": "d93f873d1c78a426ee2185a8ca325db22c758c19cf2f1bcbbfccd787a396a64e"
  }
}
```


Schedule with jobs for the unit

`"path": "jobs"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`app_time` | *integer* | Appointment time for the job in UTC timestamp
`flexible_from` | *integer* | Start of timeframe to execute the job in UTC timestamp
`flexible_to` | *integer* | End of timeframe to execute the job in UTC timestamp
`client_name` | *string* | Client name
`client_contacts` | *array client_contacts* | Phone numbers client provided for contact
`total_formatted` | *string* | Price of the service
`payment_method` | *array payment_methods* | Payment method client will use to pay
`currency_code` | *string* | Currency code
`paid` | *boolean* | Flag indicating if client is charged
`work_time` | *integer* | Job duration in minutes
`require_summary` | *integer* | *<b>0</b> - No summary required*<br>*<b>1</b> - Should send summary at the end of the day*<br>*<b>2</b> - Should send summary now*<br>*<b>3</b> - Can't proceed until summary sent*<br>*<b>4</b> - Summary sent*
`performed` | *integer* | *<b>0</b> - No checkout or auto performed*<br>*<b>1</b> - Checked out*<br>*<b>2</b> - Auto performed (24h passed)*
`rating` | *double* | Performance score of Unit (1-5)
`birthdate` | *integer* | Timestamp of unit date of birth
`gender` | *string* | Gender of the unit
`team` | *string* | Name of team the unit is assigned to
`country_code` | *string* | Country code of area the Unit operates in
`language_code` | *string* | Language code user chose from Settings in XRM or app. List of languages received at [system_languages](#system-languages)
`events.type` | *integer* | *<b>1</b> - Checkin*<br>*<b>2</b> - Checkout*<br>*<b>7</b> - View*<br>*<b>8</b> - Confirm*<br>*<b>12</b> - Arrive*<br>*<b>13</b> - Depart*<br>
`phones` | *array* | List of phone numbers of unit
`phones.id` | *int* | Unique identifier
`phones.value` | *string* | Phone number
`phones.default` | *boolean* | Is the phone the default used by the system for receiving calls and SMS
`phones.sort` | *string* | Order in list
`avatar.token` | *string* | File server token
`avatar.url` | *string* | URL to avatar image
`services_price_modifiers` | *array* | Price modifiers for included services in the job
`services_price_modifiers.price_modifiers` | *array* | Price modifiers for a service in the job
`services_price_modifiers.price_modifiers.type` | *integer* | Check service.choices.[choice_items](#choice-items).type
`comments` | *array* | List of comments for the job
`comments.event_time` | *integer* | UTC timestamp of when the comment was created on the device
`comments.created_at` | *integer* | UTC timestamp of when the comment was created on the server
`created_at` | *integer* | Timestamp of unit registration


## Jobs history


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/jobs_history"
```

History of schedule with [jobs](#jobs) for the unit

`"path": "jobs_history"`

### `params`

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`query.from_date` | *integer* | *yesterday* | UTC time stamp to filter results from a date
`query.to_date` | *integer* | *last Monday* | UTC time stamp to filter results to a date


## Payment methods


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/payment_methods"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 25,
      "sort": 100,
      "Title": "Cash"
    }
  ]
}
```

Client ratings for the unit.

`"path": "payment_methods"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`sort` | *integer* | Order of item in list
`title` | *string* | Title of payment method

This endpoint returns:

* [Common errors](#common-errors)


## Call client reasons


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/call_client_reasons"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 25,
      "sort": 100,
      "title": "I am in front of your property"
    }
  ]
}
```

Client ratings for the unit.

`"path": "call_client_reasons"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`sort` | *integer* | Order of item in list
`title` | *string* | Title of reason

This endpoint returns:

* [Common errors](#common-errors)



## System contacts


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/system_contacts"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 25,
      "value": "I am in front of your property",
      "type": 1,
      "description": "Customer Service",
      "display_positions": [
        1,
        3,
        4,
        5,
        6,
        8,
        9
      ]
    }
  ]
}
```

Client ratings for the unit.

`"path": "system_contacts"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`value` | *string* | Phone number, skype name or other identifier for contact
`type` | *integer* | *<b>1</b> - Phone*<br>*<b>2</b> - Skype*<br>*<b>3</b> - Chat*
`description` | *string* | Display text of contact
`display_positions` | *array<integer>* | Position slot in the UI

This endpoint returns:

* [Common errors](#common-errors)



## System languages


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/system_languages"
```

> The above request success response is:

```json
{
  "data": [
    {
      "title": "English",
      "code": "en"
    },
    {
      "title": "Български",
      "code": "bg"
    }
  ]
}
```


Available system languages for visualising the interface in XRM or BFantastic

`"path": "system_languages"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`title` | *string* | Display title of language in Settings
`code` | *string* | ISO 639-1 two-letter language code


## Register voucher


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
        "voucher_code": "23DSAD54"
}'\
 "https://{{BASE_URL}}/v2/unit/register_voucher"
```

Units can register vouchers. Bookings with registered voucher will bring them bonuses.

`"path": "register_voucher"`

This endpoint returns:

* [Common errors](#common-errors)
* [Register voucher errors](#register-voucher-errors)

## Registered vouchers



```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/registered_vouchers"
```

> The above request success response is:

```json
{
  "data": [
    {
      "voucher_code": "GO10OFF",
      "created_at": 1492511551
    },
    {
      "voucher_code": "GO20OFF",
      "created_at": 1492522551
    }
  ]
}
```


Units can review their registered vouchers.

`"path": "registered_vouchers"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`voucher_code` | *string* | Voucher code
`created_at` | *integer* | Timestamp when the voucher was registered

This endpoint returns:

* [Common errors](#common-errors)



## Checklists


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/jobs/12/checklists"
```

> The above request success response is:

```json
{
  "data": [
    {
      "type": 1,
      "choices": [
        {
          "id": 1,
          "sort": 100,
          "required": true,
          "title": "How many bedrooms are there?",
          "choice_items": [
            {
              "id": 2,
              "sort": 100,
              "type": 1,
              "title": "1 Bedroom"
            }
          ]
        }
      ]
    }
  ]
}
```

Checklists for performing a job

`"path": "jobs/{{id}}/checklists"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`type` | *integer* | *<b>10</b> - After checkin*<br>*<b>20</b> - Before checkout*
`choices` | *array* | Checklist questions
`choices.id` | *integer* | Unique identifier
`choices.sort` | *integer* | Order of item in list
`choices.required` | *boolean* | Should question be answered to send the checklist
`choices.title` | *string* | Checklist question
`choices.choice_items` | *array* | Question answers
`choices.choice_items.id` | *integer* | Unique identifier
`choices.choice_items.sort` | *integer* | Order of item in list
`choices.choice_items.type` | *integer* | Check service.choices.[choice_items](#choice-items).type
`choices.choice_items.title` | *string* | Checklist question answer



## Checklist reports


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/jobs/12/checklist_reports"
```

> The above request success response is:

```json
{
  "data": [
    {
      "type": 1,
      "event_time": 1495702059,
      "choice_items": [
        {
          "id": 2,
          "value": "1"
        },
        {
          "id": 2,
          "value": [
            "23hjfkajsdhfe198237019"
          ]
        }
      ]
    }
  ]
}
```

Checklist answers after filling checklist.

`"path": "jobs/{{id}}/checklist_reports"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`type` | *integer* | Checklist type (see [checklists](#checklists))
`event_time` | *integer* | Timestamp when the event ocurred and was saved.
`choice_items` | *array* | Checklist answers
`choice_items.id` | *integer* | Unique identifier
`choice_items.value` | *string/array* | Answer user entered


## Ratings


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/ratings"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 25,
      "rate": 4,
      "comment": "Didn't clean the kitchen well",
      "client_name": "John Doe",
      "created_at": 1496233156
    },
    {
      "id": 25,
      "rate": 4,
      "comment": "Didn't clean the kitchen well",
      "created_at": 1496233156
    }
  ]
}
```

Client ratings for the unit.

`"path": "ratings"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`rate` | *integer* | Rating client gave for the job
`comment` | *string* | Client comment upon rating the job 
`client_name` | *string* | Name of client who rated the job
`created_at` | *integer* | Timestamp when the rating was made

This endpoint returns:

* [Common errors](#common-errors)


## Tracked locations


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/tracked_locations"
```

> The above request success response is:

```json
{
  "data": [
    {
      "lat": 21.197216,
      "lng": 21.621094,
      "event_time": 1496922768
    }
  ]
}
```

Locations tracked over time for the unit.

`"path": "tracked_locations"`

### Request parameters

Parameter | Type | Description
-------- | ----- | -------
`lat` | *double* | Latitude tracked
`lat` | *double* | Longitude tracked
`event_time` | *integer* | Timestamp when the event occurred and was saved (may be sent later)

This endpoint returns:

* [Common errors](#common-errors)
* [Tracked locations errors](#tracked-locations-errors)


## Work time

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/work_time"
```

> The above request success response is:

```json
{
  "data": [
     {
      "day_of_week": 1,
      "intervals": [
        {
          "from_time": "10:00",
          "to_time": "14:00"
        },
        {
          "from_time": "15:00",
          "to_time": "19:00"
        }
      ]
    }
  ]
}
```

Unit week work time (shifts).

`"path": "work_time"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`day_of_week` | *integer* | Day of the week:<br>*<b>1</b> - Monday*<br>*<b>2</b> - Tuesday*<br>*<b>3</b> - Wednesday*<br>*<b>4</b> - Thursday*<br>*<b>5</b> - Friday*<br>*<b>6</b> - Saturday*<br>*<b>7</b> - Sunday*
`intervals` | *array\<intervals\>* | List of working intervals for the day
`intervals.from_time` | *string* | Start time of interval (time string with format 10:00)
`intervals.to_time` | *string* | End time of interval (time string with format 10:00)


## Availability

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/availability"
```

> The above request success response is:

```json
{
  "data": [
     {
      "date": "21-02-2018",
      "intervals": [
        {
          "from_time": "10:00",
          "to_time": "14:00"
        },
        {
          "from_time": "15:00",
          "to_time": "19:00"
        }
      ],
      "pending_requests": [
        1,
        2,
        3
      ]
    }
  ]
}
```

Unit availability (shifts).

`"path": "availability"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`date` | *string* | Date of availability (date string with format 2018-02-25)
`intervals` | *array\<intervals\>* | List of working intervals for the day
`intervals.from_time` | *string* | Start time of interval (time string with format 10:00)
`intervals.to_time` | *string* | End time of interval (time string with format 10:00)
`pending_requests` | *array\<[availability_requests](#availability-requests)\>* | List of pending requests for the day

### `params`

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`query.from_date` | *integer* | *Monday* | UTC time stamp to filter results from a date
`query.to_date` | *integer* | *Sunday* | UTC time stamp to filter results to a date

## Availability requests

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/availability_requests"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 1,
      "type": "time_off",
      "from_formatted": "2018-12-25 12:00",
      "to_formatted": "2018-12-25 18:00",
      "dayoff_type_id": 1,
      "comment": "Want to have a break on 25th afternoon",
      "status": "approved",
      "created_at": 1528180405,
      "updated_at": 1528180405
    },
    {
      "id": 2,
      "type": "days_off",
      "from_formatted": "2018-12-25 00:00",
      "to_formatted": "2018-12-25 23:59",
      "dayoff_type_id": 1,
      "comment": "Want to take the day 25th off",
      "status": "declined",
      "created_at": 1528180405,
      "updated_at": 1528180405
    },
    {
      "id": 3,
      "type": "work_time",
      "day_of_week": 2,
      "intervals": [
        {
          "from_time": "10:00",
          "to_time": "14:00"
        },
        {
          "from_time": "15:00",
          "to_time": "19:00"
        }
      ],
      "comment": "Want to work from 10:00-14:00 and from 15:00-19:00 Tuesdays",
      "status": "pending",
      "created_at": 1528180405,
      "updated_at": 1528180405
    },
    {
      "id": 3,
      "type": "work_time",
      "day_of_week": 7,
      "dayoff_type_id": 1,
      "comment": "Won't work in Sundays",
      "status": "pending",
      "created_at": 1528180405,
      "updated_at": 1528180405
    }
  ]
}
```

Requests of unit for changes of availability (shifts, working days etc.).

`"path": "availability_requests"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`type` | *string* | Request type:<br>*<b>time_off</b> - Part of day off*<br>*<b>days_off</b> - Days off*<br>*<b>work_time</b> - Change in shift*
`from_formatted` | *string* | Request start date formatted (string date with format 2018-12-25 12:00)
`to_formatted` | *string* | Request end date formatted (string date with format 2018-12-25 12:00)
`dayoff_type_id` | *integer* | `id` of [reason](#day-off-types) for change.
`day_of_week` | *integer* | Day of the week:<br>*<b>1</b> - Monday*<br>*<b>2</b> - Tuesday*<br>*<b>3</b> - Wednesday*<br>*<b>4</b> - Thursday*<br>*<b>5</b> - Friday*<br>*<b>6</b> - Sunday*
`comment` | *string* | Unit comment for request
`status` | *string* | Status of request:<br>*<b>pending</b> - Waiting for approval*<br>*<b>approved</b> - Approved*<br>*<b>declined</b> - Declined*
`created_at` | *integer* | Unix timestamp when request is created
`updated_at` | *integer* | Unix timestamp when request is updated (approved or declined)

### `params`

Parameter | Type | Default | Description
-------- | ----- | ----- | -------
`filter.status`<br>*optional* | *string* | *all statuses*  | Filters availability requests by `status`. If no filter is passed all availability requests are returned. To filter availability requests by more than one status pass an array of statuses e.g. `["pending", "approved"]`


## Day off types

```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/day_off_types"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 1,
      "name": "Broken car",
      "sort": 100
    }
  ]
}
```

Reasons for availability change.

`"path": "day_off_types"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`name` | *string* | Name of day off reason
`sort` | *integer* | Order of item in list


## Feedback

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -d '{
        "text": "I really like this app!"
}'\
 "https://{{BASE_URL}}/v2/unit/feedback"
```

> The above request success response is :

```json
{
  "data": null,
  "success": [
    {
      "code": 2000,
      "message": "Success",
      "debug_message": null,
      "debug_id": null
    }
  ]
}
```

Units can share feedback on their experience with the system.

`"path": "feedback"`

### Feedback request parameters

Parameter | Type | Description
-------- | ----- | -------
`text`<br>*required* | *string* | Unit feedback input text

* [Common errors](#common-errors)

## Send message

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -d '{
        "booking_id": 123,
        "message_template_id": 12,
        "vars": [
         {
           "variable": "DELAY_MINUTES",
           "value": "25"
         },
       "lat": 51.604903,
       "lng": -0.457022
  ]
}'\
 "https://{{BASE_URL}}/v2/unit/send_message"
```

Units can send messages to clients using [message templates](#jobs)

`"path": "send_message"`

### Send message request parameters

Parameter | Type | Description
-------- | ----- | -------
`booking_id`<br>*required* | *integer* | Identifier for job to whose client message will be sent
`message_template_id`<br>*required* | *integer* | Message template used for the message
`vars` | *array* | List of variables for the message template
`vars.variable` | *string* | Variable name
`vars.value` | *string* | Unit input for variable
`lat` | *double* | Latitude where event occured
`lng` | *double* | Longitude where event occured

* [Common errors](#common-errors)



## Decline job

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -d '{
        "reason_id": 123,
        "comment": "Can not get on time",
        "lat": 51.604903,
        "lng": -0.457022
}'\
 "https://{{BASE_URL}}/v2/unit/jobs/123/decline"
```

Units can decline jobs by passing decline_reason

`"path": "jobs/{job id}/decline"`

### Decline job request parameters

Parameter | Type | Description
-------- | ----- | -------
`reason_id`<br>*required* | *integer* | Identifier for decline_reason unit chose
`comment` | *string* | Message template used for the message
`lat` | *double* | Latitude where event occured
`lng` | *double* | Longitude where event occured

* [Common errors](#common-errors)




## Register voucher


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
        "voucher_code": "23DSAD54"
}'\
 "https://{{BASE_URL}}/v2/unit/register_voucher"
```

Units can register vouchers. Bookings with registered voucher will bring them bonuses.

`"path": "register_voucher"`

This endpoint returns:

* [Common errors](#common-errors)
* [Register voucher errors](#register-voucher-errors)


## Job offers


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/unit/job_offers"
```

List of available [job](#jobs) offers for the unit

`"path": "job_offers"`

### Response parameters (additional to job)

Parameter | Type | Description
-------- | ----- | -------
`offer_id` | *integer* | Unique identifier for the offer
`offer_expire_time` | *integer* | Time when offer expires UTC timestamp


This endpoint returns:

* [Common errors](#common-errors)
* [Job offers errors](#job-offers-errors)

## Reply job offers

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
        "job_offer_id": "23kljhkl34hl1k23",
        "reply": 1
}'\
"https://{{BASE_URL}}/v2/unit/reply_job_offer"
```

When job offers are received unit can accept or decline them.

`"path": "reply_job_offer"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`job_offer_id` | *integer* | Uniquie identifier of the offer
`reply` | *integer* | *<b>1</b> - Accept*<br>*<b>2</b> - Decline*

This endpoint returns:

* [Common errors](#common-errors)
* [Reply job offer errors](#reply-job-offer-errors)


# Shared

## User applications


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/shared/user_applications"
```

> The above request success response is:

```json
{
  "id": 1,
  "guid": "98z07v980vbn98790zx7v9c8vx7890xzc8v7",
  "push_token": "98z07v980vbn98790zx7v9c8vx7890xzc8v7",
  "build": 231,
  "version": "1.15.2",
  "device": "iPhone 6S",
  "device_resolution": "1915x949",
  "os": "iOS",
  "os_version": "8.1.1",
  "db_size": 25.4,
  "client_application_size": 25.4,
  "battery_usage": 25.4,
  "data_usage": 25.4,
  "profile": "UnitedKingdom",
  "browser": "Chrome",
  "browser_version": "63.0.3239.132",
  "browser_language": "en-US",
  "browser_resolution": "1915x949",
  "application": {
    "id": 1,
    "title": "BFantastic iOS"
  }
}
```

Details for the environment on which the user uses the application.

`"path": "user_applications"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id`<br>*read-only* | *integer* | Unique identifier
`guid` | *string* | Unique device identifier
`push_token` | *string* | Unique identifier for sending push notifications
`build` | *integer* | Application build number
`version` | *string* | Application version
`device` | *string* | Device model
`device_resolution` | *string* | Device screen resolution
`os` | *string* | Device operating system
`os_version` | *string* | Device operating system version
`db_size` | *double* | Database size on device
`client_application_size` | *double* | Application size on device
`battery_usage` | *double* | Percentage used from the application
`data_usage`<br>*read only* | *double* | KB the application used in communication with the server
`profile`<br>*read only* | *string* | Currently selected profile (keyword)
`browser` | *string* | Browser used to access the application
`browser_version` | *string* | Version of the browser used to access the application
`browser_language` | *string* | Language of the browser used to access the application
`browser_resolution` | *string* | Resolution of the window of the browser used to access the application
`application`<br>*read only* | *integer* | External App application (based on X-Application)

This endpoint returns:

* [Common errors](#common-errors)

## Push notifications


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/shared/push_notifications"
```

> The above request success response is:

```json
{
  "data": [
    {
      "id": 25,
      "status": 3000,
      "action": 1,
      "message": "Text from push notification",
      "sound": "default.mp3",
      "payload": null,
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for popup is:

```json
{
  "data": [
    {
      "id": 26,
      "status": 3000,
      "action": 2,
      "message": "Checkout our fresh deal!",
      "sound": "default.mp3",
      "payload": {
        "popup": {
          "image_url": "http://images.com/photo.jpg",
          "title": "Hello there",
          "description": "This is awesome, you should try!",
          "cta_button": {
            "title": "Got it!",
            "target": {
              "screen_id": 1,
              "item_id": 1
            }
          },
          "voucher": {
            "voucher_code": "FREE",
            "banner_title": "Use voucher code FREE for a free service",
            "valid_to": 1497429186
          }
        }
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for inbox is:

```json
{
  "data": [
    {
      "id": 26,
      "status": 3000,
      "action": 3,
      "message": "The dog is tied.",
      "sound": "default.mp3",
      "payload": {
        "message": {
          "job_id": 1,
          "client_name": "John Doe",
          "postcode": "SW12 2TH",
          "text": "The dog is tied."
        }
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for job offer is:

```json
{
  "data": [
    {
      "id": 26,
      "status": 3000,
      "action": 7,
      "message": "Checkout our fresh deal!",
      "sound": "default.mp3",
      "payload": {
        "job_offer": {
          "id": 123,
          "expire_time":1497859985,
          "available": true
        }
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for target is:

```json
{
  "data": [
    {
      "id": 26,
      "status": 3000,
      "action": 8,
      "message": "Checkout our fresh deal!",
      "sound": "default.mp3",
      "payload": {
        "target": {
          "screen_id": 1,
          "item_id": 1
        }
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for rating is:

```json
{
  "data": [
    {
      "id": 25,
      "status": 3000,
      "action": 10,
      "message": "You just got rated! Check out your score.",
      "sound": "rate.mp3",
      "payload": {
        "rate": 4,
        "comment": "Didn't clean the kitchen well",
        "client_name": "John Doe"
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for bonus is:

```json
{
  "data": [
    {
      "id": 26,
      "status": 3000,
      "action": 13,
      "message": "Checkout our fresh deal!",
      "sound": "bonus.mp3",
      "payload": {
        "bonus": 5,
        "bonus_formatted": "£5",
        "total_bonus": 20,
        "total_bonus_formatted": "£20",
        "service": "Carpet Cleaning"
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for added job to schedule is:

```json
{
  "data": [
    {
      "id": 26,
      "status": 3000,
      "action": 14,
      "message": "New job received - Gardening at SW12 2TH starting 10:00.",
      "sound": "new_job.mp3",
      "payload": {
          "booking_id": 123
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for removed job from schedule is:

```json
{
  "data": [
    {
      "id": 26,
      "status": 3000,
      "action": 15,
      "message": "Removed job - Gardening at SW12 2TH starting 10:00.",
      "sound": "removed_job.mp3",
      "payload": {
          "booking_id": 123
      },
      "created_at": 1497859985
    }
  ]
}
```


> The above request success response for appointment time change is:

```json
{
  "data": [
    {
      "id": 27,
      "status": 3000,
      "action": 16,
      "message": "Hey, SW12 2TH 10:00 has been changed to 12:00.",
      "sound": "default.mp3",
      "payload": {
          "booking_id": 123
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for price change is:

```json
{
  "data": [
    {
      "id": 28,
      "status": 3000,
      "action": 17,
      "message": "Hey, SW12 2TH at 10:00 total has been changed from £120 to £180.",
      "sound": "default.mp3",
      "payload": {
          "booking_id": 123
      },
      "created_at": 1497859985
    }
  ]
}
```


> The above request success response for payment method change is:

```json
{
  "data": [
    {
      "id": 29,
      "status": 3000,
      "action": 18,
      "message": "Hey, SW12 2TH at 10:00 has been changed from Cash to Card.",
      "sound": "default.mp3",
      "payload": {
          "booking_id": 123
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for payment status change is:

```json
{
  "data": [
    {
      "id": 30,
      "status": 3000,
      "action": 19,
      "message": "Hey, SW12 2TH at 10:00 has been changed from Unpaid to Paid.",
      "sound": "default.mp3",
      "payload": {
          "booking_id": 123
      },
      "created_at": 1497859985
    }
  ]
}
```

> The above request success response for new job comment is:

```json
{
  "data": [
    {
      "id": 31,
      "status": 3000,
      "action": 20,
      "message": "Hey, you have %d new comment for SW12 2TH at 10:00.",
      "sound": "default.mp3",
      "payload": {
          "booking_id": 123
      },
      "created_at": 1497859985
    }
  ]
}
```

History of all pushes sent to unit.

`"path": "push_notifications"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`status` | *integer* | *<b>500</b> - Pending*<br>*<b>1000</b> - Sent*<br>*<b>1500</b> - Failed*<br>*<b>2000</b> - Delivered*<br>*<b>3000</b> - Seen*
`action` | *integer* | Describes what action should be triggered on the unit. Pushes can be regular (with sound and message) or silent (waking up the app, no sound or message)<br><br>*<b>1</b> - Update jobs (silent)*<br>*<b>2</b> - Popup message (regular)*<br>*<b>3</b> - Inbox message (regular)*<br>*<b>5</b> - Update location (silent)*<br>*<b>6</b> - New job (silent)*<br>*<b>7</b> - New job (regular)*<br>*<b>8</b> - Open service (regular)*<br>*<b>9</b> - Open chat (regular)*<br>*<b>10</b> - New rating (regular)*<br>*<b>11</b> - Offer with promo code (regular)*<br>*<b>12</b> - Custom*<br>*<b>13</b> - New bonus (regular)*<br>*<b>14</b> - Added new job to schedule (regular)*<br>*<b>15</b> - Removed job from schedule (regular)*<br>*<b>16</b> - Job appointment time changed (regular)*<br>*<b>17</b> - Job price changed (regular)*<br>*<b>18</b> - Job payment method changed (regular)*<br>*<b>19</b> - Job payment status changed (regular)*<br>*<b>20</b> - Job new comment (regular)*<br>*<b>100</b> - Upload database to server (silent)*
`message` | *string* | Push notification text
`sound` | *string* | Push notification sound file name
`payload` <br>*dynamic* | *object* | Custom data based on action
`created_at` | *integer* | Timestamp of creation

### Popup push response parameters

Parameter | Type | Description
-------- | ----- | -------
`payload.popup.image_url` | *string* | 
`payload.popup.title` | *string* | 
`payload.popup.description` | *string* | 
`payload.popup.cta_button.title` | *string* | 
`payload.popup.cta_button.target.screen_id` | *integer* | Determines which screen is opened when tapping the CTA button:<br/>*<b>1</b> - Categories*<br>*<b>2</b> - Category*<br>*<b>3</b> - Service*<br>*<b>4</b> - Deals*<br>*<b>5</b> - Deal*<br>*<b>6</b> - Chat*<br>*<b>7</b> - Referral*<br>*<b>8</b> - Treats*<br>*<b>9</b> - Membership*<br>*<b>10</b> - Privacy policy*
`payload.popup.cta_button.target.screen_id.item_id` | *integer* | 
`payload.popup.voucher.voucher_code` | *string* | 
`payload.popup.voucher.title` | *string* | 
`payload.popup.voucher.valid_to` | *integer* | 

### Job offer push response parameters

Parameter | Type | Description
-------- | ----- | -------
`payload.job_offer.id` | *integer* | 
`payload.job_offer.expire_time` | *integer* | 
`payload.job_offer.available` | *boolean* | 

### Open content push response parameters

Parameter | Type | Description
-------- | ----- | -------
`payload.target.screen_id` | *integer* | 
`payload.target.item_id` | *integer* | 

### Rate push response parameters

Parameter | Type | Description
-------- | ----- | -------
`payload.rate` | *integer* | Rating client gave for the job
`payload.comment` | *string* | Client comment upon rating the job
`payload.client_name` | *string* | Name of client who rated the job

### Bonus push response parameters

Parameter | Type | Description
-------- | ----- | -------
`payload.bonus` | *double* | Bonus for cross-sell on sight or with flyer
`payload.bonus_formatted` | *string* | Formatted bonus for cross-sell on sight or with flyer
`payload.total_bonus` | *double* | Total bonus to collect before current bonus
`payload.total_bonus_formatted` | *string* | Formatted total bonus to collect before current bonus
`payload.service` | *string* | Cross-selled service name

### `params`

Parameter | Type | Default | Description
-------- | ----- | ----- | -------
`query.created_at_gt`<br>*optional* | *integer* | *<b>0</b>* | Filters response with created_at greater than the passed
`filter.action`<br>*optional* | *integer* | *all actions* | Filters push notifications by `action`. If no filter is passed all push notifications are returned. To filter push notifications by more than one action pass an array of actions e.g. `[1, 2]`

This endpoint returns:

* [Common errors](#common-errors)


## Server time


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/shared/server_time"
```

> The above request success response is:

```json
{
  "data": [
    {
      "utc_time": 1497859985
    }
  ]
}
```

The current time on the server.

`"path": "server_time"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`utc_time` | *integer* | UTC timestamp


## Tasks

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "booking_reference_number": "180619112MB",
  "priority_id": 34,
  "description": "some random description",
  "department_id": 7112,
  "user_id": 1763,
  "schedule_time_formatted": "2018-06-19 12:00:00",
  "email_on_completion": "tihomir.kamenov@1stonlinesolutions.com"
}'\
"https://{{BASE_URL}}/v2/shared/tasks"
```

Creates task to files. Used when clients want to make changes on a booking that require manual action from operator.

`"path": "tasks"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`booking_reference_number` | *string* | Reference number of booking to create task to
`priority_id` | *integer* | identifier of priority to create task with
`description` | *string* | Text comment left on creating the task
`department_id`<br>*read-only* | *integer* | Identifier of department that will take care of the task
`user_id`<br>*read-only* | *integer* | Identifier of user that will take care of the task
`schedule_time_formatted`<br>*read-only* | *string* | Time of tasks when the task has to be performed
`email_on_completion`<br>*read-only* | *string* | Email recepient of task completion notification email

This endpoint returns:

* [Common errors](#common-errors)


## Edit requests (temporary)

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "booking_id": 123,
  "reason_id": 34,
  "comment": "some random description"
}'\
"https://{{BASE_URL}}/v2/shared/edit_requests"
```

Creates task to files for changes on regular plan, sessions or bookings.

`"path": "edit_requests"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`booking_id` | *integer* | Object id of booking to create task to
`reason_id` | *integer* | Identifier of edit booking or plan reasons selected
`comment` | *string* | Text comment left on creating the task

This endpoint returns:

* [Common errors](#common-errors)




## Add note (temporary)

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Profile: {{PROFILE_ID}}"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "booking_id": 123,
  "note": "Bring detergents"
}'\
"https://{{BASE_URL}}/v2/shared/add_note"
```

Adds a comment to the booking.

`"path": "add_note"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`booking_id` | *integer* | Object id of booking to add note to
`comment` | *string* | Text comment left

This endpoint returns:

* [Common errors](#common-errors)


## Exceptions

```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
 -d '{
  "path": "https://middlepoint-dev.1dxr.com/v2/client/addresses",
  "message": "Invalid path",
  "body": {
    "address_line_1": "Red Lion Street 24",
    "postcode": "22"
  },
  "external_identifier": "AccountViewController",
  "exception": ""
}'\
"https://{{BASE_URL}}/v2/shared/exceptions"
```

Errors appearing on clients.

`"path": "exceptions"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`path` | *string* | Request path
`message` | *string* | Message returned from server
`body` | *string* | Content for error
`external_identifier` | *string* | Identifier for the source of the error on the client
`exception` | *string* | Details for the exception

This endpoint returns:

* [Common errors](#common-errors)
