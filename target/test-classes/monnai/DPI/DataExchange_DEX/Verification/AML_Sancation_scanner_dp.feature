Feature: AML Data partner Sanction Scanner automation via DPI dex call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: AML Data partner Sanction Scanner automation via DPI dex call
    * def dexUrl = requestUrl + '/api/exchange/01HC9WQKD6R02DMG33EE3QZ6TS'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "eventType": "ACCOUNT_CREATION",
        "entityType": "INDIVIDUAL",
        "userDetails": {
          "fullGivenName": "Joko Widodo"
        },
        "recordLimit": 20,
        "matchThreshold": 80,
        "packages": [
          "KYC_AML"
        ]
      }
      """
    And request requestPayload
    When method POST
    Then status 200
    * def dpResponse = response
    * print response
    * match dpResponse.source == "partner"
    * match dpResponse.response.HttpStatusCode == 200
    * match dpResponse.response.IsSuccess == true
    * print dpResponse.response.Result

