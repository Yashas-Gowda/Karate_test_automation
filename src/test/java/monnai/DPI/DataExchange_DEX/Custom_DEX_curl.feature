@custom_dex_call
Feature: CUSTOM DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: CUSTOM DPI monnai.DEX call
    * def dexUrl = requestUrl + '/api/exchange/01H785HGK5PSKMST8QZSEDCAQY'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    #  meenalokesh10109@gmail.com
    And def requestPayload =
      """
      {
        "eventType": "ACCOUNT_CREATION",
        "packages": [
          "EMAIL_SOCIAL"
        ],
        "email": "meenalokesh10109@gmail.com"
      }
      """
    And request requestPayload
    When method POST
    Then status 200
    * def dpResponse = response
    * print dpResponse
    * match dpResponse.source == "partner"
    * match dpResponse.status == 200
    * print 'monnai.DEX Data partner response',dpResponse.response


  #  meenalokesh10109@gmail.com
