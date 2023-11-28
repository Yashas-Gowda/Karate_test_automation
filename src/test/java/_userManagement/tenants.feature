Feature: features API of User Management automation from roles to getting features and getting

  Background:
    * configure charset = null
#    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = "Bearer eyJraWQiOiJRZzhHYTFpM2tYT1ExUGZvZW9PWldcL2F1eFVxa1pIb1wvUG5FbFFhM3JGbjQ9IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfU1A4VzhubnNQIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNXA3dWtuaGdhMGpmb2FoaTk4bDA2aWM4YW0iLCJvcmlnaW5fanRpIjoiNzZiNTcyNTUtN2UxNi00NDI3LThjM2QtZjMzMzRhODcxMmYzIiwiZXZlbnRfaWQiOiI4MzY1ZmM1Zi1iNzhlLTQzZWYtYjkzNi04MmE0NTMxZDEwMmYiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNzAxMDY0NzE2LCJleHAiOjE3MDExNTExMTYsImlhdCI6MTcwMTA2NDcxNywianRpIjoiMzcwZTQ0MzItMTdhNy00Y2M2LTgwNTMtMTE2M2FiMmU3NWY5IiwidXNlcm5hbWUiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUifQ.isQ3ogPsdGk5ho0YWFFn7WlnU-6p7LiU6XTHcH05wL34GbUb687p0yvxf8kTTQcCYjt607jXbHTG5wHL0xfAt_l8n_15BF10ibHqippLVdyLt5BW7rFI6aXiQfub_l4JXkEzczbHQFJPPVjf_uPCQkjjI3nRsohfwWGhwDYNBGzubKk6YL8WMpKhgYs51YuT1e1H9wEoKMeiuy-_4GhNQga0MtIX3JlJ2aQQJsBMM0CJ1vKyOmj9SP-j9-va9EubFctSDu8p_l4AeC7zoT7-XX9nxYzn6T2SKfUhzzwQag8JuL66upjU_mtEk7lANqshuU4TRMMhKbilDNk774cVsw"

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
    * def umUrl = requestUrl + '/api/tenants/tenant_01GKKZ8HMH2FQHBHE08YHMHJKZ/subscriptions'
    Given url umUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
"""
  {
    "subscriptions": [
        "PHONE_BASIC",
        "PHONE_SOCIAL",
        "PHONE_IDENTITY",
        "EMAIL_SOCIAL",
        "EMAIL_BASIC",
        "ADDRESS_BASIC",
        "NAME_BASIC",
        "IP_BASIC",
        "UPI_BASIC",
        "IDENTITY_CORRELATION",
        "IDENTITY_ENRICHMENT",
        "IDENTITY_ENRICHMENT_PLUS",
        "DEVICE_DETAILS",
        "KYC_MOBILE",
        "KYC_CONSUMER",
        "KYC_GOVERNMENT",
        "UPI_ADVANCED",
        "BLACKLIST_DETAILS",
        "INCOME_ESTIMATION",
        "EMPLOYMENT_DETAILS",
        "DOMAIN_BREACH",
        "KYC_AML"
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


    