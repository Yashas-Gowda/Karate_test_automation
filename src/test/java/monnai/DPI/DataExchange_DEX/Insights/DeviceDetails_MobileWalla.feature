Feature: DEVICE_DETAILS MOBILE WALLA Data Partner automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: DEVICE_DETAILS MOBILE WALLA Data Partner automation via DPI monnai.DEX call
    * def dexUrl = requestUrl + '/api/exchange/01GVKN54P87M9KX80HF3RVNMF2'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "eventType": "ACCOUNT_CREATION",
        "cleansingFlag": true,
        "packages": [
          "DEVICE_DETAILS"
        ],
        "countryCode": "IN",
        "deviceIds": ["5c185ecc-8c24-4803-a60c-a26f52908d28"]
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

