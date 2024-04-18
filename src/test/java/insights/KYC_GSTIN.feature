@KYC_GSTIN

Feature: Testing of DPI  - KYC_GSTIN Package scenarios with cashfree dp

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline:  DPI KYC_GSTIN Package positive scenario - sanity :- <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/KYC_GSTIN/<Scenario>.json")
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
    * match $.data.kyc.pan == "#null"
    * match $.data.kyc.gstin contains only deep payload.response.data.kyc.gstin
    * match $.meta contains only deep payload.response.meta
    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                          | statusCode |
      | KYC_GSTIN_Positive_cashfree_sanity_registeredName_Monnai          | 200        |
      | KYC_GSTIN_Positive_cashfree_sanity_sample_1                       | 200        |
      | KYC_GSTIN_Positive_cashfree_sanity_sample_2                       | 200        |
      | KYC_GSTIN_Positive_cashfree_sanity_sample_3                       | 200        |

  Scenario Outline:  DPI KYC_GSTIN Package Negative scenarios for differnt samples :- <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/KYC_GSTIN/<Scenario>.json")
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
      | Scenario                                                          | statusCode |
      | KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_is_missing                      | 400        |
      | KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_value_is_invalid_syntax_format  | 400        |
      | KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_value_is_invalid_abc            | 400        |
      | KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_value_is_invalid_123            | 400        |

      # https://monnai.atlassian.net/browse/MB-4541
      | KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_value_is_empty_string                | 400        |
      | KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_value_is_empty_string_with_space     | 400        |
      | KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_value_is_null                        | 400        |

      #  https://monnai.atlassian.net/browse/MB-4542
      |  KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_value_is_number                | 400        |
      |  KYC_GSTIN_Negative_scenarios_When_pan_data_Point_key_value_is_boolean               | 400        |




