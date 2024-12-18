Feature: Cashfree Data Partner automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: AML Data partner Sanction Scanner automation via DPI dex call
    * def dexUrl = requestUrl + '/api/exchange/01HD193DX66PPK1CQRYEMKDS9S'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "eventType": "ACCOUNT_CREATION",
        "cleansingFlag": true,
        "packages": [
          "UPI_BASIC"
        ],
        "upiId": "anand8910be@okaxis",
        "countryCode": "IN"
      }
      """
    And request requestPayload
    When method POST
    Then status 200
    * def dpResponse = response
    * print dpResponse
    * match dpResponse.response.subCode == '200'
    * match dpResponse.status == 200
    * match dpResponse.response.status == "SUCCESS"
    * print dpResponse.response.data

