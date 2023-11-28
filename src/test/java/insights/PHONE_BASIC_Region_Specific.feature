Feature: Testing of DPI  - Phone_basic scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @PHONE_BASIC @smoke @all_data_partner
  Scenario Outline:  DPI PHONE_BASIC full package positive scenario for across regions with validation of full response - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_Region_Specific/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.phone.basic.portedHistory.portedSinceXDays = "#ignore"
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
    Then match $.data.phone.basic contains payload.response.data.phone.basic
    * match $.data.phone.basic.portedHistory contains { "portedSinceXDays": '#number'}


    Examples:
      | Scenario                                     | statusCode |
      | PHONE_BASIC_response_region_India_IN         | 200        |
      | PHONE_BASIC_response_region_UnitedStates_US  | 200        |

  @PHONE_BASIC @smoke @all_data_partner
  Scenario Outline:  DPI PHONE_BASIC full package positive scenario for across regions with validation of full response - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_Region_Specific/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.phone.basic.portedHistory.portedSinceXDays = "#ignore"
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
    Then match $.data.phone.basic contains payload.response.data.phone.basic
    * match $.data.phone.basic.portedHistory contains { "portedSinceXDays": '#null'}

    Examples:
      | Scenario                                     | statusCode |
      | PHONE_BASIC_response_region_Thailand_TH      | 200        |
      | PHONE_BASIC_response_region_Vietnam_VN       | 200        |
      | PHONE_BASIC_response_region_Indonesia_ID     | 200        |
      | PHONE_BASIC_response_region_Malaysia_MY      | 200        |
      | PHONE_BASIC_response_region_Singapore_SG     | 200        |
      | PHONE_BASIC_response_region_UnitedKingdom_GB | 200        |
      | PHONE_BASIC_response_region_Italy_IT         | 200        |
      | PHONE_BASIC_response_region_Philippines_PH   | 200        |
