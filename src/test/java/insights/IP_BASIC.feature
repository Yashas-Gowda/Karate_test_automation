Feature: Testing of DPI  - IP_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  Scenario Outline: Validation of IP_BASIC Negative scenario for error code when an invalid / null / empty IP address in input -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + env + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"

    Examples:
      | Scenario                              | ipAddress | statusCode | errorCode          | errorMessage                 |
      | IP_BASIC_NEGATIVE_empty_or_null_input | ""        | 400        | MISSING_IP_ADDRESS | Missing IPv4 or IPv6 address |
      | IP_BASIC_NEGATIVE_empty_or_null_input | null      | 400        | MISSING_IP_ADDRESS | Missing IPv4 or IPv6 address |
      | IP_BASIC_NEGATIVE_empty_or_null_input | " "       | 400        | MISSING_IP_ADDRESS | Missing IPv4 or IPv6 address |


  Scenario Outline: Validation of IP_BASIC Negative scenario for error code when an invalid IP_address in input -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + env + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"

    Examples:
      | Scenario                        | ipAddress | statusCode | errorCode          | errorMessage       |
      | IP_BASIC_NEGATIVE_invalid_input | "abc"     | 400        | INVALID_IP_ADDRESS | Invalid IP Address |
      | IP_BASIC_NEGATIVE_invalid_input | "123"     | 400        | INVALID_IP_ADDRESS | Invalid IP Address |
      | IP_BASIC_NEGATIVE_invalid_input | "123abc"  | 400        | INVALID_IP_ADDRESS | Invalid IP Address |

  Scenario Outline: Validation of IP_BASIC Positive scenario for Valid IPV4 & IPV6 IP_address in input -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + env + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response

    Examples:
      | Scenario                     | ipAddress                                | statusCode |
      | IP_BASIC_POSITIVE_IPV4_Input | "206.84.238.175"                         | 200        |
      | IP_BASIC_POSITIVE_IPV6_Input | "2001:db8:3333:4444:CCCC:DDDD:EEEE:FFFF" | 200        |

  Scenario Outline: Validation of IP_BASIC Positive scenario for Valid IP_address with "High Abuse velocity","recent abuse", "bot status","VPN" -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + env + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response
    And match $.data.ip.basic.abuseVelocity == "high"
    And match $.data.ip.basic.recentAbuse == true
    And match $.data.ip.basic.botStatus == true
    And match $.data.ip.basic.vpn == true

    Examples:
      | Scenario                       | ipAddress     | statusCode |
      | IP_BASIC_POSITIVE_SpecialCases | "192.168.1.1" | 200        |
