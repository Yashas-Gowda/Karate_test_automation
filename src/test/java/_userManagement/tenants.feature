Feature: features API of User Management automation from roles to getting features and getting

  Background:
    * configure charset = null
#    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = "Bearer eyJraWQiOiJRZzhHYTFpM2tYT1ExUGZvZW9PWldcL2F1eFVxa1pIb1wvUG5FbFFhM3JGbjQ9IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfU1A4VzhubnNQIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNXA3dWtuaGdhMGpmb2FoaTk4bDA2aWM4YW0iLCJvcmlnaW5fanRpIjoiYmUwNWJiYjEtYTg1MS00YWRlLWI3YWMtODFkYWUwMDA0ZGRmIiwiZXZlbnRfaWQiOiI4MTMxMzUzOC1lYjhiLTQwOTktOWVmNy0zZDhhZTUzZDY2MTciLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNzA3MzE0MDI5LCJleHAiOjE3MDc0MDA0MjksImlhdCI6MTcwNzMxNDAzMCwianRpIjoiN2YyMTMxYzAtYjFjOC00N2ZlLWE1Y2MtM2UzZThjMzY3NzczIiwidXNlcm5hbWUiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUifQ.QN-5mAftipZ3fOTkpTImcjobU8iHoP-gHutf5EU81O-Va0qdFvIQNE20B5KypX0h1hF_GsX3DX2n0iobzDwzp_aSHtxJ9FZQdPpUhpmPomqYx1dEcr_9HzLoNCk0d4zd3y7xr5MeZFqz0aSh3-BvJ49B81kH_ZMlSQVMEKLg1ZWaRkASI0SxHUDDCHZRkqyiJ8D0-p2I1qz2IVyivMJWmNRVXu7FaHoFtt--CMjnWvJFgMod6mujK45HVVMes-58__6SahXHotu5mBGbld_D7_GWxWTSBCFFa2Shjahbump5h9CmrE6N_d__S2KDf90FiVKimsZV309tis2dQCrJeg"


  Scenario:GET ALL TENANTS of the ENVIRONMENT
    * def umUrl = requestUrl + '/api/tenants/tenant/subscriptions/all'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def tenants = response
    * print 'all tenants--->',tenants

  Scenario:GET Tenant by app_client
    * def umUrl = requestUrl + '/api/tenants/app-clients/65pm4d4lfv7ipimgc98lr0q9ec'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * print 'tenant_info--->',response
    * def tenantId = $.tenantId
    * print 'tenant_id --->',tenantId


  Scenario:GET subscriptions of the TENANTS
    * def umUrl = requestUrl + '/api/tenants/tenant_01GKKZ8HMH2FQHBHE08YHMHJKZ/subscriptions'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def subscriptions = response
    * print ' subscriptions of tenant--->',subscriptions
    * def packages = get $[*].subscription.packageName
    * print 'packages of tenant--->',packages

  Scenario:PUT subscriptions of the TENANTS
    * def umUrl = requestUrl + '/api/tenants/tenant_01HD10QR1XT0HVQ8QPGZ37Z8YS/subscriptions'
    Given url umUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
"""
  {
    "subscriptions":  [
  "EMAIL_SOCIAL",
  "PHONE_IDENTITY",
  "PHONE_BASIC",
  "PHONE_SOCIAL",
  "EMAIL_BASIC",
  "ADDRESS_BASIC",
  "NAME_BASIC",
  "IP_BASIC",
  "IDENTITY_CORRELATION",
  "IDENTITY_ENRICHMENT_PLUS",
  "IDENTITY_ENRICHMENT",
  "BATCH_INSIGHTS",
  "UPI_BASIC",
  "DEVICE_DETAILS",
  "EMPLOYMENT_DETAILS",
  "KYC_GOVERNMENT",
  "KYC_CONSUMER",
  "KYC_MOBILE",
  "INCOME_ESTIMATION",
  "BLACKLIST_DETAILS",
  "UPI_ADVANCED",
  "KYC_AML",
  "EMPLOYMENT_BASIC",
  "EMPLOYMENT_ADVANCED",
  "KYC_PAN",
  "KYC_GSTIN",
  "ADDRESS_VERIFICATION"
]
}
"""
    And request requestPayload
    When method POST
    Then status 201
    * def subscriptions = response
    * print ' subscriptions of tenant--->',subscriptions
    * def packages = get $[*].subscription.packageName
    * print 'packages of tenant--->',packages

  Scenario:GET subtenants of the tenants by tenant_id
    * def umUrl = requestUrl + 'api/tenants/tenant_01GKKZ8HMH2FQHBHE08YHMHJKZ/subtenants'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * print 'subpackages_info of tenant--->',response

