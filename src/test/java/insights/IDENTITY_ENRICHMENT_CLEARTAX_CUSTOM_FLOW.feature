@ignore
Feature: Testing of DPI  - IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @smokeTest
  Scenario Outline:  DPI IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW Scenarios for region India - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW/<Scenario>.json")
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
    And match $.data.identity.correlation == '#null'
    And match $.data.identity.enrichmentPlus == '#null'
    Then match $.data.identity.enrichment contains only deep payload.response.data.identity.enrichment
    And match $.meta == payload.response.meta

    Examples:
      | Scenario                                                                              | statusCode |
      | IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW_identityDetails_pan                          | 200        |
      | IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW_identityDetails_passport_aadhaar_pan_voterId | 200        |
      | IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW_identityDetails_aadhaar_pan                  | 200        |
      | IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW_identityDetails_passport_pan                 | 200        |


  Scenario Outline:  DPI IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW Scenarios for when dp is not returning the response- <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW/<Scenario>.json")
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
    And match $.data.identity == payload.response.data.identity
    And match $.meta == payload.response.meta

    Examples:
      | Scenario                                                                                        | statusCode |
      | IDENTITY_ENRICHMENT_CLEARTAX_CUSTOM_FLOW_enrichment_null_when_Dp_gives_error_Customer_not_found | 200        |
