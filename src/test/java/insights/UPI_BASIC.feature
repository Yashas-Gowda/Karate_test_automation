@upi
Feature: Testing of DPI  - UPI_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @smokeTest
  Scenario Outline:  UPI BASIC POSITIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/UPI_BASIC/<Scenario>.json")
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
    Then match $.data.upi.basic contains payload.response.data.upi.basic
    Then match $.meta contains payload.response.meta


    Examples:
      | Scenario                 | statusCode |
      | UPI_BASIC_sc_@ybl        | 200        |
      | UPI_BASIC_sc_@ibl        | 200        |
      | UPI_BASIC_sc_@axl        | 200        |
      | UPI_BASIC_sc_@paytm      | 200        |
      | UPI_BASIC_sc_@oksbi      | 200        |
      | UPI_BASIC_sc_@okaxis     | 200        |
      | UPI_BASIC_sc_@okicici    | 200        |
      | UPI_BASIC_sc_@okhdfcbank | 200        |

  Scenario Outline:  UPI BASIC when "isUpiValid": false then NEGATIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/UPI_BASIC/<Scenario>.json")
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
#  https://monnai.atlassian.net/browse/MB-3265 - resolved
    Then match $.data.upi.basic contains payload.response.data.upi.basic
    Then match $.meta contains payload.response.meta


    Examples:
      | Scenario                         | statusCode |
      | UPI_BASIC_sc_Ne_isUpiValid_false | 200        |


  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/UPI_BASIC/<Scenario>.json")
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
    * match $.errors[*].message contains any "Missing UPI address"
    * match $.errors[*].code contains any "MISSING_UPI"


    Then match $ contains any payload.response


    Examples:
      | Scenario              | statusCode |
      | UPI_BASIC_sc_Ne_noUpi | 400        |

  @smokeTest
  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/UPI_BASIC/<Scenario>.json")
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
    * match $.errors[0].message contains any "Invalid UPI address"
    * match $.errors[0].code contains any "INVALID_UPI"
    Then match $ contains  payload.response


    Examples:
      | Scenario                 | statusCode |
      | UPI_BASIC_sc_Ne_nohandle | 400        |

