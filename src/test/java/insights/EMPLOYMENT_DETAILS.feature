@debug
Feature: Testing of DPI  - EMPLOYMENT_DETAILS feature scenarios

  Background:

    * configure charset = null
    * path '/api/insights/'

  @second
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where isEmployed is true <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    And match $.data.employment.details.pfVerification.summary.isEmployed == true
    And match $.data.employment.details.pfVerification == '#notnull'
    Then match $ contains payload.response

    Examples:
      | Scenario                                                  | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_true | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where isEmployed is false | pfDetails[0].gender is 'MALE' <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    And match $.data.employment.details.pfVerification.summary.isEmployed == false
    And match $.data.employment.details.pfVerification == '#notnull'
    And match $.data.employment.details.pfVerification.pfDetails[0].gender == 'MALE'

    Then match $ contains payload.response

    Examples:
      | Scenario                                                   | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_false | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where isEmployed_isNameUnique_isNameExact_hasPfFilingDetails is true and hasPfFilingDetails is false<Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    And match $.data.employment.details.pfVerification == '#notnull'
    And match $.data.employment.details.pfVerification.summary.isEmployed == true
    And match $.data.employment.details.pfVerification.summary.isNameUnique == true
    And match $.data.employment.details.pfVerification.summary.isNameExact == true
    And match $.data.employment.details.pfVerification.summary.isPfFiledLastMonth == false
    And match $.data.employment.details.pfVerification.summary.hasPfFilingDetails == true
    Then match $ contains payload.response

    Examples:
      | Scenario                                                                                                                       | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_isNameUnique_isNameExact_hasPfFilingDetails_true_hasPfFilingDetails_false | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Negative scenario where employment response is full null<Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    And match $.data.employment.details.pfVerification == null
    Then match $ contains payload.response

    Examples:
      | Scenario                                             | statusCode |
      | EMPLOYMENT_DETAILS_Negative_Employment_response_null | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where isNameUnique,isNameExact,isPfFiledLastMonth,hasPfFilingDetails is null | isEmployed is false | dateOfJoining & dateOfExit is not null(2023-02-11)| reasonOfExit:""(empty)<Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    And match $.data.employment.details.pfVerification == '#notnull'
    And match $.data.employment.details.pfVerification.summary.isEmployed == false
    And match $.data.employment.details.pfVerification.summary.isNameUnique == null
    And match $.data.employment.details.pfVerification.summary.isNameExact == null
    And match $.data.employment.details.pfVerification.summary.isPfFiledLastMonth == null
    And match $.data.employment.details.pfVerification.summary.hasPfFilingDetails == null
    And match $.data.employment.details.pfVerification.summary.recentEmployerName == '#notnull'
    And match $.data.employment.details.pfVerification.summary.noOfPfAccounts == '#notnull'
    And match $.data.employment.details.pfVerification.summary.dateOfJoining == '#notnull'
    And match $.data.employment.details.pfVerification.summary.dateOfExit == '#notnull'
    And match $.data.employment.details.pfVerification.pfDetails[0].reasonOfExit == ""

    Then match $ contains payload.response

    Examples:
      | Scenario                                                                                                                                                                           | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_false_isNameUnique_isNameExact_isPfFiledLastMonth_hasPfFilingDetails_null_reasonOfExit_empty_dateOfJoining_dateOfExit_notnull | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where all data-points under additionalDetails is null /pfDetails[0].additionalDetails->(nationalId,taxId,email,bankAccountNumber,bankBranchCode,bankAddress,pfNomineeName,pfNomineeRelation) is null | pfDetails[0] is notnull |pfDetails[0].gender is 'FEMALE' <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    And match $.data.employment.details.pfVerification == '#notnull'
    And match $.data.employment.details.pfVerification.summary.isEmployed == false
    And match $.data.employment.details.pfVerification.summary.isNameUnique == null
    And match $.data.employment.details.pfVerification.summary.isNameExact == null
    And match $.data.employment.details.pfVerification.summary.isPfFiledLastMonth == null
    And match $.data.employment.details.pfVerification.summary.hasPfFilingDetails == null
    And match $.data.employment.details.pfVerification.summary.recentEmployerName == '#notnull'
    And match $.data.employment.details.pfVerification.summary.noOfPfAccounts == '#notnull'
    And match $.data.employment.details.pfVerification.summary.dateOfJoining == '#notnull'
    And match $.data.employment.details.pfVerification.summary.dateOfExit == '#notnull'
    And match $.data.employment.details.pfVerification.pfDetails[0].reasonOfExit == ""
    And match $.data.employment.details.pfVerification.pfDetails[0].gender == 'MALE'

    Then match $ contains payload.response

    Examples:
      | Scenario                                                                                                                                                                           | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_false_isNameUnique_isNameExact_isPfFiledLastMonth_hasPfFilingDetails_null_reasonOfExit_empty_dateOfJoining_dateOfExit_notnull | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Positive scenario where pfFilingDetails is validated <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
#    And match $.data.employment.details.pfVerification.pfFilingDetails.employeePfMatches[0] == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails == '#notnull'
#    And match $.data.employment.details.pfVerification.pfFilingDetails.pfHistory[] == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails[*].currency == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails[*].totalAmount  == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails[*].employeeCount  == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails[*].wageMonth  == '#notnull'
    Then match $ contains payload.response

    Examples:
      | Scenario                                    | statusCode |
      | EMPLOYMENT_DETAILS_Positive_pfFilingDetails | 200        |


