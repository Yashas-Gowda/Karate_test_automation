Feature: features API of User Management automation from roles to getting features and getting

  Background:
    * configure charset = null
#    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = "Bearer eyJraWQiOiJRZzhHYTFpM2tYT1ExUGZvZW9PWldcL2F1eFVxa1pIb1wvUG5FbFFhM3JGbjQ9IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfU1A4VzhubnNQIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNXA3dWtuaGdhMGpmb2FoaTk4bDA2aWM4YW0iLCJvcmlnaW5fanRpIjoiMTIxODAzZmQtODQxOC00NmJmLTk4MjYtMDYyZWU4ZjQ4YTczIiwiZXZlbnRfaWQiOiIzZjY5ZDUyYy0zYzdlLTQzMzAtYjFhNi1iOTVkNTY0OWZjZjMiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNzAxMTc2Njg1LCJleHAiOjE3MDEyNjMwODUsImlhdCI6MTcwMTE3NjY4NiwianRpIjoiMTU2NTIyODItYTU4NS00MGQ2LTkwOWMtMWYwOWZkY2E1NWNkIiwidXNlcm5hbWUiOiI1MDgyNDJlNS02YjE2LTRmOTYtYWU0NS01ZTM1NmY4MDI4MWUifQ.In_mx8_h0NB9jybQQaTcbxravdRjWTcqgTIeHTD55ofXFrdmtyFf3gr5CPDW1Q4GELvINIA5wUhXMo-sCS0iJ5dgM100GGRkQ4cp6ZKV9NMSW_uYsfxFXz4htra9ZMmehdnnE5aShFRh46eZJrL700D5CKa2GYiVZU2wOPUr6Q_j46difm9hJnLlj8rxNX40nor7HYZHln6hbkaaF9JzuclTlRHHib3dvGxbTgusSWxFDD_Ia_c3STOu8W04AxOi7FPuwYcbBLxUmn9RwT2wYPNNZb0RBC3sz8B1h6TFSkjHldrijDvfGxg5Alnw_3xo3cXHKp0vEq-FZnF-8q-EDA"

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



















































