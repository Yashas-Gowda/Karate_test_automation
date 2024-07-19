Feature: KYC_GSTIN Cash free Data Partner automation via DPI monnai.DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario:KYC_GSTIN Cash free Data Partner automation via DPI monnai.DEX call
    * def dexUrl = requestUrl + '/api/exchange/01HESWMZ6Y39MFBZ60QVMMDYJH'
    Given url dexUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "eventType": "ACCOUNT_CREATION",
        "phoneDefaultCountryCode": "IN",
        "gstin": "24AAPCM2882E1ZB",
        "packages": [
          "KYC_GSTIN"
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


