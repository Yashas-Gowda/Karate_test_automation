@auth_Token_monnai
Feature: Generating auth token

  Background:
    * configure charset = null
    * path '/oauth2/token'
    * configure headers = { Content-Type: 'application/x-www-form-urlencoded' }


  Scenario: generating auth token for env specific
    Given url authUrl
    * def authLoad = read("classpath:monnai/data/authInfo/" + env+ "-auth.json");
    And form field client_id = authLoad.client_id
    And form field client_secret = authLoad.client_secret
    And form field grant_type = 'client_credentials'
    And form field scope = authLoad.scope
    When method POST
    Then status 200
    * print karate.pretty(response)
    And def accessToken = $.access_token
    * print accessToken
    * def Token =
      """
        function() {
          return   'Bearer '+accessToken
        }
      """
    * print authLoad
    * print 'Environment AuthGen--->',env
    * def authToken = Token()
    * print 'Bearer Token --->',authToken
