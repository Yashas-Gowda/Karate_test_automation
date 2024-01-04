@PORTED_DETAILS @ignore @PHONE_BASIC_FULL
Feature: Testing of DPI  - Phone_basic scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

#    phoneDisposable by default it is always false, but after configuration for particular tenant it will picked from data partner SEON
  @PHONE_BASIC @smoke @CTOS Tenant

  Scenario Outline:  DPI PHONE_BASIC full package positive scenario for across regions with validation of full response - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_Region_Specific/<Scenario>.json")
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
    * match $.data.phone.basic.phoneDisposable == <phoneDisposable>


    Examples:
      | Scenario                                     | statusCode | phoneDisposable |
      | PHONE_BASIC_Malaysia_MY_phoneDisposable_true | 200        | true            |
      | PHONE_BASIC_India_IN_phoneDisposable_fasle   | 200        | false           |

