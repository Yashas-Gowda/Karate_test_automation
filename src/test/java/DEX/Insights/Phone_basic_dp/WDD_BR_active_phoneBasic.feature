Feature: PHONE_BASIC PHONE_STATUS SUBPACKAGE IPQS_MX_active_phoneBasic Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario:PHONE_BASIC PHONE_STATUS SUBPACKAGE IPQS_MX_active_phoneBasic Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01GS9XSGZ2PAY5JE834NKVC65K'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
   {
    "phoneNumber": "5511910000000",
	"phoneDefaultCountryCode": "BR",
    "originalCountryCode": "",
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


