Feature: EMPLOYMENT_BASIC - IDENTITY_ENRICHMENT_CLEAR TAX  Data Partner for INDONESIA region automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: INCOME_ESTIMATION MOBILE WALLA Data Partner automation via DPI monnai.DEX call
    * def dexUrl = requestUrl + '/api/exchange/01HJT39AEFV3BS9F3769861A1B'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "phoneDefaultCountryCode": "IN",
        "eventType": "ACCOUNT_LOGIN",
        "cleansingFlag": true,
        "phoneNumber": "9967950078",
        "fullName": "Amit Gaurollu",
        "packages": [
          "IDENTITY_ENRICHMENT"
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
    * print dpResponse.response.device_list

