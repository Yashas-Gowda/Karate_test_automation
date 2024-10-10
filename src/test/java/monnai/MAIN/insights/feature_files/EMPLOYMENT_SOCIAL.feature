@EMPLOYMENT_SOCIAL @regTest_3 @EMPLOYMENT_PACKAGES
Feature:Testing of DPI  - EMPLOYMENT_SOCIAL feature scenarios on Social sub package for dp Visam

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline: Validate DPI EMPLOYMENT_SOCIAL Subpackage positive scenario with employmentHistory and educationHistory :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_SOCIAL/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.data.employment.details.social.employmentHistory[0].employerLogo = "#ignore"
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
    * set payload.response.data.employment.social.summary.photoUrl = "#ignore"
    * set payload.response.data.employment.social.summary.linkedinUrl = "#ignore"
    * match $.data.employment.social.summary.linkedinUrl == "#regex ^.*(https://).*"
    * match $.data.employment.social.summary.photoUrl == "#regex ^.*(https://).*"
    Then match  $.data.employment.social.summary  contains  payload.response.data.employment.social.summary
    * set payload.response.data.employment.social.employmentHistory[*].employerLogo = "#regex ^.*(https://).*"
    * match each $.data.employment.social.employmentHistory[*].employerLogo == "#regex ^.*(https://).*"
    * set payload.response.data.employment.social.employmentHistory[*].employerLinkedinUrl = "#ignore"
    * match each $.data.employment.social.employmentHistory[*].employerLinkedinUrl == "#regex ^.*(https://).*"
    #    Then match  $.data.employment.social.employmentHistory contains only payload.response.data.employment.social.employmentHistory
    Then match each $.data.employment.social.employmentHistory == {"employeeDesignation": "#string", "employerName": "#string","employerLocation": "##string","dateOfJoining": "#regex\\d{4}-\\d{2}-\\d{2}", "dateOfExit":"##regex\\d{4}-\\d{2}-\\d{2}", "employerLogo": "#regex ^.*(https://).*", "employerLinkedinUrl":"#regex ^.*(https://).*"}

    Then match payload.response.data.employment.social.educationHistory == $.data.employment.social.educationHistory
    #    Then match $.data.employment.details.social.recentActivity == null

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Then match  payload.response.errors contains only $.errors

    Examples:
      | Scenario                                                                                 | statusCode |
      | EMPLOYMENT_SOCIAL_Visum_dp_with_both_employmentHistory_count_11_educationHistory_count_2 | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_SOCIAL Subpackage positive scenario with employmentHistory(without photoUrl) and educationHistory :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_SOCIAL/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.data.employment.details.social.employmentHistory[0].employerLogo = "#ignore"
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
    #    * set payload.response.data.employment.social.summary.photoUrl = "#ignore"
    * set payload.response.data.employment.social.summary.linkedinUrl = "#ignore"
    * match $.data.employment.social.summary.linkedinUrl == "#regex ^.*(https://).*"
    #    * match $.data.employment.social.summary.photoUrl == "#regex ^.*(https://).*"
    Then match  $.data.employment.social.summary  contains  payload.response.data.employment.social.summary
    #    * set payload.response.data.employment.social.employmentHistory[*].employerLogo = "#regex ^.*(https://).*"
    #    * match each $.data.employment.social.employmentHistory[*].employerLogo == "#regex ^.*(https://).*"
    * set payload.response.data.employment.social.employmentHistory[*].employerLinkedinUrl = "#ignore"
    * match each $.data.employment.social.employmentHistory[*].employerLinkedinUrl == "#regex ^.*(https://).*"
    #    Then match  $.data.employment.social.employmentHistory contains only payload.response.data.employment.social.employmentHistory
    Then match each $.data.employment.social.employmentHistory == {"employeeDesignation": "##string", "employerName": "#string","employerLocation": "##string","dateOfJoining": "#regex\\d{4}-\\d{2}-\\d{2}", "dateOfExit":"##regex\\d{4}-\\d{2}-\\d{2}", "employerLogo": "##regex ^.*(https://).*", "employerLinkedinUrl":"#regex ^.*(https://).*"}

    Then match payload.response.data.employment.social.educationHistory == $.data.employment.social.educationHistory
    #    Then match $.data.employment.details.social.recentActivity == null

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Then match  payload.response.errors contains only $.errors

    Examples:
      | Scenario                                                                          | statusCode |
      | EMPLOYMENT_SOCIAL_Visum_dp_with_employmentHistory_count_7_with_1_educationHistory | 200        |

  Scenario Outline: Validate DPI EMPLOYMENT_SOCIAL Subpackage positive scenario with employmentHistory and without educationHistory :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_SOCIAL/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.data.employment.details.social.employmentHistory[0].employerLogo = "#ignore"
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
    * set payload.response.data.employment.social.summary.photoUrl = "#ignore"
    * set payload.response.data.employment.social.summary.linkedinUrl = "#ignore"
    * match $.data.employment.social.summary.linkedinUrl == "#regex ^.*(https://).*"
    * match $.data.employment.social.summary.photoUrl == "#regex ^.*(https://).*"
    Then match  $.data.employment.social.summary  contains  payload.response.data.employment.social.summary
    * set payload.response.data.employment.social.employmentHistory[*].employerLogo = "#regex ^.*(https://).*"
    * match each $.data.employment.social.employmentHistory[*].employerLogo == "#regex ^.*(https://).*"
    * set payload.response.data.employment.social.employmentHistory[*].employerLinkedinUrl = "#ignore"
    * match each $.data.employment.social.employmentHistory[*].employerLinkedinUrl == "#regex ^.*(https://).*"
    #    Then match  $.data.employment.social.employmentHistory contains only payload.response.data.employment.social.employmentHistory
    Then match each $.data.employment.social.employmentHistory == {"employeeDesignation": "#string", "employerName": "#string","employerLocation": "##string","dateOfJoining": "##regex\\d{4}-\\d{2}-\\d{2}", "dateOfExit":"##regex\\d{4}-\\d{2}-\\d{2}", "employerLogo": "#regex ^.*(https://).*", "employerLinkedinUrl":"#regex ^.*(https://).*"}

    #    Then match payload.response.data.employment.social.educationHistory == $.data.employment.social.educationHistory
    #    Then match $.data.employment.details.social.recentActivity == null

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Then match  payload.response.errors contains only $.errors

    Examples:
      | Scenario | statusCode |
  #  dp giving null      | EMPLOYMENT_SOCIAL_Visum_dp_with_employmentHistory_count_1_without_educationHistory | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_SOCIAL Subpackage positive scenario with employmentHistory and educationHistory with summary.photoUrl=null  :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_SOCIAL/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.data.employment.details.social.summary.photoUrl = "#ignore"
    #    * set payload.response.data.employment.details.social.employmentHistory[0].employerLogo = "#ignore"
    When method POST
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
    Then status <statusCode>
    * set payload.response.data.employment.details.social.summary.linkedinUrl = "#ignore"
    Then match payload.response.data.employment.social.summary contains $.data.employment.social.summary
    #    * match $.data.employment.details.social.summary.photoUrl == "#null"
    * match $.data.employment.social.summary.linkedinUrl == "#string"
    #    Then match payload.response.data.employment.social.employmentHistory  == $.data.employment.social.employmentHistory
    Then match each $.data.employment.social.employmentHistory == {"employeeDesignation": "##string", "employerName": "#string","employerLocation": "##string","dateOfJoining": "#regex\\d{4}-\\d{2}-\\d{2}", "dateOfExit":"##regex\\d{4}-\\d{2}-\\d{2}", "employerLogo": "##regex ^.*(https://).*", "employerLinkedinUrl":"#regex ^.*(https://).*"}

    #    * match $.data.employment.details.social.employmentHistory[0].employerLogo == "#string"
    Then match payload.response.data.employment.social.educationHistory == $.data.employment.social.educationHistory
    #    Then match $.data.employment.social.recentActivity == null

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Then match  payload.response.errors contains only $.errors

    Examples:
      | Scenario | statusCode |
  #  dp giving null      | EMPLOYMENT_SOCIAL_Visum_dp_with_both_employmentHistory_count_9_educationHistory_count_1 | 200        |


  Scenario Outline: Validate DPI EMPLOYMENT_SOCIAL Subpackage positive scenario with only educationHistory :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_SOCIAL/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.data.employment.details.social.summary.photoUrl = "#ignore"
    * set payload.response.data.employment.details.social.summary.linkedinUrl = "#ignore"
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
    Then match payload.response.data.employment.social.summary contains $.data.employment.social.summary
    Then match payload.response.data.employment.social.employmentHistory  == $.data.employment.social.employmentHistory
    Then match payload.response.data.employment.social.educationHistory == $.data.employment.social.educationHistory
    #    * match $.data.employment.details.social.summary.photoUrl == "#string"
    * match $.data.employment.social.summary.linkedinUrl == "#string"

    #    Then match $.data.employment.social.recentActivity == null

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Then match  payload.response.errors contains only $.errors

    Examples:
      | Scenario | statusCode |
  #  dp giving null     | EMPLOYMENT_SOCIAL_Visum_dp_with_educationHistory_count_1_without_employmentHistory_count_0 | 200        |


  # https://monnai.atlassian.net/browse/MB-5270 https://monnai.atlassian.net/browse/MB-5098
  @Negative
  Scenario Outline: Validate DPI EMPLOYMENT_SOCIAL Subpackage positive scenario without any employmentHistory and educationHistory :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_SOCIAL/<Scenario>.json")
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
    Then match payload.response.data.employment.social.summary contains $.data.employment.social.summary
    Then match payload.response.data.employment.social.employmentHistory  == $.data.employment.social.employmentHistory
    Then match payload.response.data.employment.social.educationHistory == $.data.employment.social.educationHistory

    Then match $.data.employment.social.recentActivity == null

    Then match payload.response.meta contains only $.meta
    Then match  payload.response.errors contains only $.errors

    Examples:
      | Scenario | statusCode |
  #    https://monnai.atlassian.net/browse/MB-5270 https://monnai.atlassian.net/browse/MB-5098  | EMPLOYMENT_SOCIAL_Visum_dp_without_any_employmentHistory_educationHistory | 200        |



  Scenario Outline: Validate DPI EMPLOYMENT_SOCIAL Subpackage Negative scenario:- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMPLOYMENT_SOCIAL/Negative/<Scenario>.json")
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
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Then match  payload.response.errors contains only $.errors
    Then match  payload.response.errors == $.errors

    Examples:
      | Scenario                                                                         | statusCode |
      | EMPLOYMENT_SOCIAL_Negative_scenarios_when_email_key_is_missing                   | 400        |
      | EMPLOYMENT_SOCIAL_Negative_scenarios_when_email_key_value_is_null                | 400        |
      | EMPLOYMENT_SOCIAL_Negative_scenarios_when_email_key_value_is_empty_string        | 400        |
      | EMPLOYMENT_SOCIAL_Negative_scenarios_when_email_key_value_is_single_space_string | 400        |
      | EMPLOYMENT_SOCIAL_Negative_scenarios_when_email_key_value_is_invalid             | 400        |
      | EMPLOYMENT_SOCIAL_Negative_scenarios_when_email_key_value_is_123                 | 400        |




