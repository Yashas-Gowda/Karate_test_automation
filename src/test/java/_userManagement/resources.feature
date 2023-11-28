Feature: features API of User Management automation from roles to getting features and getting

  Background:
    * configure charset = null
#    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = "Bearer eyJraWQiOiJRZzhHYTFpM2tYT1ExUGZvZW9PWldcL2F1eFVxa1pIb1wvUG5FbFFhM3JGbjQ9IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfU1A4VzhubnNQIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNXA3dWtuaGdhMGpmb2FoaTk4bDA2aWM4YW0iLCJvcmlnaW5fanRpIjoiNzZiNTcyNTUtN2UxNi00NDI3LThjM2QtZjMzMzRhODcxMmYzIiwiZXZlbnRfaWQiOiI4MzY1ZmM1Zi1iNzhlLTQzZWYtYjkzNi04MmE0NTMxZDEwMmYiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNzAxMDY0NzE2LCJleHAiOjE3MDExNTExMTYsImlhdCI6MTcwMTA2NDcxNywianRpIjoiMzcwZTQ0MzItMTdhNy00Y2M2LTgwNTMtMTE2M2FiMmU3NWY5IiwidXNlcm5hbWUiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUifQ.isQ3ogPsdGk5ho0YWFFn7WlnU-6p7LiU6XTHcH05wL34GbUb687p0yvxf8kTTQcCYjt607jXbHTG5wHL0xfAt_l8n_15BF10ibHqippLVdyLt5BW7rFI6aXiQfub_l4JXkEzczbHQFJPPVjf_uPCQkjjI3nRsohfwWGhwDYNBGzubKk6YL8WMpKhgYs51YuT1e1H9wEoKMeiuy-_4GhNQga0MtIX3JlJ2aQQJsBMM0CJ1vKyOmj9SP-j9-va9EubFctSDu8p_l4AeC7zoT7-XX9nxYzn6T2SKfUhzzwQag8JuL66upjU_mtEk7lANqshuU4TRMMhKbilDNk774cVsw"


  Scenario:GET ROLES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/tenant_01GKKZ8HMH2FQHBHE08YHMHJKZ/roles'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def roles = response
    * print 'Roles--->',roles

  Scenario:GET ALl RESOURCES of the tenants
    * def umUrl = requestUrl + '/api/tenants/resources'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def all_resources = response
    * print 'all_resources of tenant--->',all_resources
    * def all_resources_list = get $[*].id
    * print all_resources_list

  Scenario:GET RESOURCES of the Roles by Role_id
    * def umUrl = requestUrl + '/api/tenants/roles/role_01GKKZNYGC773BCE8JA05AE0CQ/resources'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def resources = response
    * print 'resources of tenant--->',resources
    * def resources_list = get $[*].id
    * print resources_list


  Scenario:PUT RESOURCES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/roles/role_01GKKZNYGC773BCE8JA05AE0CQ/resources'
    Given url umUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
"""
  {
  "resourceIds": [
  "resource_01GKKV6BJX598HQH68HCEH6DFM",
  "resource_01GKKV6BJX67ZX0HT3HYZE1S0Z",
  "resource_01GKKV6BJX69KCR1F4QH5B74WE",
  "resource_01GKKV6BJX8NPA9D172B6XF8BN",
  "resource_01GKKV6BJX98X9JRC5P41WAK4T",
  "resource_01GKKV6BJXA14CCT6PSXZJ0KN1",
  "resource_01GKKV6BJXAS8XKBVGBD1J8Y8F",
  "resource_01GKKV6BJXFKMTW3N9Z5ZB2EB8",
  "resource_01GKKV6BJXGYCT35FBM5Z2YYE5",
  "resource_01GKKV6BJXJP5ZGE68TZNWE8ZN",
  "resource_01GKKV6BJXK19Z2M22TXVEWEAG",
  "resource_01GKKV6BJXKVC3APKSVNJKYSVV",
  "resource_01GKKV6BJXKZ45AMW5356FPJAZ",
  "resource_01GKKV6BJXPSWTGY64NZYB9GCF",
  "resource_01GKKV6BJXQPP3YWJQJSQFD3WC",
  "resource_01GKKV6BJXRFPBX8QX9ARBSG2J",
  "resource_01GKKV6BJXXJWKN1A6P5YQRE6Z",
  "resource_01GKKV6BJXYCT6WGKC4KMBE8M9",
  "resource_01GKKV6BJXYZ7TTNQ6DG55CDAA",
  "resource_01GKKV6BJY1AVZ3RPJ7N1Z3K54",
  "resource_01GKKV6BJY1G836WXM1B3J5VM0",
  "resource_01GKKV6BJY1X0MPB6PJFQZ05CW",
  "resource_01GKKV6BJY354B8BZR7X1YZJM1",
  "resource_01GKKV6BJY3JNPKRFFXBJMKSMA",
  "resource_01GKKV6BJY5K3GZ32NVPS67T7D",
  "resource_01GKKV6BJY7MYGF00H6PRJ2C73",
  "resource_01GKKV6BJYATQSHEJ55N4NGW5H",
  "resource_01GKKV6BJYB2Q0W0936QVEM3WT",
  "resource_01GKKV6BJYGEW9NNBB3FV01S1R",
  "resource_01GKKV6BJYHJH48NT8TWVM3SXQ",
  "resource_01GKKV6BJYJERXJQBN61ZEQ1NT",
  "resource_01GKKV6BJYJKDFZP8GD5E1VECC",
  "resource_01GKKV6BJYMWBCWXV8FRXP8T5F",
  "resource_01GKKV6BJYNK6R6X4AAFVD7GS2",
  "resource_01GKKV6BJYR9TGHP9J25S34MRD",
  "resource_01GKKV6BJYS772GPRV5E7Q1059",
  "resource_01GKKV6BJYVB9QN8K0YR80GAYY",
  "resource_01GKKV6BJYWBHN7MZTHFWR4Q77",
  "resource_01GKKV6BJYX83JVSABZ62QCQR1",
  "resource_01GKKV6BJYYBKV040XMKYT9R2S",
  "resource_01GTKJY0SW9F2Q4NEZZQRWFAG9"
]
  }
"""
    And request requestPayload
    When method PUT
    Then status 200
    * def resources = response
    * print 'resources of tenant--->',resources
    * def resources_list = get $.resources[*].id
    * print resources_list







