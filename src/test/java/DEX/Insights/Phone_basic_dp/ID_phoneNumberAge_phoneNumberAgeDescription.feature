Feature: PHONE_BASIC PHONE_TENURE SUBPACKAGE phoneNumberAge_phoneNumberAge Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

#  After discussion with Anjan, we found Asliri is not giving a response due to less credit so we considered Indosat as primary and izidata as secondary data partner
#
#  phoneNumberAge and  phoneNumberAgeDescription ( Product team needs to confirm , do we need to disable Asliri or not )
#
#  cc: @Roopa @Aman Singh

#  Scenario:PHONE_BASIC PHONE_TENURE SUBPACKAGE phoneNumberAge_phoneNumberAge Data Partner- AsliRi
#    * def dexUrl = requestUrl + '/api/exchange/01H59C8RQXXBWKN96B6Q3XEP78'
#    Given url dexUrl
#    And header Content-Typ = 'application/json'
#    And header Authorization = BearerToken
#    And def requestPayload =
#    """
#  {
# "phoneNumber":"6281573008453",
#  "phoneDefaultCountryCode": "ID",
#	"eventType": "ACCOUNT_CREATION",
#	"cleansingFlag": true,
#	"packages": [
#		"PHONE_BASIC"
#	]
#}
#    """
#    And request requestPayload
#    When method POST
#    Then status 200
#    * def dpResponse = response
#    * print dpResponse
#    * match dpResponse.source == "partner"
#    * match dpResponse.status == 200
#    * print 'status-->', dpResponse.response.status


  Scenario:PHONE_BASIC PHONE_TENURE SUBPACKAGE phoneNumberAge_phoneNumberAge Data Partner- Indosat - Tenure
    * def dexUrl = requestUrl + '/api/exchange/01H5SHKJWTEASSH4Z0GQDGX6Y9'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
  {
 "phoneNumber":"6281327434948",
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



  Scenario:PHONE_BASIC PHONE_TENURE SUBPACKAGE phoneNumberAge_phoneNumberAge Data Partner-  izidata - Phone Tenure
    * def dexUrl = requestUrl + '/api/exchange/01H63M3M35NE02S2S0Y4CB7K09'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
  {
	"eventType": "ACCOUNT_CREATION",
	"cleansingFlag": true,
	"packages": [
		"PHONE_BASIC"
	],
	"phoneNumber": "628119102320",
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