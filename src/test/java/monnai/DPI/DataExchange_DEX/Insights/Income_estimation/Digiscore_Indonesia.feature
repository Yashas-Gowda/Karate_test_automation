Feature: INCOME_ESTIMATION - Digiscore - Salary Handle Data Partner for INDONESIA region automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: INCOME_ESTIMATION MOBILE WALLA Data Partner automation via DPI monnai.DEX call
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
        "id": "1401011402730001",
        "idType":"NIK",
        "phoneNumber": "6281277803808",
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

