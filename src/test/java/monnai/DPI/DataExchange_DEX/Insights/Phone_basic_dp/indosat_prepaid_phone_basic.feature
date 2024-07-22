Feature: PHONE_BASIC SIMTYPE SUBPACKAGE indosat_prepaid Data Partner automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario:PHONE_BASIC SIMTYPE SUBPACKAGE indosat_prepaid Data Partner automation via DPI monnai.DEX call
    * def dexUrl = requestUrl + '/api/exchange/01H5Q0GFVRJJHZS0STT5DDG0K2'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "phoneNumber":"6289676719319",
        "phoneDefaultCountryCode": "ID",
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



