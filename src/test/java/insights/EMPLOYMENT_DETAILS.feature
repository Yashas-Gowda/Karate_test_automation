Feature: Testing of DPI  - EMPLOYMENT_DETAILS feature scenarios for sub package UAN_BASIC
# we have 2 data partners(Visum,SocialLinks), on suggestion of Product team we picked Visam dp for automation.
  # as socialinks dp price is high so it is not decided to use as priamry data partner yet as per Anjan

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Subpackage positive scenario with employmentHistory and educationHistory  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
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
    Then match $.data.employment.details.social.summary contains payload.response.data.employment.details.social.summary
    Then match $.data.employment.details.social.employmentHistory contains only deep payload.response.data.employment.details.social.employmentHistory
    Then match $.data.employment.details.social.educationHistory contains only deep payload.response.data.employment.details.social.educationHistory
    Then match $.data.employment.details.social.recentActivity == null

    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                                    | statusCode |
      | EMPLOYMENT_DETAILS_Visum_dp_with_both_employmentHistory_count_11_educationHistory_count_2   | 200        |
      | EMPLOYMENT_DETAILS_Visum_dp_with_both_employmentHistory_count_9_educationHistory_count_1    | 200        |
      | EMPLOYMENT_DETAILS_Visum_dp_with_employmentHistory_count_1_without_educationHistory         | 200        |
      | EMPLOYMENT_DETAILS_Visum_dp_with_employmentHistory_count_7_without_educationHistory         | 200        |

      | EMPLOYMENT_DETAILS_Visum_dp_with_educationHistory_count_2_without_employmentHistory_count_0 | 200        |

  @Negative
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Subpackage positive scenario without any employmentHistory and educationHistory  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
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
    Then match $.data.employment.details.social.summary contains payload.response.data.employment.details.social.summary
    Then match $.data.employment.details.social.employmentHistory contains only deep payload.response.data.employment.details.social.employmentHistory
    Then match $.data.employment.details.social.educationHistory contains only deep payload.response.data.employment.details.social.educationHistory
    Then match $.data.employment.details.social.recentActivity == null

    Then match $.meta contains only payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                                   | statusCode |
      | EMPLOYMENT_DETAILS_Visum_dp_without_any_employmentHistory_educationHistory | 200        |

#  As dev team not implemented negative scenarios, so we are commenting
#  @Negative
#  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Subpackage Negative scenario <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + source + "/EMPLOYMENT_DETAILS/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    Then status <statusCode>
#   # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # Request-response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#
#    Then match $.data == null
#    Then match $.meta contains only payload.response.meta
#    Then match $.errors contains only payload.response.errors
#
#    Examples:
#      | Scenario                                                                          | statusCode |
#      | EMPLOYMENT_DETAILS_Negative_scenarios_when_email_key_is_missing                   | 200        |
#      | EMPLOYMENT_DETAILS_Negative_scenarios_when_email_key_value_is_null                | 200        |
#      | EMPLOYMENT_DETAILS_Negative_scenarios_when_email_key_value_is_empty_string        | 200        |
#      | EMPLOYMENT_DETAILS_Negative_scenarios_when_email_key_value_is_single_space_string | 200        |
#      | EMPLOYMENT_DETAILS_Negative_scenarios_when_email_key_value_is_invalid             | 200        |
#


