Feature: Testing of DPI  - UPI_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  Scenario Outline:  UPI BASIC POSITIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then match $ contains payload.response
    Examples:
      | Scenario                 | statusCode |
      | UPI_BASIC_sc_@ybl        | 200        |
      | UPI_BASIC_sc_@ibl        | 200        |
      | UPI_BASIC_sc_@axl        | 200        |
      | UPI_BASIC_sc_@paytm      | 200        |
      | UPI_BASIC_sc_@oksbi      | 200        |
      | UPI_BASIC_sc_@okaxis     | 200        |
      | UPI_BASIC_sc_@okicici    | 200        |
      | UPI_BASIC_sc_@okhdfcbank | 200        |

  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    * match $.errors[*].message contains any "Missing UPI address"
    * match $.errors[*].message contains any "Invalid UPI address"

    * match $.errors[*].code contains any "MISSING_UPI"
    * match $.errors[*].code contains any "INVALID_UPI"
    Then match $ contains any payload.response

    Examples:
      | Scenario                 | statusCode |
      | UPI_BASIC_sc_Ne_noUpi    | 400        |

  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * match $.errors[0].message contains any "Invalid UPI address"
    * match $.errors[0].code contains any "INVALID_UPI"
    Then match $ contains  payload.response

    Examples:
      | Scenario                 | statusCode |
      | UPI_BASIC_sc_Ne_nohandle | 400        |

