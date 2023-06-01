@debug
Feature: Testing of DPI  - EMPLOYMENT_DETAILS feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response
    Then match $ contains payload.response

    Examples:
      | Scenario                               | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input | 200        |