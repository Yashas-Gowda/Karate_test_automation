Feature: PHONE_BASIC PHONE_STATUS SUBPACKAGE indosat_active_phoneBasic Data Partner automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario:PHONE_BASIC PHONE_STATUS SUBPACKAGE indosat_active_phoneBasic Data Partner automation via DPI monnai.DEX call
    * def dexUrl = requestUrl + '/api/exchange/01H72XCMJ3A08W8MREYD8T1EBS'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "eventType": "ACCOUNT_CREATION",
        "cleansingFlag": true,
        "packages": [
          "PHONE_SOCIAL"
        ],
        "phoneNumber": "554730385113",
        "phoneDefaultCountryCode": "BR"
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


