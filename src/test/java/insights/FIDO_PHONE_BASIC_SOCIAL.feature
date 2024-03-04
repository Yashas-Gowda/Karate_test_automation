@FIDO_PHONE_BASIC_SOCIAL @ignore
Feature: Testing of DPI  - FIDO_PHONE_BASIC_SOCIAL scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @smokeTest @smokeTest
  Scenario Outline: Validate DPI FIDO_PHONE_BASIC_SOCIAL positive scenario <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/FIDO_PHONE_BASIC_SOCIAL/<Scenario>.json")
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
    And match $.data.phone.basic == payload.response.data.phone.basic
    And match $.data.phone.social == payload.response.data.phone.social
    And match $.meta == payload.response.meta
    And match $.errors == payload.response.errors


    Examples:
      | Scenario                                                                    | statusCode |
      | FIDO_PHONE_BASIC_SOCIAL_Positive_phoneDefaultCountryCode_MX                 | 200        |
      | FIDO_PHONE_BASIC_SOCIAL_Positive_phoneDefaultCountryCode_ID                 | 200        |
      | FIDO_PHONE_BASIC_SOCIAL_Positive_phoneDefaultCountryCode_BR                 | 200        |

