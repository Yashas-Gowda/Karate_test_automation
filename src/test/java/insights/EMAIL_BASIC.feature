Feature: Testing of DPI  - EMAIL_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @second
  Scenario Outline:  DPI EMAIL_BASIC positive scenario - where emailTenure = notnull <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#number"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    Examples:
      | Scenario                                                       | statusCode |
      | Email_Basic_Possitive_withTLDGmail(abc@gmail.com)              | 200        |
      | Email_Basic_Possitive_withDomainNet(abc@you.me.net)            | 200        |
      | Email_Basic_Possitive_withTLD&DomainOurearch(abc@ourearth.com) | 200        |
      | Email_Basic_Positive_With_BreachData                           | 200        |
      | Email_Basic_Positive_EmailTenure_Present_in_doubledigit        | 200        |
      | Email_Basic_emailTenure_in_decimal_value                       | 200        |
      | Email_Basic_emailTenure_in_single_digit_value                  | 200        |

    #rerun if deliverable is null
  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Imp scenarios for regression with emailTenure notnull  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#number"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    Examples:
      | Scenario                                        | statusCode |
      | Email_Basic_isBreached_true_emailTenure_notnull | 200        |
#      | Email_Basic_freeProvider_true                   | 200        |
#      | Email_Basic_spfStrict_true_acceptAll_false      | 200        |
#      | Email_Basic_deliverable_true                    | 200        |

  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Imp scenarios for regression with emailTenure null <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#null"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    Examples:
      | Scenario                                      | statusCode |
      | Email_Basic_isBreached_false_emailTenure_null | 200        |
      | Email_Basic_freeProvider_false                | 200        |
      | Email_Basic_deliverable_false                 | 200        |
      | Email_Basic_disposable_true                   | 200        |
      | Email_Basic_custom_true                       | 200        |
      | Email_Basic_suspiciousTld_true                | 200        |


  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Special cases <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#null"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    Examples:
      | Scenario                                                                                                                                                                  | statusCode |
      | Email_Basic_creationTime_updateTime_expiryTime_companyName_acceptAll_null__registered_disposable_freeProvider_dmarcCompliance_spfStrict_suspiciousTld_websiteExists_false | 200        |

    # $.data.email.basic.domainDetails.acceptAll might come as null so rerun -sc48
  Scenario Outline:  DPI EMAIL_BASIC positive scenario where emailTenure = null - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = null
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    Examples:
      | Scenario                               | statusCode |
      | Email_Basic_EmailDeliverable_False     | 200        |
      | Email_Basic_EmailTenureIs_NULL         | 200        |
      | Email_Basic_Positive_0_BreachData      | 200        |
      | Email_Basic_Positive_CustomDomain_True | 200        |


  Scenario Outline:  DPI EMAIL_BASIC Negitive senario with invalid input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
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
      | Email_Basic_Negitive_with_2_different_multiple_email_input     | 400        |
      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     | 400        |

  Scenario Outline: DPI EMAIL_BASIC Negitive scenario with null/empty input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
#    Then match $ contains payload.response
    And match $.errors[*].message contains any ["Email cannot be empty/null"]
    And match $.errors[*].code contains any ["MISSING_EMAIL_ADDRESS"]
    And match $.errors[*].package contains any ["EMAIL_BASIC"]
    Examples:
      | Scenario                                | statusCode |
      | Email_Basic_Negitive_Emptyinput('')     | 400        |
      | Email_Basic_Negitive_Nullinput(' ')     | 400        |
      | Email_Basic_Negitive_Nullinput(null)    | 400        |
      | Email_Basic_Negitive_No_input_Email_key | 400        |
