Feature: Testing of DPI  - BLACKLIST_DETAILS scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

    @smokeTest
  Scenario Outline: Validate DPI BLACKLIST_DETAILS positive scenario with single valid input where isBlacklisted is No<Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/BLACKLIST_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    And match $.x.data.blacklist == '#notnull'
    And match $.data.blacklist.details.isBlacklisted == '#present'
    Then match $ contains payload.response

    Examples:
      | Scenario                                                              | statusCode |
      | BLACKLIST_DETAILS_Positive_1_valid_input_phonenumber_isBlacklisted_NO | 200        |
#      | BLACKLIST_DETAILS_Positive_1_valid_input_phonenumber_isBlacklisted_YES                | 200        |
#      | BLACKLIST_DETAILS_Positive_1_valid_input_phonenumber_isBlacklisted_NEEDS_VERIFICATION | 200        |
#      | BLACKLIST_DETAILS_Positive_1_valid_input_phonenumber_null | 200        |

  Scenario Outline: Validate DPI BLACKLIST_DETAILS Negative scenario where input is not an Indonesian number <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/BLACKLIST_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * match $.errors[0] == '#notnull'
    * match $.errors[0].package == "BLACKLIST_DETAILS"
    * match $.errors[0].message == "Service unavailable for country India"
    * match $.errors[0].code == "SERVICE_UNAVAILABLE_FOR_COUNTRY"
    Then match $ contains payload.response

    Examples:
      | Scenario                                                                                    | statusCode |
      | BLACKLIST_DETAILS_Negative_input_phonenumber_not_Indonesian_SERVICE_UNAVAILABLE_FOR_COUNTRY | 501        |
