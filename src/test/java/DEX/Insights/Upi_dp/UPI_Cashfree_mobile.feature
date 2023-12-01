Feature: Cashfree Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: AML Data partner Sanction Scanner automation via DPI dex call
    * def dexUrl = requestUrl + '/api/exchange/01HDZYDN1PRT2Q3RXM4RSSD3AQ'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
   {
    "eventType": "ACCOUNT_CREATION",
    "cleansingFlag": true,
	"phoneDefaultCountryCode": "IN",
    "phoneNumber": "918437483220",
    "email": "njrane29@gmail.com",
    "upiApplicationName": "ALL",
    "packages": [
        "UPI_ADVANCED"
    ]
}
    """
    And request requestPayload
    When method POST
    Then status 200
    * def dpResponse = response
    * print dpResponse
    * match dpResponse.status == 200
    * match dpResponse.source == "partner"
    * match dpResponse.response.status == "SUCCESS"
    * print 'Cashfree Mobile dp response--->',dpResponse.response

