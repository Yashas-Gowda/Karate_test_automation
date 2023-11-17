Feature: Testing of DPI  - IP_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @smokeTest
  Scenario Outline: Validation of IP_BASIC Negative scenario for error code when an invalid / null / empty IP address in input -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + source + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
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
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
    Then match $ contains payload.response

    Examples:
      | Scenario                              | ipAddress | statusCode | errorCode          | errorMessage                 |
      | IP_BASIC_NEGATIVE_empty_or_null_input | ""        | 400        | MISSING_IP_ADDRESS | Missing IPv4 or IPv6 address |
      | IP_BASIC_NEGATIVE_empty_or_null_input | null      | 400        | MISSING_IP_ADDRESS | Missing IPv4 or IPv6 address |

    #CHECK - Looks same as the above sceanrio
  Scenario Outline: Validation of IP_BASIC Negative scenario for error code when an invalid / null / empty IP address in input -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + source + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
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
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
    Then match $ contains payload.response


    Examples:
      | Scenario                               | ipAddress | statusCode | errorCode          | errorMessage                 |
      | IP_BASIC_NEGATIVE_empty_or_null_input1 | " "       | 400        | MISSING_IP_ADDRESS | Missing IPv4 or IPv6 address |


  Scenario Outline: Validation of IP_BASIC Negative scenario for error code when an invalid IP_address in input -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + source + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.meta.inputIpAddress = "#ignore"
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
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
    Then match $ contains payload.response

    Examples:
      | Scenario                        | ipAddress | statusCode | errorCode          | errorMessage       |
      | IP_BASIC_NEGATIVE_invalid_input | "abc"     | 400        | INVALID_IP_ADDRESS | Invalid IP Address |
      | IP_BASIC_NEGATIVE_invalid_input | "123"     | 400        | INVALID_IP_ADDRESS | Invalid IP Address |
      | IP_BASIC_NEGATIVE_invalid_input | "123abc"  | 400        | INVALID_IP_ADDRESS | Invalid IP Address |

  @smokeTest
  Scenario Outline: Validation of IP_BASIC Positive scenario for Valid IPV4 & IPV6 IP_address in input -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + source + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
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
    Then match $.data.ip.basic contains payload.response.data.ip.basic


    Examples:
      | Scenario                     | ipAddress                                | statusCode |
      | IP_BASIC_POSITIVE_IPV4_Input | "206.84.238.175"                         | 200        |
      | IP_BASIC_POSITIVE_IPV6_Input | "2001:db8:3333:4444:CCCC:DDDD:EEEE:FFFF" | 200        |

  Scenario Outline: Validation of IP_BASIC Positive scenario for Valid IP_address with "High Abuse velocity","recent abuse", "bot status","VPN" -> <Scenario> | InputIP -> <ipAddress>.
    Given url requestUrl
    And def payload = read("data/" + source + "/IP_BASIC/<Scenario>.json")
    And request payload.request.ipAddress = <ipAddress>
    And headers headers
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
    Then match $.data.ip.basic contains payload.response.data.ip.basic
    And match $.data.ip.basic.abuseVelocity == "high"
    And match $.data.ip.basic.recentAbuse == true
    And match $.data.ip.basic.botStatus == true
    And match $.data.ip.basic.vpn == true


    Examples:
      | Scenario                       | ipAddress     | statusCode |
      | IP_BASIC_POSITIVE_SpecialCases | "192.168.1.1" | 200        |
