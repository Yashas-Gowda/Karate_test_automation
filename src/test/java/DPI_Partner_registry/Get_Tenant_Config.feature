Feature: GET TENANT CUSTOM CONFIG

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario: FILTER_PARTNER_CURL automation
    * def AUrl = 'https://release.monnai.com/api/registry/tenants/tenant_01HD0VFTJRE5C4VWB6CPWMPGWF'
    Given url AUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * print 'Filter response---->',response



