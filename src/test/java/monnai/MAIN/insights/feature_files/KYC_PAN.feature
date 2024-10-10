@KYC_PAN @regTest_4 @KYC
Feature: Testing of DPI  - KYC_PAN Package scenarios with cashfree dp

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  #KYC_PAN - only Cashfree data parter done
  Scenario Outline:  DPI KYC_PAN Package positive scenario - sanity :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/<Scenario>.json")
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
    #    * match $.data.kyc.gstin == "#null"
    #    * match $.data.kyc.pan contains only deep payload.response.data.kyc.pan
    * def Expected_panCardName = payload.response.data.kyc.pan.panCardName
    * print Expected_panCardName
    * set payload.response.data.kyc.pan.panCardName = "#ignore"
    * def panCardName = $.data.kyc.pan.panCardName
    * def Actual_panCardName = panCardName.trim()
    * print Actual_panCardName
    * match Expected_panCardName == Actual_panCardName
    * match $.data.kyc.pan contains only deep payload.response.data.kyc.pan
    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                         | statusCode |
      | KYC_PAN_Positive_cashfree_sanity | 200        |


  Scenario Outline:  DPI KYC_PAN Package positive scenario - Validation of "valid" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/<Scenario>.json")
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
    #    * match $.data.kyc.gstin == "#null"
    * def Expected_panCardName = payload.response.data.kyc.pan.panCardName
    * print Expected_panCardName
    * set payload.response.data.kyc.pan.panCardName = "#ignore"
    * def panCardName = $.data.kyc.pan.panCardName
    * def Actual_panCardName = panCardName.trim()
    * print Actual_panCardName
    * match Expected_panCardName == Actual_panCardName
    * match $.data.kyc.pan contains only deep payload.response.data.kyc.pan
    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                              | statusCode |
      | KYC_PAN_Positive_cashfree_valid_false | 200        |
      | KYC_PAN_Positive_cashfree_valid_true  | 200        |

  Scenario Outline:  DPI KYC_PAN Package positive scenario - Validation of "status" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.kyc.pan.lastUpdated = "#ignore"
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
    #    * match $.data.kyc.gstin == "#null"
    * match $.data.kyc.pan contains only deep payload.response.data.kyc.pan
    * match $.meta contains only deep payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                  | statusCode |
      | KYC_PAN_Positive_cashfree_type_Individual | 200        |
      | KYC_PAN_Positive_cashfree_type_Company    | 200        |
  #      | KYC_PAN_Positive_cleartax_type_AOP                    | 200        |
  #      | KYC_PAN_Positive_cleartax_type_BOI               | 200        |
  #      | KYC_PAN_Positive_cleartax_type_Firm               | 200        |
  #      | KYC_PAN_Positive_cleartax_type_Government_Agency               | 200        |
  #      | KYC_PAN_Positive_cleartax_type_HUF            | 200        |
  #      | KYC_PAN_Positive_cleartax_type_Local_Authority            | 200        |
  #      | KYC_PAN_Positive_cleartax_type_Trust            | 200        |


  Scenario Outline:  DPI KYC_PAN Package positive scenario - Validation of "status" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.kyc.pan.lastUpdated = "#ignore"
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
    #    * match $.data.kyc.gstin == "#null"
    * match $.data.kyc.pan contains only deep payload.response.data.kyc.pan
    * match $.meta contains only deep payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                 | statusCode |
      | KYC_PAN_Positive_cashfree_status_VALID   | 200        |
      | KYC_PAN_Positive_cashfree_status_INVALID | 200        |
  #      | KYC_PAN_Positive_cleartax_status_FAKE                    | 200        |
  #      | KYC_PAN_Positive_cleartax_status_DEACTIVATED               | 200        |
  #      | KYC_PAN_Positive_cleartax_status_DELETED               | 200        |

  Scenario Outline:  DPI KYC_PAN Package positive scenario - Validation of "aadhaar_seeding_status" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.kyc.pan.lastUpdated = "#ignore"
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
    #    * match $.data.kyc.gstin == "#null"
    * match $.data.kyc.pan contains only deep payload.response.data.kyc.pan
    * match $.meta contains only deep payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                           | statusCode |
      | KYC_PAN_Positive_cashfree_aadhaar_seeding_status_Y | 200        |
      | KYC_PAN_Positive_cashfree_aadhaar_seeding_status_U | 200        |
  #      | KYC_PAN_Positive_cleartax_aadhaar_seeding_status_T                    | 200        |
  #      | KYC_PAN_Positive_cleartax_aadhaar_seeding_status_NA               | 200        |


  Scenario Outline:  DPI KYC_PAN Package positive scenario - Validation of "last_updated_at" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/<Scenario>.json")
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
    #    * match $.data.kyc.gstin == "#null"
    * def Expected_panCardName = payload.response.data.kyc.pan.panCardName
    * print Expected_panCardName
    * set payload.response.data.kyc.pan.panCardName = "#ignore"
    * def panCardName = $.data.kyc.pan.panCardName
    * def Actual_panCardName = panCardName.trim()
    * print Actual_panCardName
    * match Expected_panCardName == Actual_panCardName
    * match $.data.kyc.pan contains only deep payload.response.data.kyc.pan
    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                      | statusCode |
      | KYC_PAN_Positive_cashfree_last_updated_at_data_point_not_null | 200        |
  # data not found   | KYC_PAN_Positive_cleartax_last_updated_at_data_point_null_hidden               | 200        |


  Scenario Outline:  DPI KYC_PAN Package Negative scenario - Validation of "phoneDefaultCountryCode" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/Negative_scenarios/<Scenario>.json")
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
      | Scenario                                                                    | statusCode |
      # https://monnai.atlassian.net/browse/MB-4539    | KYC_PAN_Negative_INVALID_PHONE_DEFAULT_COUNTRY_CODE                 | 400        |
      # https://monnai.atlassian.net/browse/MB-4539 | KYC_PAN_Negative_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME               | 400        |

      | KYC_PAN_Negative_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY                     | 400        |
      | KYC_PAN_Negative_MISSING_PHONE_DEFAULT_COUNTRY_CODE_VALUE_OTHER_THEN_INDIA  | 501        |
      | KYC_PAN_Negative_MISSING_PHONE_DEFAULT_COUNTRY_CODE_VALUE_with_null         | 400        |
      | KYC_PAN_Negative_MISSING_PHONE_DEFAULT_COUNTRY_CODE_VALUE_with_space        | 400        |
      | KYC_PAN_Negative_MISSING_PHONE_DEFAULT_COUNTRY_CODE_VALUE_with_empty_string | 400        |
  # https://monnai.atlassian.net/browse/MB-4539     | KYC_PAN_Negative_MISSING_PHONE_DEFAULT_COUNTRY_CODE_VALUE_with_number              | 400        |
  #  https://monnai.atlassian.net/browse/MB-4539    | KYC_PAN_Negative_MISSING_PHONE_DEFAULT_COUNTRY_CODE_VALUE_with_bollen             | 400        |


  Scenario Outline:  DPI KYC_PAN Package Negative scenario - Validation of "pan" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/Negative_scenarios/<Scenario>.json")
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
      | Scenario                                                                            | statusCode |
      | KYC_PAN_Negative_scenarios_When_pan_data_Point_key_is_missing                       | 400        |
      | KYC_PAN_Negative_scenarios_When_pan_data_Point_key_value_is_invalid_syntax_format   | 400        |
      # https://monnai.atlassian.net/browse/MB-4541
      | KYC_PAN_Negative_scenarios_When_pan_data_Point_key_value_is_empty_string            | 400        |
      | KYC_PAN_Negative_scenarios_When_pan_data_Point_key_value_is_empty_string_with_space | 400        |
      | KYC_PAN_Negative_scenarios_When_pan_data_Point_key_value_is_null                    | 400        |
      #  https://monnai.atlassian.net/browse/MB-4542
      | KYC_PAN_Negative_scenarios_When_pan_data_Point_key_value_is_number                  | 400        |
      | KYC_PAN_Negative_scenarios_When_pan_data_Point_key_value_is_boolean                 | 400        |


  Scenario Outline:  DPI KYC_PAN Package Negative scenario - Validation of "packages" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/Negative_scenarios/<Scenario>.json")
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
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                   | statusCode |
      | KYC_PAN_Negative_scenarios_When_Package_name_null          | 400        |
      | KYC_PAN_Negative_scenarios_When_Package_Key_is_not_present | 400        |


  Scenario Outline:  DPI KYC_PAN Package Negative scenario - Validation of "packages" data point :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_PAN/Negative_scenarios/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
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
    * match $ contains only deep payload.response

    Examples:
      | Scenario                                            | statusCode |
      | KYC_PAN_Negative_scenarios_When_Package_empty_Array | 403        |
      | KYC_PAN_Negative_scenarios_When_Package_invalid     | 403        |