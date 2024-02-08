Feature: EMPLOYMENT_BASIC - Digitap UAN_BASIC - Data Partner for INDONESIA region automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: INCOME_ESTIMATION MOBILE WALLA Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01HGAVZXCZ1SPXSJAHRGWH6FJR'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
  {
  "email": "sudhir.manke121212@gmail.com",
  "eventType": "ACCOUNT_CREATION",
  "cleansingFlag": false,
  "packages": [
    "EMPLOYMENT_DETAILS"
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
    * print dpResponse.response.device_list

