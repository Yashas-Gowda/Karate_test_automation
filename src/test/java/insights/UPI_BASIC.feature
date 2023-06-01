Feature: Testing of DPI  - UPI_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  Scenario Outline:  UPI BASIC POSITIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    When method POST
    Then status <statusCode>
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
    When method POST
    Then status <statusCode>
    Then match $ contains payload.response
    Examples:
      | Scenario                 | statusCode |
      | UPI_BASIC_sc_Ne_nohandle | 400        |
      | UPI_BASIC_sc_Ne_noUpi    | 400        |

