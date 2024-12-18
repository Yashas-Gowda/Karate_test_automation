@AADHAAR_BASIC
Feature:Testing of DPI  - AADHAAR_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline: MOCK - Validate DPI AADHAAR_BASIC Mock with valid aadhaarNumber positive scenario -> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_BASIC/MOCK/<Scenario>.json")
    And headers headers
    # mock
    And header Content-Type = "application/vnd.monnai.mock.v2.0+json"
    #    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
    #UI auth flow
    #      And header id_token = id_token
    And request payload.request
    When method POST
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.device.deviceRecords[*].lastModified = "#ignore"
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
    Then print 'Mock details in payload',payload
    Then match $.data.aadhaar.basic contains payload.response.data.aadhaar.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                    | statusCode |
      | AADHAAR_BASIC_MOCK_request_input_aadhaarNumber_response_linkedPhoneNumber_gender_MALE_state | 200        |

  Scenario Outline: Validate DPI AADHAAR_BASIC Mock with valid aadhaarNumber positive scenario-> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_BASIC/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
    And header x-timeout = "200000"
    #UI auth flow
    #    And header id_token = id_token
    And request payload.request
    When method POST
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.device.deviceRecords[*].lastModified = "#ignore"
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
    Then print payload.response
    Then match $.data.aadhaar.basic contains payload.response.data.aadhaar.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                 | statusCode |
      | AADHAAR_BASIC_request_input_aadhaarNumber_response_linkedPhoneNumber_gender_MALE_state   | 200        |
      | AADHAAR_BASIC_request_input_aadhaarNumber_response_linkedPhoneNumber_gender_FEMALE_state | 200        |

  Scenario Outline: Validate DPI AADHAAR_BASIC Mock with valid aadhaarNumber Negative scenario-> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_BASIC/Negative/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
    And header x-timeout = "200000"
    #UI auth flow
    #    And header id_token = id_token
    And request payload.request
    When method POST
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.device.deviceRecords[*].lastModified = "#ignore"
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
      | Scenario                                                                     | statusCode |
      | AADHAAR_BASIC_Negative_input_with_after_4_digit_space_INVALID_AADHAAR_NUMBER | 400        |
      | AADHAAR_BASIC_Negative_scenarios_INVALID_AADHAAR_NUMBER_as_junk_value        | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_key_aadhaarNumber_MISSING              | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_aadhaarNumber_with_empty_string        | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_aadhaarNumber_with_space               | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_aadhaarNumber_with_number              | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_aadhaarNumber_with_boolean             | 400        |

  Scenario Outline: Validate DPI AADHAAR_BASIC Mock with valid aadhaarNumber Negative scenario-> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_BASIC/Negative/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
    And header x-timeout = "200000"
    #UI auth flow
    #    And header id_token = id_token
    And request payload.request
    When method POST
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.device.deviceRecords[*].lastModified = "#ignore"
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
      | Scenario                                                                              | statusCode |
      | AADHAAR_BASIC_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE                   | 400        |
      | AADHAAR_BASIC_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME | 400        |
      | AADHAAR_BASIC_Negative_scenarios_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY               | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_phoneDefaultCountryCode_with_empty_string       | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_phoneDefaultCountryCode_with_space              | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_phoneDefaultCountryCode_with_number             | 400        |
      | AADHAAR_BASIC_Negative_scenarios_when_phoneDefaultCountryCode_with_boolean            | 400        |


