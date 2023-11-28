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

  Scenario:GET ALl FEATURES of the tenants
    * def umUrl = requestUrl + '/api/tenants/features'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def all_features = response
    * print 'features of tenant--->',all_features
    * def all_features_list = get $[*].id
    * print all_features_list

  Scenario:GET FEATURES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/tenant_01GKKZ8HMH2FQHBHE08YHMHJKZ/features'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def features = response
    * print 'features of tenant--->',features
    * def features_list = get $[*].id
    * print features_list
#        get $.data.upi.advanced.accounts[*].upiId


  Scenario:PUT FEATURES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/tenant_01GKKZ8HMH2FQHBHE08YHMHJKZ/features'
    Given url umUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
"""
  {
  "featureIds":[
  "feature_01GKKS7GTG3PD0DJ49VT1DWAWP",
  "feature_01GKKS7GTG4PJ7QF7M34YW0WN2",
  "feature_01GKKS7GTGESNH9FM8T3N4N1A6",
  "feature_01GKKS7GTGFBXBDK8PTNJB43QA",
  "feature_01GKKS7GTGK7V4QC3QTCMSV58R",
  "feature_01GKKS7GTGP3J7BFEK278TFEB8",
  "feature_01GKKS7GTGR7WTXZXXPGREHY92",
  "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
  "feature_01GKKS7GTGXXMFEAHSP6XSMH52",
  "feature_01GTKJXHFB0BFGN01X70HTCHYV"
  ]
  }
"""
    And request requestPayload
    When method PUT
    Then status 200
    * def dpResponse = response
    * print dpResponse



















































