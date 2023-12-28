Feature: Testing of DPI  - EMPLOYMENT_DETAILS feature scenarios for sub package UAN_BASIC
# UAN_BASIC and UAN_ADVANCED are given manual sign off by Sameena, Automation is done by taking manual sign off as Source.
#SOCIAL_LINKS is given manual sign off by Yashas, Automation is done by taking manual sign off as Source.
# time out for package is 60 secs, but scenarios will fail as UAN_ADVANCED take more time then as expected.

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @UAN_BASIC
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Subpackage UAN_BASIC positive scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_DETAILS/UAN_BASIC/<Scenario>.json")
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
    Then match $.data.employment.details.pfBasic.summary contains payload.response.data.employment.details.pfBasic.summary
    Then match $.data.employment.details.pfBasic.pfDetails contains only payload.response.data.employment.details.pfBasic.pfDetails
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                  | statusCode |
      | EMPLOYMENT_DETAILS_Sub_UAN_BASIC_summary_isEmployed_true_noOfPfAccounts_1 | 200        |
      | EMPLOYMENT_DETAILS_Sub_UAN_BASIC_summary_isEmployed_true_noOfPfAccounts_2 | 200        |
      | EMPLOYMENT_DETAILS_Sub_UAN_BASIC_summary_isEmployed_true_noOfPfAccounts_3 | 200        |


  @UAN_BASIC @Negative
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Subpackage UAN_BASIC Negative scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_DETAILS/UAN_BASIC/<Scenario>.json")
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
    Then match $.data.employment.details contains payload.response.data.employment.details
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                    | statusCode |
      | EMPLOYMENT_DETAILS_Sub_UAN_BASIC_pfBasic_is_null_when_no_record_found_in_dp | 200        |


  @UAN_ADVANCED
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Subpackage UAN_ADVANCED positive scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_DETAILS/UAN_ADVANCED/<Scenario>.json")
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
    Then match $.data.employment.details.pfAdvanced.summary contains payload.response.data.employment.details.pfAdvanced.summary
    Then match $.data.employment.details.pfAdvanced.pfDetails contains only payload.response.data.employment.details.pfAdvanced.pfDetails
    Then match $.data.employment.details.pfAdvanced.pfFilingDetails.employeePfMatches contains only payload.response.data.employment.details.pfAdvanced.pfFilingDetails.employeePfMatches
    Then match $.data.employment.details.pfAdvanced.pfFilingDetails.employerPfFilingDetails contains only payload.response.data.employment.details.pfAdvanced.pfFilingDetails.employerPfFilingDetails
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                     | statusCode |
      | EMPLOYMENT_DETAILS_Sub_UAN_ADVANCED_summary_isEmployed_true_noOfPfAccounts_1 | 200        |
#     some times bewlow scenarios fail due to time out error so increase timeout
      | EMPLOYMENT_DETAILS_Sub_UAN_ADVANCED_summary_isEmployed_true_noOfPfAccounts_2 | 200        |
      | EMPLOYMENT_DETAILS_Sub_UAN_ADVANCED_summary_isEmployed_true_noOfPfAccounts_3 | 200        |

  @UAN_ADVANCED @Negative
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Subpackage UAN_ADVANCED Negative scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_DETAILS/UAN_ADVANCED/<Scenario>.json")
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
    Then match $.data.employment.details contains payload.response.data.employment.details
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                       | statusCode |
      | EMPLOYMENT_DETAILS_Sub_UAN_ADVANCED_pfBasic_is_null_when_no_record_found_in_dp | 200        |

  @UAN_BASIC @UAN_ADVANCED @Negative
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Negative scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_DETAILS/Negative/<Scenario>.json")
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
      | Scenario                                                                                   | statusCode |
      | EMPLOYMENT_DETAILS_Negative_scenarios_INVALID_PHONE_NUMBER                                 | 400        |
      | EMPLOYMENT_DETAILS_Negative_scenarios_INVALID_PHONE_NUMBER_as_junk_value                   | 400        |

      | EMPLOYMENT_DETAILS_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE                   | 400        |
      | EMPLOYMENT_DETAILS_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME | 400        |
      | EMPLOYMENT_DETAILS_Negative_scenarios_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY               | 400        |


      | EMPLOYMENT_DETAILS_Negative_scenarios_when_both_phone_email_key_is_missing                 | 400        |
      | EMPLOYMENT_DETAILS_Negative_scenarios_when_both_phone_email_key_is_null                    | 400        |
      | EMPLOYMENT_DETAILS_Negative_scenarios_when_both_phone_email_key_is_empty_string            | 400        |
      | EMPLOYMENT_DETAILS_Negative_scenarios_when_both_phone_email_key_is_single_space_string     | 400        |

      | EMPLOYMENT_DETAILS_Negative_scenarios_INVALID_PHONE_NUMBER                                 | 400        |


