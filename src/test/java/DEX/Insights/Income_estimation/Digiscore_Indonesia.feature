Feature: INCOME_ESTIMATION - Digiscore - Salary Handle Data Partner for INDONESIA region automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: INCOME_ESTIMATION MOBILE WALLA Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01HEADGYMB7XYDFMWQG9RT2A40'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
    {
	"eventType": "ACCOUNT_CREATION",
	"cleansingFlag": true,
	"packages": [
		"INCOME_ESTIMATION"
	],

	"id": "6281293769290",
	"idType": "NIK",
	"phoneNumber": "+628129376929",
	"phoneDefaultCountryCode": "ID"
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

