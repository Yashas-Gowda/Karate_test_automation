@regTest_3 @DOMAIN_BREACH  @DOMAIN_BREACH_BREACH_HISTORY_RECORDS

@parallel=false
Feature: Testing of DPI  - DOMAIN_BREACH -> BREACH_HISTORY_RECORDS Package scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario Outline:  DPI DOMAIN_BREACH Package positive scenario where type = BREACH_HISTORY_RECORDS  :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/DOMAIN_BREACH/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # Request-response headers
    * print 'ENV ---->', karate.prevRequest.headers.Host
    * print 'Date----->',responseHeaders["Date"][0]
    * print responseHeaders["Content-Type"][0]
    * print karate.request.headers
    * print karate.response.headers
    # cloud watch traces -start
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
    * match $.data.domain.breach == "#notnull"
    * match $.meta contains only deep payload.response.meta
    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                       | statusCode |
      | DOMAIN_BREACH_Positive_type_BREACH_HISTORY_RECORDS_when_cursor | 200        |
  #      | DOMAIN_BREACH_Positive_type_BREACH_HISTORY_RECORDS_when_Optional_cursor_with_null | 200        |
  #      | DOMAIN_BREACH_Positive_type_BREACH_HISTORY_RECORDS_when_Optional_cursor_key_missing| 200        |
  #      | DOMAIN_BREACH_Positive_type_BREACH_HISTORY_RECORDS_when_Optional_cursor_key_value_empty_string | 200        |
  #      | DOMAIN_BREACH_Positive_type_BREACH_HISTORY_RECORDS_when_Optional_cursor_key_value_empty_string_with_space | 200        |


  Scenario Outline:  DPI DOMAIN_BREACH Package Negative scenario where type = BREACH_HISTORY_RECORDS  :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/DOMAIN_BREACH/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # Request-response headers
    * print 'ENV ---->', karate.prevRequest.headers.Host
    * print 'Date----->',responseHeaders["Date"][0]
    * print responseHeaders["Content-Type"][0]
    * print karate.request.headers
    * print karate.response.headers
    # cloud watch traces -start
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
    * match $.data.domain.breach == payload.response.data.domain.breach
    * match $.meta contains only deep payload.response.meta
    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                                                                                                | statusCode |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_Optional_cursor_data_Point_key_value_is_invalid_syntax_format | 200        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_Optional_cursor_data_Point_key_value_is_invalid_abc           | 200        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_Optional_cursor_data_Point_key_value_is_invalid_123           | 200        |

      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_Optional_cursor_data_Point_key_value_is_number                | 200        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_Optional_cursor_data_Point_key_value_is_boolean               | 200        |



  Scenario Outline:  DPI DOMAIN_BREACH Package Negative scenario where type = BREACH_HISTORY_RECORDS for validation of domainName,fromDate,toDate,cursor :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/DOMAIN_BREACH/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # Request-response headers
    * print 'ENV ---->', karate.prevRequest.headers.Host
    * print 'Date----->',responseHeaders["Date"][0]
    * print responseHeaders["Content-Type"][0]
    * print karate.request.headers
    * print karate.response.headers
    # cloud watch traces -start
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
    * match $.data == "#null"
    * match $.meta contains only deep payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                                                                                             | statusCode |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_is_missing                       | 400        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_value_is_invalid_syntax_format   | 400        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_value_is_invalid_abc             | 400        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_value_is_invalid_123             | 400        |

      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_value_is_empty_string            | 400        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_value_is_empty_string_with_space | 400        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_value_is_null                    | 400        |

      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_value_is_number                  | 400        |
      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_HISTORY_RECORDS_then_domainName_data_Point_key_value_is_boolean                 | 400        |





  #
  #  #  Scenario Outline:  DPI DOMAIN_BREACH Package positive scenario where type = BREACH_SUBSCRIPTION_RECORDS :- <Scenario>
  #  #    Given url requestUrl
  #  #    And def payload = read( "../" + source + "/DOMAIN_BREACH/<Scenario>.json")
  #  #    And headers headers
  #  #    And header Authorization = BearerToken
  #  #    And request payload.request
  #  #    * set payload.response.meta.referenceId = "#ignore"
  #  #    When method POST
  #  #    # Request-response headers
  #  #    * print 'ENV ---->', karate.prevRequest.headers.Host
  #  #    * print 'Date----->',responseHeaders["Date"][0]
  #  #    * print responseHeaders["Content-Type"][0]
  #  #    * print karate.request.headers
  #  #    * print karate.response.headers
  #  #    # cloud watch traces -start
  #  #    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
  #  #    * def reference_id = karate.request.headers['x-reference-id']
  #  #    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
  #  #    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
  #  #    # ResponseTime
  #  #    * print 'responseTime----->',responseTime
  #  #    # Request-response
  #  #    * print 'API Request----->',payload.request
  #  #    * print 'Expected Response---->',payload.response
  #  #    * print 'Actual Response---->',karate.pretty(response)
  #  #    Then status <statusCode>
  #  #    * match $.data.domain.breach contains only deep payload.response.data.domain.breach
  #  #    * match $.meta contains only deep payload.response.meta
  #  #    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #  #    * match $.errors contains only deep payload.response.errors
  #  #
  #  #    Examples:
  #  #      | Scenario                                                     | statusCode |
  #  #      Domain name is not subscribed so we are unable to get the resposne for this data point
  #  #      | DOMAIN_BREACH_Positive_type_BREACH_SUBSCRIPTION_RECORDS_when_cursor           | 200        |
  #  #      | DOMAIN_BREACH_Positive_type_BREACH_SUBSCRIPTION_RECORDS_when_Optional_cursor_with_null | 200        |
  #  #      | DOMAIN_BREACH_Positive_type_BREACH_SUBSCRIPTION_RECORDS_when_Optional_cursor_key_missing| 200        |
  #  #      | DOMAIN_BREACH_Positive_type_BREACH_SUBSCRIPTION_RECORDS_when_Optional_cursor_key_value_empty_string | 200        |
  #  #      | DOMAIN_BREACH_Positive_type_BREACH_SUBSCRIPTION_RECORDS_when_Optional_cursor_key_value_empty_string_with_space | 200        |
  #
  #  Scenario Outline:  DPI DOMAIN_BREACH Package Negative scenario where type = BREACH_SUBSCRIPTION_RECORDS for validation of domainName,fromDate,toDate,cursor :- <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/DOMAIN_BREACH/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #    # Request-response headers
  #    * print 'ENV ---->', karate.prevRequest.headers.Host
  #    * print 'Date----->',responseHeaders["Date"][0]
  #    * print responseHeaders["Content-Type"][0]
  #    * print karate.request.headers
  #    * print karate.response.headers
  #    # cloud watch traces -start
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
  #    Then status <statusCode>
  #    * match $.data == "#null"
  #    * match $.meta contains only deep payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #    * match $.errors contains only deep payload.response.errors
  #
  #    Examples:
  #      | Scenario                                                     | statusCode |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_is_missing                      | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_value_is_invalid_syntax_format  | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_value_is_invalid_abc            | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_value_is_invalid_123            | 400        |
  #
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_value_is_empty_string                | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_value_is_empty_string_with_space     | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_value_is_null                        | 400        |
  #
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_value_is_number                | 400        |
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_domainName_data_Point_key_value_is_boolean               | 400        |
  #
  #
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_data_Point_key_is_missing                      | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_toDate_data_Point_key_is_missing                      | 400        |
  #
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_is_missing                      | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_invalid_syntax_format  | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_invalid_abc            | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_invalid_123            | 400        |
  #
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_empty_string                | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_empty_string_with_space     | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_null                        | 400        |
  #
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_number                | 400        |
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_boolean               | 400        |
  #
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_is_in_UTC_Format                | 400        |
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_toDate_data_Point_key_value_are_same               | 400        |
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_fromDate_data_Point_key_value_is_more_then_toDate               | 400        |
  #
  #  #      Domain name is not subscribed so we are unable to get the resposne for this data point
  #  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_Optional_cursor_data_Point_key_value_is_invalid_syntax_format  | 400        |
  #  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_Optional_cursor_data_Point_key_value_is_invalid_abc            | 400        |
  #  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_Optional_cursor_data_Point_key_value_is_invalid_123            | 400        |
  #  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_Optional_cursor_data_Point_key_value_is_number                | 400        |
  #  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_SUBSCRIPTION_RECORDS_then_Optional_cursor_data_Point_key_value_is_boolean               | 400        |
  #
  #
  #
  #  Scenario Outline:  DPI DOMAIN_BREACH Package positive scenario where type = BREACH_CATALOG  :- <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/DOMAIN_BREACH/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #    # Request-response headers
  #    * print 'ENV ---->', karate.prevRequest.headers.Host
  #    * print 'Date----->',responseHeaders["Date"][0]
  #    * print responseHeaders["Content-Type"][0]
  #    * print karate.request.headers
  #    * print karate.response.headers
  #    # cloud watch traces -start
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
  #    Then status <statusCode>
  #    * match $.data.domain.breach contains only deep payload.response.data.domain.breach
  #    * match $.meta contains only deep payload.response.meta
  #    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #    * match $.errors contains only deep payload.response.errors
  #
  #    Examples:
  #      | Scenario                                                             | statusCode |
  #      | DOMAIN_BREACH_Positive_type_BREACH_CATALOG_with_sourceId             | 200        |
  #      | DOMAIN_BREACH_Positive_type_BREACH_CATALOG_with_sourceId_1           | 200        |
  #
  #
  #
  #  Scenario Outline:  DPI DOMAIN_BREACH Package Negative scenario where type = BREACH_CATALOG for validation of "sourceId":- <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/DOMAIN_BREACH/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #    # Request-response headers
  #    * print 'ENV ---->', karate.prevRequest.headers.Host
  #    * print 'Date----->',responseHeaders["Date"][0]
  #    * print responseHeaders["Content-Type"][0]
  #    * print karate.request.headers
  #    * print karate.response.headers
  #    # cloud watch traces -start
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
  #    Then status <statusCode>
  #    * match $.data == "#null"
  #    * match $.meta contains only deep payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #    * match $.errors contains only deep payload.response.errors
  #
  #    Examples:
  #      | Scenario                                                     | statusCode |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOG_then_sourceId_data_Point_key_is_missing                      | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOG_then_sourceId_data_Point_key_value_is_invalid_syntax_format  | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOG_then_sourceId_data_Point_key_value_is_invalid_abc            | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOG_then_sourceId_data_Point_key_value_is_invalid_123            | 400        |
  #
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOG_then_domainName_data_Point_key_value_is_empty_string                | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOG_then_domainName_data_Point_key_value_is_empty_string_with_space     | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOG_then_domainName_data_Point_key_value_is_null                        | 400        |
  #
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOG_then_domainName_data_Point_key_value_is_number                | 400        |
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_is_BREACH_CATALOGS_then_domainName_data_Point_key_value_is_boolean               | 400        |
  #
  #
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_is_missing                      | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_invalid_syntax_format  | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_invalid_abc            | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_invalid_123            | 400        |
  #
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_empty_string                | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_empty_string_with_space     | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_null                        | 400        |
  #
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_number                | 400        |
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_boolean               | 400        |
  #
  #
  #
  #
  #  Scenario Outline:  DPI DOMAIN_BREACH Package Negative scenario for validation of "type" data point - sanity :- <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/DOMAIN_BREACH/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #    # Request-response headers
  #    * print 'ENV ---->', karate.prevRequest.headers.Host
  #    * print 'Date----->',responseHeaders["Date"][0]
  #    * print responseHeaders["Content-Type"][0]
  #    * print karate.request.headers
  #    * print karate.response.headers
  #    # cloud watch traces -start
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
  #    Then status <statusCode>
  #    * match $.data == "#null"
  #    * match $.meta contains only deep payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #    * match $.errors contains only deep payload.response.errors
  #
  #    Examples:
  #      | Scenario                                                     | statusCode |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_is_missing                      | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_invalid_syntax_format  | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_invalid_abc            | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_invalid_123            | 400        |
  #
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_empty_string                | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_empty_string_with_space     | 400        |
  #      | DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_null                        | 400        |
  #
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_number                | 400        |
  #      |  DOMAIN_BREACH_Negative_scenarios_When_type_data_Point_key_value_is_boolean               | 400        |




