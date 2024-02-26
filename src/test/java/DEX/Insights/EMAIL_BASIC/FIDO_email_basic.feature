Feature: EMAIL_BASIC FIDO_email_basic Data Partner automation via DPI DEX call
  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario:EMAIL_BASIC FIDO_email_basic Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01H785HGK5PSKMST8QZSEDCAQY'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
{
  "eventType": "ACCOUNT_CREATION",
  "cleansingFlag": true,
  "packages": [
    "EMAIL_BASIC"
  ],
  "email": "yashasgowda2510@gmail.com"
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
