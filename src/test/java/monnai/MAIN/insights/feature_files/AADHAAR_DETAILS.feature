@AADHAAR_DETAILS
Feature:Testing of DPI  - AADHAAR_DETAILS feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario Outline: MOCK - Validate DPI AADHAAR_DETAILS Mock with "type": "REQUEST_CONSENT" positive scenario -> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_DETAILS/MOCK/<Scenario>.json")
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
    Then match $.data.aadhaar.details contains payload.response.data.aadhaar.details
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                         | statusCode |
      | AADHAAR_DETAILS_mock_type_REQUEST_CONSENT_response_M5101_with_requestReferenceId | 200        |


  Scenario Outline: MOCK - Validate DPI AADHAAR_DETAILS Mock with  "type": "SUBMIT_CONSENT" positive scenario -> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_DETAILS/MOCK/<Scenario>.json")
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
    Then match $.data.aadhaar.details contains payload.response.data.aadhaar.details
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                                                                                   | statusCode |
      | AADHAAR_DETAILS_mock_type_SUBMIT_CONSENT_input_mandatory_requestReferenceId_otp_shareCode_includeAadhaarXMLFile_true_response_with_photo_base64_xml_base64 | 200        |
      | AADHAAR_DETAILS_mock_type_SUBMIT_CONSENT_input_mandatory_requestReferenceId_otp_shareCode_includeAadhaarXMLFile_false_response_with_photo_base64           | 200        |


  Scenario Outline:Validate DPI AADHAAR_DETAILS Mock with type data point Negative scenario> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_DETAILS/Negative/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
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
      | Scenario                                                           | statusCode |
      | AADHAAR_DETAILS_Negative_scenario_input_type_invalid               | 400        |
      | AADHAAR_DETAILS_Negative_scenario_input_type_invalid_as_junk_value | 400        |
      | AADHAAR_DETAILS_Negative_scenario_input_type_with_empty_string     | 400        |
      | AADHAAR_DETAILS_Negative_scenario_input_type_with_space            | 400        |
      | AADHAAR_DETAILS_Negative_scenario_input_type_with_number           | 400        |
      | AADHAAR_DETAILS_Negative_scenario_input_type_with_boolean          | 400        |

  Scenario Outline:Validate DPI AADHAAR_DETAILS Mock with type_REQUEST_CONSENT Negative scenario> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_DETAILS/Negative/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
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
      | Scenario                                                                                            | statusCode |
      | AADHAAR_DETAILS_Negative_type_REQUEST_CONSENT_input_with_after_4_digit_space_INVALID_AADHAAR_NUMBER | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_INVALID_AADHAAR_NUMBER_as_junk_value        | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_key_aadhaarNumber_MISSING              | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_aadhaarNumber_with_empty_string        | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_aadhaarNumber_with_space               | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_aadhaarNumber_with_number              | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_aadhaarNumber_with_boolean             | 400        |

  Scenario Outline: Validate DPI AADHAAR_DETAILS Mock with type_REQUEST_CONSENT Negative scenario-> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_DETAILS/Negative/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
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
      | Scenario                                                                                                     | statusCode |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_INVALID_PHONE_DEFAULT_COUNTRY_CODE                   | 501        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME | 501        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY               | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_phoneDefaultCountryCode_with_empty_string       | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_phoneDefaultCountryCode_with_space              | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_phoneDefaultCountryCode_with_number             | 501        |
      | AADHAAR_DETAILS_Negative_scenarios_type_REQUEST_CONSENT_when_phoneDefaultCountryCode_with_boolean            | 501        |

  Scenario Outline:Validate DPI AADHAAR_DETAILS Mock with type_SUBMIT_CONSENT Negative scenario> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_DETAILS/Negative/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
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
      | Scenario                                                                                                         | statusCode |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_key_requestReferenceId_otp_shareCode_invalid         | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_key_requestReferenceId_otp_shareCode_invalid_as_juck | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_key_requestReferenceId_otp_shareCode_MISSING         | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_aadhaarNumber_otp_shareCode_with_empty_string        | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_aadhaarNumber_otp_shareCode_with_space               | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_aadhaarNumber_otp_shareCode_with_number              | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_aadhaarNumber_otp_shareCode_with_boolean             | 400        |

  Scenario Outline: Validate DPI AADHAAR_DETAILS Mock with type_SUBMIT_CONSENT Negative scenario -> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AADHAAR_DETAILS/Negative/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header Authorization = BearerToken
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
      | Scenario                                                                                                    | statusCode |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_INVALID_PHONE_DEFAULT_COUNTRY_CODE                   | 501        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME | 501        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY               | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_phoneDefaultCountryCode_with_empty_string       | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_phoneDefaultCountryCode_with_space              | 400        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_phoneDefaultCountryCode_with_number             | 501        |
      | AADHAAR_DETAILS_Negative_scenarios_type_SUBMIT_CONSENT_when_phoneDefaultCountryCode_with_boolean            | 501        |



