Feature: PHONE_BASIC TOP_UP_HISTORY SUBPACKAGE izidata_phone_topUpBehavior Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: PHONE_BASIC TOP_UP_HISTORY SUBPACKAGE izidata_phone_topUpBehavior Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01H3VRG72GYJQNBP8KT6A31J9Z'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
  {
    "phoneNumber": "622129000000",
    "phoneDefaultCountryCode": "ID",
    "eventType": "ACCOUNT_CREATION",
    "cleansingFlag": true,
    "packages": [
      "PHONE_BASIC"
    ]
  }
    """
    And request requestPayload
    When method POST
    Then status 200
    * def dpResponse = response
    * print dpResponse
    * match dpResponse.source == "partner"
    * match dpResponse.status == 200
    * print 'status-->', dpResponse.response.status


