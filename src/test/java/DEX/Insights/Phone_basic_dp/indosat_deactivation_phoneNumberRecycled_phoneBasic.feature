Feature: PHONE_BASIC PHONE_STATUS SUBPACKAGE indosat_deactivation_phoneNumberRecycled Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario:PHONE_BASIC PHONE_STATUS SUBPACKAGE indosat_deactivation_phoneNumberRecycled Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01HMTGDSMM68TSXE0EVCYSJ8W3'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
  {
	"eventType": "ACCOUNT_CREATION",
	"packages": [
		"PHONE_BASIC"
	],
	"phoneNumber": "6285752731651",
	"referenceDate": "2024-12-31",
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
    * print 'status-->', dpResponse.response.status


