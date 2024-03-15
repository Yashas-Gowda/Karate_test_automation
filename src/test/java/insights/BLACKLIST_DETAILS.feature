@BLACKLIST_DETAILS
Feature: Testing of DPI  - BLACKLIST_DETAILS scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @smokeTest @smokeTest
  Scenario Outline: Validate DPI BLACKLIST_DETAILS positive scenario with single valid input where isBlacklisted is No<Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/BLACKLIST_DETAILS/<Scenario>.json")
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
    And match $.data.blacklist == '#notnull'
    And match $.data.blacklist.details.isBlacklisted == '#present'
    Then match $.data.blacklist contains payload.response.data.blacklist

    Examples:
      | Scenario                                                                              | statusCode |
      | BLACKLIST_DETAILS_Positive_1_valid_input_phonenumber_isBlacklisted_NO                 | 200        |
      #      | BLACKLIST_DETAILS_Positive_1_valid_input_phonenumber_isBlacklisted_YES                | 200        |
      #      | BLACKLIST_DETAILS_Positive_1_valid_input_phonenumber_isBlacklisted_NEEDS_VERIFICATION | 200        |
      | BLACKLIST_DETAILS_Positive_1_valid_input_phonenumber_null                             | 200        |

  Scenario Outline: Validate DPI BLACKLIST_DETAILS Negative scenario where input is not an Indonesian number <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/BLACKLIST_DETAILS/<Scenario>.json")
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
    * match $.errors[0] == '#notnull'
    * match $.errors[0].package == "BLACKLIST_DETAILS"
    * match $.errors[0].message == "Service unavailable for country India"
    * match $.errors[0].code == "SERVICE_UNAVAILABLE_FOR_COUNTRY"
    Then match $ contains payload.response

    Examples:
      | Scenario                                                                                    | statusCode |
      | BLACKLIST_DETAILS_Negative_input_phonenumber_not_Indonesian_SERVICE_UNAVAILABLE_FOR_COUNTRY | 501        |

