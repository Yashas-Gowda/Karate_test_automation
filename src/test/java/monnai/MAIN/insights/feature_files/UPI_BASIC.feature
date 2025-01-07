@UPI_BASIC @regTest_4 @UPI

Feature: Testing of DPI  - UPI_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  # UPI_BASIC package all partners are disabled so insights responds 501 with "Service unavailable for country India"

  #  Scenario Outline:  UPI BASIC POSITIVE SC's Insights :- <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/UPI_BASIC/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #    # cloud watch traces -start
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
  #    Then status <statusCode>
  #    Then match $.data.upi.basic contains payload.response.data.upi.basic
  #    Then match $.meta contains payload.response.meta
  #
  #
  #    Examples:
  #      | Scenario          | statusCode |
  #      | UPI_BASIC_sc_@ybl | 200        |
  #
  #
  #  Scenario Outline:  UPI BASIC POSITIVE SC's Insights :- <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/UPI_BASIC/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #    # cloud watch traces -start
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
  #    Then status <statusCode>
  #    Then match $.data.upi.basic contains payload.response.data.upi.basic
  #    Then match $.meta contains payload.response.meta
  #    Examples:
  #      | Scenario                 | statusCode |
  #      | UPI_BASIC_sc_@ibl        | 200        |
  #      | UPI_BASIC_sc_@axl        | 200        |
  #      | UPI_BASIC_sc_@paytm      | 200        |
  #      | UPI_BASIC_sc_@oksbi      | 200        |
  #      | UPI_BASIC_sc_@okaxis     | 200        |
  #      | UPI_BASIC_sc_@okicici    | 200        |
  #      | UPI_BASIC_sc_@okhdfcbank | 200        |
  #
  #
  #  Scenario Outline:  UPI BASIC when "isUpiValid": false then NEGATIVE SC's Insights :- <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/UPI_BASIC/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #    # cloud watch traces -start
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
  #    Then status <statusCode>
  #    #  https://monnai.atlassian.net/browse/MB-3265 - resolved
  #    Then match $.data.upi.basic contains payload.response.data.upi.basic
  #    Then match $.meta contains payload.response.meta
  #
  #
  #    Examples:
  #      | Scenario                         | statusCode |
  #      | UPI_BASIC_sc_Ne_isUpiValid_false | 200        |
  #

  Scenario Outline:  UPI BASIC POSITIVE SC's Insights :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
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
    #  https://monnai.atlassian.net/browse/MB-2788 - resolved
    * match $.data == "#null"
    * match $.meta contains only deep payload.response.meta
    * match $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors


    Examples:
      | Scenario                                                    | statusCode |
      | UPI_BASIC_sc_with_valid_upiId_response_with_501_status_code | 400        |


  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights - validation of upiId:- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
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
    #  https://monnai.atlassian.net/browse/MB-2788 - resolved
    * match $.data == "#null"
    * match $.meta contains only deep payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors


    Examples:
      | Scenario                                   | statusCode |
      | UPI_BASIC_sc_Ne_upiId_value_noUpi          | 400        |
      | UPI_BASIC_sc_Ne_upiId_Invalid_nohandle     | 400        |
      | UPI_BASIC_sc_Ne_upiId_Invalid_randam_value | 400        |
      | UPI_BASIC_sc_Ne_upiId_Invalid_123          | 400        |
      | UPI_BASIC_sc_Ne_upiId_Invalid_true         | 400        |

  @Negative
  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
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
    * match $.data == "#null"
    * match $.meta contains only deep payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors


    Examples:
      | Scenario                                                                             | statusCode |
      | UPI_BASIC_sc_Ne_PHONE_DEFAULT_COUNTRY_CODE_VALUE_other_then_IN                       | 501        |
      | UPI_BASIC_sc_Ne_phoneDefaultCountryCode_key_value_with_INDIA_invalid                 | 400        |
      | UPI_BASIC_sc_Ne_phoneDefaultCountryCode_key_value_with_null                          | 400        |
      | UPI_BASIC_sc_Ne_phoneDefaultCountryCode_key_value_with_emptyString                   | 400        |
      | UPI_BASIC_sc_Ne_phoneDefaultCountryCode_key_value_with_space                         | 400        |
      | UPI_BASIC_sc_Ne_phoneDefaultCountryCode_key_is_Missing                               | 400        |
      | UPI_BASIC_sc_Ne_phoneDefaultCountryCode_key_is_Missing_along_with_upi_with_no_handle | 400        |
      | UPI_BASIC_sc_Ne_phoneDefaultCountryCode_key_is_Missing_along_with_no_upi             | 400        |

  # https://monnai.atlassian.net/browse/MB-4539     | UPI_BASIC_sc_Ne_PHONE_DEFAULT_COUNTRY_CODE_VALUE_with_number  | 400        |
  # https://monnai.atlassian.net/browse/MB-4539     | UPI_BASIC_sc_Ne_PHONE_DEFAULT_COUNTRY_CODE_VALUE_with_bollean |  400        |



