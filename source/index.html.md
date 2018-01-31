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




# Introductionn

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

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`expand` | *array* | *none* | By default child objects are returned as id. With this attribute they can be returned as full objects. Send array of attribute names to expand.<br><br> Keywords:<br><br>all - *expands all first level attributes*<br>all.all - *expands all second level attributes*<br>attribute.all - *expands all attributes child elements*
`fields` | *array* | *all* | Attributes to receive in response
`exclude_fields` | *array* | *none* | Attributes to exclude from response
`include_fields` | *array* | *none* | Attributes to add to response which are not returned by default
`return_meta` | *boolean* | *false* | Weather response includes `meta`
`paging`<br>*optional* | *object* | *none* | Information about paged results
`paging.offset` | *integer* | *0* | Page starting element
`paging.limit` | *integer* | *10* | Page size
`filter` | *array\<string\>* | *none* | Paramters for filtering results. It can contain attributes and values. Examples:<br/><br/><i>`default=true` will return only objects that have attribute `default` equal to `true`.<br/><br/>`phones.default=true` will return only objects that have attribute `phones` containing objects with attribute `default` equal to `true`.<i>

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
`return`<br>*optional* | *string* | Determines response content for successfully created/updated object:<br><br>`id` - returns the id of the created/updated object<br>`object` - returns the full created/updated object


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
      "path": "addresses",
      "params": null,
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
    "payment_methods": [
      1,
      3,
      5
    ]
}
```

> The above request web profile success response is:

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
`payment_methods` | *array\<[payment_methods](#payment-methods)\>* | Payment methods for profile

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
          "name": "address1",
          "regex": "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)",
          "required": true
        },
        {
          "name": "address2",
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
`return_user`<br>*optional, default <b>false</b>* | *boolean* | Return user object with expanded avatar, phones, addresses, payment details and last 10 bookings.

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
        "type_id": 1
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


### `params`

Parameter | Type | Description
-------- | ----- | -------
`return_user`<br>*optional, default <b>false</b>* | *boolean* | Return user object with expanded phones objects.

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`login` | *[object](#login)* | Object containing session information. Same is returned on login.
`user` | *object* | Created user after registration

This endpoint returns:

* [Common errors](#common-errors)
* [Registration errors](#register-errors)


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
`thumbnail_image_url` | *string* | Link to thumbnail image
`infos` | *array\<info\>* | List of infos for the category
`services` | *array\<[service](#services)\>* | List of services for the category
`profile_config` | *object* | Key-value pairs of custom attributes with different values for each Profile





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
      "active": true,
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
      "inactive_list_image_url": "http://www.image.com/1jsklfas.jpg",
      "choices_images_urls": [
        "http://www.image.com/1jsklfas.jpg",
        "http://www.image.com/1jsklfas.jpg",
        "http://www.image.com/1jsklfas.jpg"
      ],
      "thumbnail_image_url": "http://www.image.com/1jsklfas.jpg",
      "logo_image_url": "http://www.image.com/1jsklfas.jpg",
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
        "tooltip": "Click here"
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
`active` | *boolean* | Is the service activated and has to be shown
`title` | *string* | Service title text
`phone` | *string* | Service phone number
`description` | *string* | Service detailed description text
`short_description` | *string* | Service short description text
`keywords` | *array\<string\>* | List of keywords for service
`list_image_url` | *string* | Link to list image
`thumbnail_image_url` | *string* | Link to thumbnail image
`inactive_list_image_url` | *string* | Link to inactive image for displaying past and cancelled bookings
`choices_images_urls` | *string* | Link to choices images rotating in booking process
`logo_image_url` | *string* | Link to logo image
`infos` | *array\<info\>* | List of infos for the services
`choices` | *array\<[choice](#choices)\>* | List of questions to book the service
`payment_methods` | *array\<[payment_methods](#payment-methods)\>* | List of available payment methods for the service
`customize` | *object* | Key-value pairs of custom attributes
`profile_config` | *object* | Key-value pairs of custom attributes with different values for each Profile
`logic_js` | *string* | JavaScript containing functions for modification of booking process

### `params`

Parameter | Type   | Default | Description
-------- | ---------- | ---- | -------
`visible` | *string* | *true* | Filters services by visible flag. If `any` passed both `true` and `false` are returned.


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
`title` | *string* | Question text
`summary_title` | *string* | Question short title text in summary
`required` | *boolean* | Should the question be answered to book
`choice_items` | *array\<[choice_item](#choice-items)\>* | List of answers for the question





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
      "summary_title": "",
      "is_in_summary": false,
      "name": "1 bedroom",
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
`type` | *integer* | *<b>1</b> - Check*<br>*<b>2</b> - Radio*<br>*<b>3</b> - Stepper (incremental value)*<br>*<b>4</b> - Text field*<br>*<b>5</b> - Hours (total hours for current booking configuration)*<br>*<b>6</b> - Drop down*<br>*<b>7</b> - Multi select (autocomplete with quantity)*<br>*<b>8</b> - Distance*<br>*<b>9</b> - Always Apply*<br>*<b>10</b> - Price per hour*<br>*<b>11</b> - Decimal Text*<br>*<b>12</b> - Photo attachment*
`max_value` | *integer* | Maximum value of answer
`min_value` | *integer* | Minimum value of answer
`value` | *integer* | Default value of answer
`duration` | *integer* | Minutes added to booking estimated time from the answer
`summary_title` | *string* | Answer short title text in summary
`is_in_summary` | *boolean* | Should the answer be included in the summary of booking
`name` | *string* | Title of answer
`choice_items` | *array\<[choice_item](#choice-items)\>* | List of sub-answers for the answers
`image_url`| *string* | List image for choice item
`customize` | *object* | Key-value pairs of custom attributes




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
      "sort": 1,
      "default": true,
      "title": "Cash",
      "type": "None",
      "data": null,
      "payment_provider_id": null,
      "icon_image_url": "http://image.url/here.jpg"
    },
    {
      "id": 2,
      "sort": 1,
      "default": false,
      "title": "Card",
      "type": "Stripe",
      "payment_provider_id": 3,
      "data": {
        "stripe_key": "kdj9DSA923131safdfd89a7fklj`cxzc"
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
`type` | *string* | *<b>None</b> - No processing needed (e.g. Cash payment)*<br>*<b>Stripe</b> - Card payment via Stripe*
`payment_provider_id` | *integer* | Identifier for the the account used for the payment method (e.g. Stripe UK, Stripe AUS etc.)
`data`<br>*optional* | *object* | Based on the payment provider different data may be provided (such as keys, tokens etc.)
`data.stripe_key`<br>*optional* | *string* | Stripe API authorization key
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



# Clients

## User


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/user"
```

> The above request success response is:

```json
{
  "id": 1,
  "first_name": "John",
  "last_name": "Doe",
  "email": "johndoe@mail.com",
  "title": 2,
  "social_login_provider": 1,
  "type": 2,
  "social_id": "@johndoe",
  "last_profile": "UnitedKingdom",
  "created_at": 1433489660,
  "membership": 1,
  "credit_formatted": "£55.5",
  "credit": 55.5,
  "referral_code": "johnd1234b",
  "phones": [
    {
      "id": 1,
      "value": "+4423213213",
      "default": true,
      "sort": 100
    }
  ],
  "avatar": {
    "token": "euaoisd1273892173dsahjd",
    "url": "https://server.com/image.jpg"
  },
  "addresses": [
    {
      "id": 1,
      "address1": "24_red_lion_street",
      "address2": "_brooklands",
      "postcode": "_s_w11",
      "city": "_london",
      "country": "United Kingdom",
      "default": true,
      "sort": 100
    }
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
```


User contains client details

`"path": "user"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`first_name`<br>*editable* | *string* | Client first name
`last_name`<br>*editable* | *string* | Client first name
`email` | *string* | Client email
`social_login_provider` | *integer* | Social provider client used to register:<br/>*<b>1</b> - Facebook*
`type` | *integer* | *<b>1</b> - Anonymous*<br>*<b>2</b> - Generic (register form)*<br>*<b>3</b> - Social (Facebook)*
`social_id` | *string* | Social identifier used on registration (e.g. @joe for Twitter or 23253414234 for Facebook)
`last_profile` | *string* | Last profile the client used with our system
`created_at` | *integer* | Client regisgration UTC timestamp.
`membership` | *object<[membership](#membership)>* | Current purchased membership
`credit_formatted` | *string* | Client credit amount formatted in the region currency
`credit` | *double* | Client credit amount in the region
`referral_code` | *string* | Referral code to send to other clients
`phones` | *array* | Client phones
`phones.id` | *integer* | Unique identifier of the phone
`phones.value` | *string* | Phone number
`phones.default` | *boolean* | Client preference for default contact phone
`phones.sort` | *integer* | Order in list
`avatar` | *object* | Client avatar image
`avatar.token` | *string* | Token for image file on file server
`avatar.url` | *string* | URL address of image file
`addresses` | *array* | Client addresses
`addresses.id` | *integer* | Unique identifier of the address
`addresses.address1` | *string* | Street name and number
`addresses.address2` | *string* | Flat, House number etc.
`addresses.postcode` | *string* | Post code of the address
`addresses.city` | *string* | City of the address
`addresses.country` | *string* | Country of the address
`addresses.default` | *boolean* | Client preference for default address
`addresses.sort` | *integer* | Order in list
`paymethods` | *array<[paymethod](#paymethods)>* | Client payment methods
`user_applications` | *array<[user_application](#user-applications)>* | Platforms the client used the system on
`bookings` | *array<[booking](#bookings)>* | Client bookings




## Paymethods


```shell
curl\
 -X GET\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
 -H "Authorization: {{AUTHORIZATION_TOKEN}}"\
"https://{{BASE_URL}}/v2/client/paymethods"
```

> The above request success response is:

```json
{
  "id": 1,
  "brand": "visa",
  "description": "Business card",
  "last4": "3344",
  "expiration_month": "2",
  "expiration_year": "2016",
  "type": "Stripe",
  "payment_provider_id": 3,
  "data": {
    "token": "231231jsklfhaksj231§2"
  },
  "sort": 100
}
```


Paymethods for a client

`"path": "paymethods"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
`brand` | *string* | Brand for the paymethod (e.g. VISA, MasterCard etc.)
`description` | *string* | User description for the paymethod
`last4` | *string* | Last 4 digits of a credit card
`expiration_month` | *string* | Expriation month of credit card
`expiration_year` | *string* | Expriation year of credit card
`type` | *string* | Type of paymethod. Check [payment_method](#payment-methods).`type`.
`payment_provider_id` | *integer* | Type of payment provider. Check [payment_method](#payment-methods).`payment_provider_id`.
`data` | *object* | Data of payment provider. Check [payment_method](#payment-methods).`data`.
`sort` | *integer* | Order in list



## Purchase membership


```shell
curl\
 -X POST\
 -H "Content-Type: application/json"\
 -H "X-Application: {{APPLICATION_TOKEN}}"\
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
      "do_not_track_geofence": false
    },
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
      "service_names": [
        "Gardening"
      ],
      "app_time_utc_raw": 1504620000,
      "flexible_from_utc_raw": null,
      "flexible_to_utc_raw": null,
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
          "title": "Key:",
          "value": "Yes"
        },
        {
          "title": "Alarm:",
          "value": "2351"
        }
      ],
      "service_details": [
        {
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
      "can_message_client": true,
      "can_call_client": true,
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
      "client_name": "Leigh Turner",
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
`app_time_utc_raw` | *integer* | Appointment time for the job in UTC timestamp
`flexible_from_utc_raw` | *integer* | Start of timeframe to execute the job in UTC timestamp
`flexible_to_utc_raw` | *integer* | End of timeframe to execute the job in UTC timestamp
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
`permissions` | *array* | List of permissions of unit
`permissions.can_message_client` | *boolean* | Can unit send SMS messages to clients
`permissions.can_call_client` | *boolean* | Can unit call clients
`permissions.cannot_decline_jobs` | *boolean* | Can unit decline jobs
`permissions.can_take_ondemand_jobs` | *boolean* | Can unit receive jobs on-demand via notifications that require response
`permissions.has_to_send_summary_on_checkout` | *boolean* | Should unit sent summary on checkout
`permissions.do_not_track_location` | *boolean* | Stops unit from sending updates for current location
`permissions.do_not_track_geofence` | *boolean* | Stops unit from sending updates for entering and leaving areas around bookings
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
`from_date` | *integer* | *one month ago* | UTC time stamp to filter results from a date
`to_date` | *integer* | *now* | UTC time stamp to filter results to a date


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
  "application": 1
}
```

Details for the environment on which the user uses the application.

`"path": "user_applications"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`id` | *integer* | Unique identifier
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
`browser` | *stringinteger* | Browser used to access the application
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
`status` | *integer* | *<b>1000</b> - Sent*<br>*<b>2000</b> - Delivered*<br>*<b>3000</b> - Seen*
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
`payload.popup.cta_button.target.screen_id` | *integer* | 
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

Parameter | Type | Description
-------- | ----- | -------
`created_at_gt`<br>*optional, default <b>0</b>* | *integer* | Filters response with created_at greater than the passed
`action`<br>*optional* | *integer* | Filters response with action equal to the passed

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

## Exceptions

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
      "latitude": 21.197216,
      "longitude": 21.621094,
      "event_time": 1496922768
    }
  ]
}
```

Locations tracked over time for the unit.

`"path": "tracked_locations"`

### Response parameters

Parameter | Type | Description
-------- | ----- | -------
`latitude` | *double* | Latitude tracked
`longitude` | *double* | Longitude tracked
`event_time` | *integer* | Timestamp when the event occurred and was saved (may be sent later)

This endpoint returns:

* [Common errors](#common-errors)
* [Tracked locations errors](#tracked-locations-errors)
