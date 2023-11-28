Feature: EMAIL_BASIC FIDO Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: DEVICE_DETAILS MOBILE WALLA Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01H785HGK5PSKMST8QZSEDCAQY'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
#  meenalokesh10109@gmail.com
    And def requestPayload =
    """
    {
  "eventType": "ACCOUNT_CREATION",
  "packages": [
    "EMAIL_SOCIAL"
  ],
  "email": "meenalokesh10109@gmail.com"
}
    """
    And request requestPayload
    When method POST
    Then status 200
    * def dpResponse = response
    * print dpResponse
    * match dpResponse.source == "partner"
    * match dpResponse.status == 200
    * print 'FIDO DP response',dpResponse.response.email

