@debug @ignore
Feature: Testing of DPI Insights feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

#  Scenario Outline: Sunny day scenarios for DPI Insights <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/<Scenario>.json")
#    And headers headers
#    And header Content-Type = "application/vnd.monnai.v1.1+json"
#    And request payload.request
#    When method POST
#    Then status <statusCode>
#    Then match $ contains payload.response
#    And match $.meta.referenceId == "AMS-test-1"
#    And match $.meta.inputPhoneNumber == "+919512658291"
#    And match $.meta.cleansedPhoneNumber == "+919512658291"
#    Examples:
#      | Scenario     | statusCode         |
#      | scenario1    | 200                |
#      | scenario4    | 200                |
#      | UPI_BASIC_sc  | 200               |
##
#  Scenario Outline: Rainy day scenarios of DPI Insights <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    Then status <statusCode>
#    Then match $ contains payload.response
#    Examples:
#      | Scenario     | statusCode         |
#      | scenario2    | 400                |
#      | scenario3    | 400                |
#
#  Scenario Outline:  UPI BASIC POSITIVE SC's Insights <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    Then status <statusCode>
#    Then match $ contains payload.response
#    Examples:
#      | Scenario     | statusCode         |
#      | UPI_BASIC_sc_@ybl   | 200             |
#      | UPI_BASIC_sc_@ibl   | 200             |
#      | UPI_BASIC_sc_@axl   | 200             |
#      | UPI_BASIC_sc_@paytm  | 200             |
#      | UPI_BASIC_sc_@oksbi | 200             |
#      | UPI_BASIC_sc_@okaxis  | 200             |
#      | UPI_BASIC_sc_@okicici   | 200             |
#      | UPI_BASIC_sc_@okhdfcbank   | 200             |
#
#  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    Then status <statusCode>
#    Then match $ contains payload.response
#    Examples:
#      | Scenario     | statusCode         |
#      | UPI_BASIC_sc_Ne_nohandle | 401  |
#      | UPI_BASIC_sc_Ne_noUpi   | 401     |

#  Scenario Outline:  DPI EMAIL_BASIC possitive senario - <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    Then status <statusCode>
#    Then match $ contains payload.response
#    And match $.response.inputPhoneNumber == "+919512658291"
#    Examples:
#      | Scenario     | statusCode         |
#      | Email_Basic_Possitive_withTLDGmail(abc@gmail.com) | 200  |
#      | Email_Basic_Possitive_withDomainNet(abc@you.me.net)| 200 |
#      |  Email_Basic_Possitive_withTLD&DomainOurearch(abc@ourearth.com)  | 200 |

#  Scenario Outline:  DPI EMAIL_BASIC Negitive senario with invalid input - <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    Then status <statusCode>
#    Then match $ contains payload.response
##    And match $.errors[1].message == "Invalid email address"
##    And match $.response.errors[1].message == "Invalid email address"
#
#    Examples:
#      | Scenario     | statusCode         |
#      | Email_Basic_Negitive_NoPrefix_with@_withDomainName(@gmail.com) | 400  |
#      | Email_Basic_Negitive_withPrefix_with@_NoDomainName(abc@)       | 400  |
#      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     |400   |

#  Scenario Outline:  DPI EMAIL_BASIC Negitive senario with null/empty input - <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/EMAIL_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    Then status <statusCode>
#    Then match $ contains payload.response
##    And match $.errors[1].message == "Email cannot be empty/null"
##    And match $.response.errors[1].message == "Email cannot be empty/null"
#
#    Examples:
#      | Scenario     | statusCode         |
#      | Email_Basic_Negitive_Emptyinput('') | 400  |
#      | Email_Basic_Negitive_Nullinput(' ') | 400  |
#
