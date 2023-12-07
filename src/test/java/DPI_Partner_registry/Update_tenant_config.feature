Feature: FILTER_PARTNER_CURL

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authTokenFeature:


  Scenario: FILTER_PARTNER_CURL automation
    * def Url = requestUrl + '/api/registry/tenants'
    Given url Url
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
    {
  "region": "",
  "tenant": "tenant_01HD0VFTJRE5C4VWB6CPWMPGWF",
  "product": "INSIGHTS",
  "packages": ["PHONE_BASIC"]
  }
    """
    And request requestPayload
    When method POST
    Then status 200
    * print 'Filter response---->',response



#  curl --request POST \
#  --url https://release.monnai.com/api/registry/tenants \
#  --header 'Authorization: Bearer eyJraWQiOiJUeHZBRldSUTJ4QVJjSGlVeVRtQisyV3BKa3VLaTZ3aDZKbkNaXC9nNkJBYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfdFhFUlFkZTdGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiMmhscDRndTRlYTRrMG9qczhoaHFxc28xZmQiLCJvcmlnaW5fanRpIjoiYWZkMDAwNzEtNGE5Zi00YjU1LWI5YmEtMjUxN2UzYjEzNWY5IiwiZXZlbnRfaWQiOiIxODYxN2YwMi1mMmU1LTQ5OTYtYmExYS1mMDU3ZjVhYmI1YzciLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNzAxODQ0OTc4LCJleHAiOjE3MDE5MzEzNzgsImlhdCI6MTcwMTg0NDk3OSwianRpIjoiM2ZkOTNkNjYtNjE0Ny00ZjJlLTg5MjMtNGQyZTg1ZTkxMjYxIiwidXNlcm5hbWUiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIifQ.gxuS83-jRCCMdXjYLBHN3eB7qXBL90z6y2B3VkdaInzOGkjxjOl5tBuFlUJodPpfdPdkLK-2TlytBKgqq0LVo1N-QXf9dqZEpVWAQ5gsbm3lwAUqK37tMWmsUH9jbXlcrIvuPqNA1WVQ6A3L7csHT4SYJ5m4waEyOe3EgBy0dRFPRbK7wXRZ3xGaFg7-mTa2dHb4qiZg-NwmsptNL4Nfegv-dL5R3USBYyy2miSzSMRsIS-VD8MjJzxZvmIEOF4fRXcHLFCq7QNnhCa4T6vO2ETji56LOovwOfuriRs_oJK-Wq2n7bD5lPxYtiaGnphXfA3PlxRTcNnUwmM_vCKo-g' \
#  --header 'Content-Type: application/json' \
#  --data '{
#  "tenant": "01GFJCPPHBAWE6SBY28VGJV84Y",
#  "exclude": {
#  "PHONE_SOCIAL": {
#  "01H6BBPQ3TVTVSTDH4TKRX3VGY": {
#  "name": "FIDO Phone",
#  "order": 0
#  }
#  }
#  },
#  "include": {
#  "PHONE_SOCIAL": {
#  "01GVK2BBQCZVCB8A88Q1MW2MTR": {
#  "name": "Seon Phone",
#  "order": 0
#  }
#  }
#  }
#  }'