Feature: DEVICE_DETAILS MOBILE WALLA Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: DEVICE_DETAILS MOBILE WALLA Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01GVKN54P87M9KX80HF3RVNMF2'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
    {
    "eventType": "ACCOUNT_CREATION",
    "cleansingFlag": true,
    "packages": [
      "DEVICE_DETAILS"
    ],
    "countryCode": "IN",
    "deviceIds": ["97867bc8-0cdc-4072-86c4-2cc7e9d05616","1db61125-297f-4544-abad-eae8a56ecd90"]
  }
    """
    And request requestPayload
    When method POST
    Then status 200
    * def dpResponse = response
    * print dpResponse
    * match dpResponse.source == "partner"
    * match dpResponse.status == 200
    * print dpResponse.response.device_list
