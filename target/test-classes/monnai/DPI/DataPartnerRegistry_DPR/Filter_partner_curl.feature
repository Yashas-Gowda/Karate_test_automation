@Filter_Partner_dpr
Feature: FILTER_PARTNER_CURL

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario: FILTER_PARTNER_CURL automation
    * def Url = requestUrl + '/api/registry/partners/searches'
    Given url Url
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "region": "",
        "tenant": "tenant_01GKKZ8HMH2FQHBHE08YHMHJKZ",
        "product": "INSIGHTS",
        "packages": ["UPI_BASIC"]
      }
      """
    And request requestPayload
    When method POST
    Then status 200
    * print 'Filter response---->',response






