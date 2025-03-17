@emp_advanced_digitap_dex
Feature: EMPLOYMENT_BASIC - Digitap UAN_BASIC - Data Partner for INDONESIA region automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: INCOME_ESTIMATION MOBILE WALLA Data Partner automation via DPI monnai.DEX call
    * def dexUrl = requestUrl + '/api/exchange/01HGADRJ6QTZEZA0H14JKK1SYD'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "eventType": "ACCOUNT_CREATION",
        "cleansingFlag": true,
        "packages": [
          "EMPLOYMENT_ADVANCED"
        ],
        "phoneNumber": "6281518551",
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
    * print dpResponse.response.device_list

