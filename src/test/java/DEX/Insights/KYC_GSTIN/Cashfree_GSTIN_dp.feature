Feature: KYC_PAN Cash free Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario:KYC_PAN Cash free Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01HE4SGQTW8Z7P0S0N88PWZYB2'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
  {
    "eventType": "ACCOUNT_CREATION",
    "phoneDefaultCountryCode": "IN",
    "pan": "AJSPT6609H",
    "packages": [
		"KYC_PAN"
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


