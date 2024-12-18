@EMPLOYMENT_BASIC @regTest_3 @EMPLOYMENT_PACKAGES
Feature: Testing of DPI  - EMPLOYMENT_BASIC package feature scenarios
  # UAN_BASIC -> Converted into EMPLOYMENT_BASIC
  # UAN_ADVANCED -> Converted into EMPLOYMENT_ADVANCED
  # EMPLOYMENT_BASIC and EMPLOYMENT_ADVANCED package manual sign off was given by Anjan and AUTOMATION is done by Yashas.
  #SOCIAL_LINKS will be there in the subpackage of EMPLOYMENT_DETAILS package where UAN_BASIC and UAN_ADVANCED are disabled.
  #  (Manual sign off given by Anjan)

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario Outline: Validate DPI EMPLOYMENT_BASIC positive scenario  --> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_BASIC/<Scenario>.json")
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
    * set payload.response.data.employment.basic.employmentHistory[*].nationalIdVerificationStatus = "#ignore"
    * match each $.data.employment.basic.employmentHistory[*].nationalIdVerificationStatus == "#boolean"
    Then match $.data.employment.basic.summary contains payload.response.data.employment.basic.summary
    Then match $.data.employment.basic.employmentHistory contains only deep payload.response.data.employment.basic.employmentHistory
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                             | statusCode |
      | EMPLOYMENT_BASIC_summary_isEmployed_true_noOfPfAccounts_1            | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_true_noOfPfAccounts_1_without_91 | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_BASIC positive scenario --> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_BASIC/<Scenario>.json")
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
    Then match $.data.employment.basic.summary contains payload.response.data.employment.basic.summary
    * set payload.response.data.employment.basic.employmentHistory[*].nationalIdVerificationStatus = "#ignore"
    * match each $.data.employment.basic.employmentHistory[*].nationalIdVerificationStatus == "#boolean"
    Then match $.data.employment.basic.employmentHistory contains only deep payload.response.data.employment.basic.employmentHistory
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                   | statusCode |
      # Bug https://monnai.atlassian.net/browse/MB-3786  | EMPLOYMENT_BASIC_is_null_when_no_record_found_in_dp     |                  | 200        |
      #
      | EMPLOYMENT_BASIC_summary_isEmployed_false_noOfPfAccounts_1 | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_true_noOfPfAccounts_2  | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_false_noOfPfAccounts_2 | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_true_noOfPfAccounts_3  | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_false_noOfPfAccounts_3 | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_true_noOfPfAccounts_4  | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_false_noOfPfAccounts_4 | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_true_noOfPfAccounts_5  | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS scenario when data partner gives 200 with response  --> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_BASIC/<Scenario>.json")
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
    Then match $.data.employment.basic contains payload.response.data.employment.basic
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                                   | statusCode |
      | EMPLOYMENT_BASIC_returns_M50_1001_when_dp_returns_message_no_records_found_for_phone_input | 200        |
      | EMPLOYMENT_BASIC_returns_M50_1001_when_dp_returns_message_no_records_found_for_pan_input   | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_BASIC positive scenario when input is pan--> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_BASIC/<Scenario>.json")
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
    Then match $.data.employment.basic.summary contains payload.response.data.employment.basic.summary
    * set payload.response.data.employment.basic.employmentHistory[*].nationalIdVerificationStatus = "#ignore"
    * match each $.data.employment.basic.employmentHistory[*].nationalIdVerificationStatus == "#boolean"
    Then match $.data.employment.basic.employmentHistory contains only deep payload.response.data.employment.basic.employmentHistory
    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                 | statusCode |
      | EMPLOYMENT_BASIC_summary_isEmployed_false_noOfPfAccounts_1_for_pan_input | 200        |
      | EMPLOYMENT_BASIC_summary_isEmployed_true_noOfPfAccounts_1_for_pan_input  | 200        |
      | EMPLOYMENT_BASIC_summary_when_both_pan_phone_are_input                   | 200        |
      | EMPLOYMENT_BASIC_summary_when_only_input_is_phone_number                 | 200        |
  #      | EMPLOYMENT_BASIC_summary_when_only_input_is_pan                          | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_BASIC positive scenario when "phoneDefaultCountryCode" other than IN --> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_BASIC/Negative/<Scenario>.json")
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
      | Scenario                                                            | statusCode |
      | EMPLOYMENT_BASIC_when_request_phoneDefaultCountryCode_other_then_IN | 501        |


  @30_oct_2024
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Negative scenario  --> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_BASIC/Negative/<Scenario>.json")
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
    Then match payload.response.errors contains only $.errors

    Examples:
      | Scenario                                                                                                          | statusCode |
      | EMPLOYMENT_BASIC_Negative_scenarios_INVALID_PHONE_NUMBER                                                          | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_INVALID_PHONE_NUMBER_as_junk_value                                            | 400        |

      | EMPLOYMENT_BASIC_Negative_scenarios_INVALID_PAN                                                                   | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_INVALID_PAN_as_junk_value                                                     | 400        |

      | EMPLOYMENT_BASIC_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE                                            | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME                          | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY                                        | 400        |

      | EMPLOYMENT_BASIC_Negative_scenarios_when_PAN_and_PHONE_DEFAULT_COUNTRY_CODE_key_is_missing                        | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_when_PAN_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_null                     | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_when_PAN_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_emptyString              | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_when_PAN_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_singleSpace              | 400        |

      | EMPLOYMENT_BASIC_Negative_scenarios_when_PHONE_NUMBER_PAN_and_PHONE_DEFAULT_COUNTRY_CODE_key_is_missing           | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_when_PHONE_NUMBER_PAN_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_null        | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_when_PHONE_NUMBER_PAN_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_emptyString | 400        |
      | EMPLOYMENT_BASIC_Negative_scenarios_when_PHONE_NUMBER_PAN_and_PHONE_DEFAULT_COUNTRY_CODE_key_Value_is_singleSpace | 400        |








