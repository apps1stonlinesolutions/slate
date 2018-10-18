
# Introduction

Details on rules for extending API

# Attributes names

## {{resource name}} or {{resource name}}_id

If we don't have expanded version of the object we use only `object_id`

Example:

`job.payment_method` - object is expanded and we use the name of the object

`task.type_id` - type is never expanded so we use name of the object with `_id` suffix

# params

## Gropuing in query

Any endpoint specific parameters are in `query` object.

# id

It can be interger or string. If it is integer it is with prefix `id:` in path (e.g. ...`v2/client/register_token_infos/id:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"`)

# Resource names

If it's in singular form (e.g. `profile`) it returns one object `data: { }`. If it is in plural form (e.g. `categories`) it will return an array `data: [{ }, { }]`

# Setting child objects

When setting a child object (e.g. `job.payment_method`) pass only the `id` (e.g. `{ payment_metohd: 1}`). Don't write objects with expanded attributes.

# Updating a booking form

Only changes are passed. Radio button changes should pass the selected value + the previously selected with value:0.

Examples booking transaction:

```json
{
  "id" : "laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas",
  "service" : {
    "choices" : [
      {
        "id" : 338,
        "title" : "Do you want to add materials?",
        "type" : "default",
        "choice_items" : [
          {
            "id" : 1110,
            "value" : 1,
            "title" : "Materials",
            "type" : "checkbox"
          }
        ]
      },
      {
        "id" : 339,
        "title" : "Is this a house?",
        "type" : "default",
        "choice_items" : [
          {
            "id" : 1111,
            "value" : 1,
            "title" : "Yes",
            "type" : "radio"
          },
          {
            "id" : 1112,
            "value" : 0,
            "title" : "No",
            "type" : "radio"
          }
        ]
      },
      {
        "id" : 330,
        "title" : "Do you want us to clean carpeted furniture?",
        "type" : "multiselect",
        "choice_items" : [
          {
            "id" : 1111,
            "value" : 5,
            "title" : "Chairs",
            "type" : "stepper"
          },
          {
            "id" : 1112,
            "value" : 0,
            "title" : "Sofas",
            "type" : "stepper"
          }
        ]
      }
    ]
  }
}
```

To change only "Is this a house?" to "No" and leave other questions answers as they are send the following data:

```json
{
  "id": "laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas",
  "service": {
    "choices": [
      {
        "id": 339,
        "type": "default",
        "title": "Is this a house?",
        "choice_items": [
          {
            "id": 1112,
            "type": "radio",
            "value": 0,
            "title": "Yes"
          },
          {
            "id": 1112,
            "type": "radio",
            "value": 1,
            "title": "No"
          }
        ]
      }
    ]
  }
}
```

To change only "Do you want us to clean carpeted furniture?" to have nothing selected and leave other questions answers as they are send the following data:

```json
{
  "id": "laghfljasdhgfkjgKJHGJKHGKJHGjkgkjhdas",
  "service": {
    "choices": [
      {
        "id": 330,
        "type": "multiselect",
        "title": "Do you want us to clean carpeted furniture?",
        "choice_items": [
          {
            "id": 1111,
            "type": "stepper",
            "value": 0,
            "title": "Chairs"
          }
        ]
      }
    ]
  }
}
```

Example price modifiers:

```json
[
    {
        "id": 41,
        "name": "Parking",
        "type_options": {
            "step": 0.5,
            "value": 10
        }
    },
    {
        "id": 42,
        "name": "Furniture to clean?",
        "type_options": {
            "value": 6000,
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
```

To change only "Parking" to 15 and leave "Furniture to clean?" as it is send the following data:

```json
[
  {
    "id": 41,
    "name": "Parking",
    "type_options": {
      "value": 15
    }
  }
]
```

To change only "Furniture to clean?" to "Sofa" and leave "Parking" as it is send the following data:

```json
[
  {
    "id": 42,
    "name": "Do you want materials?",
    "type_options": {
      "value": 6001
    }
  }
]
```

To change both send the following data:

```json
[
  {
    "id": 41,
    "name": "Parking",
    "type_options": {
      "value": 15
    }
  },
  {
    "id": 42,
    "name": "Do you want materials?",
    "type_options": {
      "value": 6001
    }
  }
]
```