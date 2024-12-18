@PHONE_BASIC_FULL
Feature: Testing of DPI  - Multiple_Insights_Package_Negative_Validations scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline:  DPI Identity Multiple_Insights_Package_Negative_Validations Scenarios of phone validations - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/Multiple_Insights_Package_Negative_Validations/<Scenario>.json")
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
    * match $.meta contains only deep  payload.response.meta
    * match $.errors contains only deep  payload.response.errors

    Examples:
      | Scenario                                                                               | statusCode |
      | Insights_phone_related_packages_request_with_phoneDefaultCountryCode_value_null        | 400        |
      | Insights_phone_related_packages_request_with_phoneDefaultCountryCode_value_emptyString | 400        |
      | Insights_phone_related_packages_request_without_phoneDefaultCountryCode_key            | 400        |
      | Insights_phone_related_packages_request_with_phoneDefaultCountryCode_value_abc         | 400        |
      | Insights_phone_related_packages_request_with_phoneDefaultCountryCode_value_123         | 400        |
      | Insights_phone_related_packages_request_with_phoneDefaultCountryCode_value_abc123      | 400        |
      | Insights_phone_related_packages_request_with_phoneDefaultCountryCode_value_in          | 400        |
      | Insights_phone_related_packages_request_with_phoneDefaultCountryCode_value_INDIA       | 400        |

      | Insights_phone_related_packages_request_with_phoneNumber_value_null                    | 400        |
      | Insights_phone_related_packages_request_with_phoneNumber_value_emptyString             | 400        |
      | Insights_phone_related_packages_request_without_phoneNumber_key                        | 400        |
      | Insights_phone_related_packages_request_with_phoneNumber_value_123                     | 400        |
      | Insights_phone_related_packages_request_with_phoneNumber_value_abc                     | 400        |
      | Insights_phone_related_packages_request_with_phoneNumber_value_abc123                  | 400        |

  Scenario Outline:  DPI Identity Multiple_Insights_Package_Negative_Validations Scenarios of email validations - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/Multiple_Insights_Package_Negative_Validations/<Scenario>.json")
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
    * match $.meta contains only deep  payload.response.meta
    * match $.errors contains only deep  payload.response.errors

    Examples:
      | Scenario                                                             | statusCode |
      | Insights_phone_related_packages_request_with_email_value_null        | 400        |
      | Insights_phone_related_packages_request_with_email_value_emptyString | 400        |
      | Insights_phone_related_packages_request_with_email_value_abc         | 400        |
      | Insights_phone_related_packages_request_with_email_value_123         | 400        |
      | Insights_phone_related_packages_request_with_email_value_abc123      | 400        |
      | Insights_phone_related_packages_request_without_email_key            | 400        |

  Scenario Outline:  DPI Identity Multiple_Insights_Package_Negative_Validations Scenarios of phone and email validations - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/Multiple_Insights_Package_Negative_Validations/<Scenario>.json")
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
    * match $.meta contains only deep  payload.response.meta
    * match $.errors contains only deep  payload.response.errors

    Examples:
      | Scenario                                                                                      | statusCode |
      | Insights_phone_email_related_packages_request_with_phoneDefaultCountryCode_value_null         | 400        |
      | Insights_phone_email_related_packages_request_with_phoneDefaultCountryCode_value_empty_string | 400        |
      | Insights_phone_email_related_packages_request_with_phoneDefaultCountryCode_key_missing        | 400        |