
Feature: Testing of DPI  - EMPLOYMENT_ADVANCED package feature scenarios
# UAN_BASIC -> Converted into EMPLOYMENT_BASIC
# UAN_ADVANCED -> Converted into EMPLOYMENT_ADVANCED
# EMPLOYMENT_BASIC and EMPLOYMENT_ADVANCED package manual sign off was given by Anjan and AUTOMATION is done by Yashas.
#SOCIAL_LINKS will be there in the subpackage of EMPLOYMENT_DETAILS package where UAN_BASIC and UAN_ADVANCED are disabled.
#  (Manual sign off given by Anjan)
# open issues :
# https://monnai.atlassian.net/browse/MB-4198,
# https://monnai.atlassian.net/browse/MB-3802,
# https://monnai.atlassian.net/browse/MB-4209

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline: Validate DPI EMPLOYMENT_ADVANCED positive scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_ADVANCED/<Scenario>.json")
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
    Then match $.data.employment.advanced.summary contains only deep payload.response.data.employment.advanced.summary
    Then match $.data.employment.advanced.employmentHistory contains only deep payload.response.data.employment.advanced.employmentHistory
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                                                            | statusCode |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_false_noOfPfAccounts_1_additionalDetails_pfFilingDetails_dpoints_null_hidden | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_ADVANCED positive scenario when dp gives message as no_record_found <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_ADVANCED/<Scenario>.json")
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
    Then match $.data.employment.advanced contains deep payload.response.data.employment.advanced
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                               | statusCode |
    # Bug https://monnai.atlassian.net/browse/MB-3786,MB-3805
      | EMPLOYMENT_ADVANCED_is_null_when_no_record_found_in_dp | 200        |

    # After dicusion with Roopa, not validating the values of data point inside the "employeePfMatches" as it is highly dynamic
  Scenario Outline: Validate DPI EMPLOYMENT_ADVANCED positive scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_ADVANCED/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.employment.advanced.pfFilingDetails.employerPfFilingDetails = "#ignore"
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
    Then match $.data.employment.advanced.summary contains only payload.response.data.employment.advanced.summary
    Then match $.data.employment.advanced.employmentHistory contains only deep payload.response.data.employment.advanced.employmentHistory

    Then match $.data.employment.advanced.pfFilingDetails == payload.response.data.employment.advanced.pfFilingDetails

    * match each $.data.employment.advanced.pfFilingDetails.employerPfFilingDetails contains { "currency": "INR"}
    * match each $.data.employment.advanced.pfFilingDetails.employerPfFilingDetails contains { "totalAmount":'#? _ >=1'}
    * match each $.data.employment.advanced.pfFilingDetails.employerPfFilingDetails contains { "employeeCount":'#? _ >=1'}
    * match each $.data.employment.advanced.pfFilingDetails.employerPfFilingDetails contains { "wageMonth":"#regex[A-Z]{3}-[0-9]{2}"}

    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                                         | statusCode |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_true_noOfPfAccounts_1                                     | 200        |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_true_noOfPfAccounts_1_without_91                          | 200        |
# Bug https://monnai.atlassian.net/browse/MB-3800,MB-3001
      | EMPLOYMENT_ADVANCED_summary_isEmployed_isNameUnique_false_hasPfFilingDetails_true                | 200        |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_true_noOfPfAccounts_2                                     | 200        |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_false_noOfPfAccounts_2_employeePfMatches_null_hidden      | 200        |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_true_noOfPfAccounts_3                                     | 200        |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_false_noOfPfAccounts_3                                    | 200        |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_true_noOfPfAccounts_4                                     | 200        |
      | EMPLOYMENT_ADVANCED_summary_isEmployed_false_noOfPfAccounts_4                                    | 200        |
        # Bug https://monnai.atlassian.net/browse/MB-4198
      | EMPLOYMENT_ADVANCED_summary_isEmployed_true_noOfPfAccounts_5 | 200        |


# bug https://monnai.atlassian.net/browse/MB-4209 - "reasonOfExit"  mapping issue
#      | EMPLOYMENT_ADVANCED_summary_isEmployed_false_reasonOfExit_RETIREMENT | 200        | --> 8144651776
#      | EMPLOYMENT_ADVANCED_summary_isEmployed_false_reasonOfExit_SUPERNNUATION | 200        | --> 9585306554
#      | EMPLOYMENT_ADVANCED_summary_isEmployed_false_reasonOfExit_DEATH_AWAY_FROM_SERVICE | 200        | --> 9963109163

  Scenario Outline: Validate DPI EMPLOYMENT_BASIC positive scenario when "phoneDefaultCountryCode" other than IN <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_ADVANCED/Negative/<Scenario>.json")
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
    Then match $.data == null
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                               | statusCode |
      | EMPLOYMENT_ADVANCED_when_request_phoneDefaultCountryCode_other_then_IN | 501        |

  @Negative
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Negative scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_ADVANCED/Negative/<Scenario>.json")
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
    Then match $.data == null
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                                                         | statusCode |
      | EMPLOYMENT_ADVANCED_Negative_scenarios_INVALID_PHONE_NUMBER                                                      | 400        |
      | EMPLOYMENT_ADVANCED_Negative_scenarios_INVALID_PHONE_NUMBER_as_junk_value                                        | 400        |

      | EMPLOYMENT_ADVANCED_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE                                        | 400        |
      | EMPLOYMENT_ADVANCED_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME                      | 400        |
      | EMPLOYMENT_ADVANCED_Negative_scenarios_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY                                    | 400        |

      | EMPLOYMENT_ADVANCED_Negative_scenarios_when_PHONE_NUMBER_and_PHONE_DEFAULT_COUNTRY_CODE_key_is_missing           | 400        |
      | EMPLOYMENT_ADVANCED_Negative_scenarios_when_PHONE_NUMBER_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_null        | 400        |
      | EMPLOYMENT_ADVANCED_Negative_scenarios_when_PHONE_NUMBER_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_emptyString | 400        |
      | EMPLOYMENT_ADVANCED_Negative_scenarios_when_PHONE_NUMBER_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_singleSpace | 400        |

