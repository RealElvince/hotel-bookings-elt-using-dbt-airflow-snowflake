SELECT
  id,
  first_name,
  last_name,
  email
FROM {{(ref('customers'))}}
