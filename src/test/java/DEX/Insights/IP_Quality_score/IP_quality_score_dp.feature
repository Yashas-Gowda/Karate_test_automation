Feature: IP_BASIC IP QUALITY SCORE Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario:IP_BASIC IP QUALITY SCORE Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01GVK6XKKRVW8NG75ME0RB6AWF'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
  {
  "eventType": "ACCOUNT_CREATION",
  "cleansingFlag": true,
  "packages": [
    "IP_BASIC"
  ],
  "ipAddress": "2001:db8:3333:4444:CCCC:DDDD:EEEE:FFFF"
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


