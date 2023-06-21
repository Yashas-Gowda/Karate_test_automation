Feature: Testing of DPI  - EMAIL_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @second
  Scenario Outline:  DPI EMAIL_BASIC positive scenario - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    When method POST
    Then print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    Examples:
      | Scenario                                                       | statusCode |
      | Email_Basic_Possitive_withTLDGmail(abc@gmail.com)              | 200        |
      | Email_Basic_Possitive_withDomainNet(abc@you.me.net)            | 200        |
      | Email_Basic_Possitive_withTLD&DomainOurearch(abc@ourearth.com) | 200        |
      | Email_Basic_EmailDeliverable_False                             | 200        |
      | Email_Basic_EmailTenureIs_NULL                                 | 200        |
      | Email_Basic_Positive_0_BreachData                              | 200        |
      | Email_Basic_Positive_CustomDomain_True                         | 200        |
      | Email_Basic_Positive_EmailTenure_Present                       | 200        |
      | Email_Basic_Positive_With_BreachData                           | 200        |

  Scenario Outline:  DPI EMAIL_BASIC Negitive senario with invalid input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    When method POST
    Then print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
#    And match $.errors[1].message == "Invalid email address"
#    And match $.response.errors[1].message == "Invalid email address"

    Examples:
      | Scenario                                                       | statusCode |
      | Email_Basic_Negitive_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
      | Email_Basic_Negitive_withPrefix_with@_NoDomainName(abc@)       | 400        |
      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     | 400        |

  Scenario Outline: DPI EMAIL_BASIC Negitive scenario with null/empty input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    When method POST
    Then print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then print payload.response
    * print karate.pretty(response)
#    Then match $ contains payload.response
    And match $.errors[*].message contains any ["Email cannot be empty/null"]
    And match $.errors[*].code contains any ["MISSING_EMAIL_ADDRESS"]
    And match $.errors[*].package contains any ["EMAIL_BASIC"]
    Examples:
      | Scenario                            | statusCode |
      | Email_Basic_Negitive_Emptyinput('') | 400        |
      | Email_Basic_Negitive_Nullinput(' ') | 400        |


