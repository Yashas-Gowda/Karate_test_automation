Feature: PHONE_BASIC TMT_phoneBasic Data Partner automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario:PHONE_BASIC PHONE_STATUS SUBPACKAGE TMT_phoneBasic Data Partner automation via DPI monnai.DEX call
    * def dexUrl = requestUrl + '/api/exchange/01GS9YJ1NVPC3K2KVQYW3EEEKG'
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
        "phoneNumber": "8005831167",
        "phoneDefaultCountryCode": "IN"
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


