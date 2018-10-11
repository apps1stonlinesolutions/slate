
# Introduction

Details on rules for extending API

## Attributes names

### {{resource name}} or {{resource name}}_id

If we don't have expanded version of the object we use only `object_id`

Example:

`job.payment_method` - object is expanded and we use the name of the object

`task.type_id` - type is never expanded so we use name of the object with `_id` suffix

## params

### Gropuing in query

Any endpoint specific parameters are in `query` object.

## id

It can be interger or string. If it is integer it is with prefix `id:` in path (e.g. ...`v2/client/register_token_infos/id:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"`)

## Resource names

If it's in singular form (e.g. `profile`) it returns one object `data: { }`. If it is in plural form (e.g. `categories`) it will return an array `data: [{ }, { }]`