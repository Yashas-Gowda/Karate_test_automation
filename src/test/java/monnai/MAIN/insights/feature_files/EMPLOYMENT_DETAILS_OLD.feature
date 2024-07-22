@ignore
Feature: Testing of DPI  - EMPLOYMENT_DETAILS feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @second
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where isEmployed is true <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # Request-response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    And match $.data.employment.details.pfVerification.summary.isEmployed == true
    And match $.data.employment.details.pfVerification == '#notnull'
    Then match $.data.employment contains payload.response.data.employment


    Examples:
      | Scenario                                                  | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_true | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where isEmployed is false | pfDetails[0].gender is 'MALE' <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # Request-response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    And match $.data.employment.details.pfVerification.summary.isEmployed == false
    And match $.data.employment.details.pfVerification == '#notnull'
    And match $.data.employment.details.pfVerification.pfDetails[0].gender == 'MALE'

    Then match $.data.employment contains payload.response.data.employment


    Examples:
      | Scenario                                                   | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_false | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where isEmployed_isNameUnique_isNameExact_hasPfFilingDetails is true and hasPfFilingDetails is false<Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # Request-response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    And match $.data.employment.details.pfVerification == '#notnull'
    And match $.data.employment.details.pfVerification.summary.isEmployed == true
    And match $.data.employment.details.pfVerification.summary.isNameUnique == true
    And match $.data.employment.details.pfVerification.summary.isNameExact == true
    And match $.data.employment.details.pfVerification.summary.isPfFiledLastMonth == false
    And match $.data.employment.details.pfVerification.summary.hasPfFilingDetails == true
    Then match $.data.employment contains payload.response.data.employment


    Examples:
      | Scenario                                                                                                                       | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_isNameUnique_isNameExact_hasPfFilingDetails_true_hasPfFilingDetails_false | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Negative scenario where employment response is full null<Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # Request-response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    And match $.data.employment.details.pfVerification == null
    Then match $.data.employment contains payload.response.data.employment


    Examples:
      | Scenario                                             | statusCode |
      | EMPLOYMENT_DETAILS_Negative_Employment_response_null | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where isNameUnique,isNameExact,isPfFiledLastMonth,hasPfFilingDetails is null | isEmployed is false | dateOfJoining & dateOfExit is not null(2023-02-11)| reasonOfExit:""(empty)<Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # Request-response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
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

    Then match $.data.employment contains payload.response.data.employment


    Examples:
      | Scenario                                                                                                                                                                           | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_false_isNameUnique_isNameExact_isPfFiledLastMonth_hasPfFilingDetails_null_reasonOfExit_empty_dateOfJoining_dateOfExit_notnull | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS positive scenario with single valid input where all data-points under additionalDetails is null /pfDetails[0].additionalDetails->(nationalId,taxId,email,bankAccountNumber,bankBranchCode,bankAddress,pfNomineeName,pfNomineeRelation) is null | pfDetails[0] is notnull |pfDetails[0].gender is 'FEMALE' <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # Request-response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
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

    Then match $.data.employment contains payload.response.data.employment


    Examples:
      | Scenario                                                                                                                                                                           | statusCode |
      | EMPLOYMENT_DETAILS_Positive_1_valid_input_isEmployed_false_isNameUnique_isNameExact_isPfFiledLastMonth_hasPfFilingDetails_null_reasonOfExit_empty_dateOfJoining_dateOfExit_notnull | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Positive scenario where pfFilingDetails is validated <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # Request-response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    #    And match $.data.employment.details.pfVerification.pfFilingDetails.employeePfMatches[0] == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails == '#notnull'
    #    And match $.data.employment.details.pfVerification.pfFilingDetails.pfHistory[] == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails[*].currency == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails[*].totalAmount  == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails[*].employeeCount  == '#notnull'
    And match $.data.employment.details.pfVerification.pfFilingDetails.employerPfFilingDetails[*].wageMonth  == '#notnull'
    Then match $.data.employment contains payload.response.data.employment


    Examples:
      | Scenario                                    | statusCode |
      | EMPLOYMENT_DETAILS_Positive_pfFilingDetails | 200        |


