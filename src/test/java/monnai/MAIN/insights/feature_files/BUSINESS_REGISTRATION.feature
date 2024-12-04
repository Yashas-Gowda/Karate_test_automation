@BUSINESS_REGISTRATION
Feature: Testing of DPI  - BUSINESS_REGISTRATION feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    #API auth flow
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken
  #UI auth flow
  #    * def BearerToken = "Bearer eyJraWQiOiJUU2xyaDVMTW03XC9ZYVJCNEdoUnRFQVVIdzNMeWVSV280c1hMeWthU1RKWT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfMVdiZkJPN3lGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJvcmlnaW5fanRpIjoiOTdkNTVmOGUtOGFlMi00MTRhLTgxNGUtZTFhYWVhZWJmM2VjIiwiZXZlbnRfaWQiOiI0ODgyN2I0Yy05NWEwLTQyNGItOTkxNi04OWFmYjYwNDMzYzIiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNzMyNTk4NDI4LCJleHAiOjE3MzI2ODQ4MjgsImlhdCI6MTczMjU5ODQyOSwianRpIjoiMDYzZDk1NDEtYjM3NC00MmZjLWFmODgtZTM0MWJhNDNlMjllIiwidXNlcm5hbWUiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkifQ.Ff8C_MgSpHyxOp3QyrAcEKKBAI6B7JDMwBCDn12hf5DU-kpIEPynqlUQGdwoJrae7BrJs6jTKWzFVYYYnDJoukPm9Ie9v40ZcdYnNLZox9WzHj0zxF9VEumyqOPbwfxPjIuzkdYAr0nj1sLvqnFzSqhmvQ8dkY-IWn7lKNe6H5fdqE99d4IICUdhts-y9iAU_9cKRO-8tb4vzhdKSCBPwTV5ib4ttJjAHBRtTL1d4E3vUApJ01aXW8ajsDrJ4AZ9kKEJGS1U6MhQHINN5HM6tSvRwgdNWJzgFk6xocMDBFCakGMrS6bnl1QEgkHSJIWF3JAbQMyXLEZpz53r-Viz7w"
  #    * def id_token = "eyJraWQiOiJlbGNJVGl4ZStUbmU0cUZGenU0ZlFvZmlsekl2MFdLaUU3anR4OHRsZ2ZNPSIsImFsZyI6IlJTMjU2In0.eyJhdF9oYXNoIjoiQ2FXdUFLWTJMLUJZMTFRMnJSY2EyZyIsInN1YiI6ImY0OWI5YzVlLTljNDUtNDg2MC1hN2UyLTA3MGYyZWI3YTRmOSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJyb2xlcyI6Ik1PTk5BSV9BRE1JTiIsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5hcC1zb3V0aGVhc3QtMS5hbWF6b25hd3MuY29tXC9hcC1zb3V0aGVhc3QtMV8xV2JmQk83eUYiLCJjb2duaXRvOnVzZXJuYW1lIjoiZjQ5YjljNWUtOWM0NS00ODYwLWE3ZTItMDcwZjJlYjdhNGY5IiwiZ2l2ZW5fbmFtZSI6IlNhbmpheWEiLCJvcmlnaW5fanRpIjoiOTdkNTVmOGUtOGFlMi00MTRhLTgxNGUtZTFhYWVhZWJmM2VjIiwiYXVkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJldmVudF9pZCI6IjQ4ODI3YjRjLTk1YTAtNDI0Yi05OTE2LTg5YWZiNjA0MzNjMiIsInRlbmFudE5hbWUiOiJNb25uYWkiLCJ0b2tlbl91c2UiOiJpZCIsImF1dGhfdGltZSI6MTczMjU5ODQyOCwidGVuYW50SWQiOiIwMUZaRDJWMURGTjAxSzM5UThDQllLVFhHViIsImV4cCI6MTczMjY4NDgyOCwiaWF0IjoxNzMyNTk4NDI5LCJmYW1pbHlfbmFtZSI6Ikdvd2RhciIsImp0aSI6ImFiMGIxNzg0LWY0M2MtNDdiNi05YzNlLWFiZGI5ZWM2ZDFhNyIsImVtYWlsIjoic2FuamF5YUBtb25uYWkuY29tIn0.gaG1l30QxuDdUiwGQ60VhMYnvMbyWRtlBDat7X5jzam8Kix3MjCHuYuKX_cIx98ACRTKl1SshATVTJo_tj3lohsEWWkw8Qufkg7iIV5EPg8y4dNnEfigcYb50NSk02BQkNGVy4V92fHxxwmJ7nl1mO_NSEjezIV5HcUTDc-_wuj3ZO2qXXMCNfDai63zmVvfGRd2APwKu6hcnYe_bHbgEiJuuvISQs2FcWB7mEnIimtEq2OybUM7neJAJBpW2IVxJoh8Ej5NaHIfL05RxEsLSmzDKoP6P3nNLtchJmTkzMZWwIxoP_ty-NdEwB3KYwwGZZElT5FSCwyR8-IJQRcKSQ"


  Scenario Outline: Validate DPI BUSINESS_REGISTRATION positive scenario when "type": "UDYAM_STATUS" -> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/BUSINESS_REGISTRATION/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.v1.2+json"
    And header x-timeout = "200000"
    And header Authorization = BearerToken
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
    Then match $.data.business contains payload.response.data.business
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                                | statusCode |
      | BUSINESS_REGISTRATION_request_type_UDYAM_STATUS_input_phoneNumber_response_businessName_udyamID_case_1  | 200        |
      | BUSINESS_REGISTRATION_request_type_UDYAM_STATUS_input_phoneNumber_with_id_response_businessName_udyamID | 200        |
      | BUSINESS_REGISTRATION_request_type_UDYAM_STATUS_input_phoneNumber_response_S2101_when_No_record_found   | 200        |

  Scenario Outline: Validate DPI BUSINESS_REGISTRATION positive scenario when "type": "UDYAM_DETAILS" -> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/BUSINESS_REGISTRATION/<Scenario>.json")
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
    Then match $.data.business contains payload.response.data.business
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                                   | statusCode |
      | BUSINESS_REGISTRATION_request_type_UDYAM_DETAILS_input_udyamID_response_full_case_2                        | 200        |
      | BUSINESS_REGISTRATION_request_type_UDYAM_DETAILS_input_udyamID_with_phoneNumber_empty_response_full_case_2 | 200        |
      | BUSINESS_REGISTRATION_request_type_UDYAM_DETAILS_input_phoneNumber_response_full_case_3                    | 200        |
      | BUSINESS_REGISTRATION_request_type_UDYAM_DETAILS_input_phoneNumber_with_id_response_full_case_4            | 200        |
  #  https://monnai.atlassian.net/browse/MB-7184    | BUSINESS_REGISTRATION_request_type_UDYAM_DETAILS_input_phoneNumber_response_S2101_when_No_record_found | 200        |


  #  Scenario Outline: MOCK - Validate DPI BUSINESS_REGISTRATION Mock positive scenario with single valid input -> <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/BUSINESS_REGISTRATION/<Scenario>.json")
  #    And headers headers
  #    # mock
  #    And header Content-Type = "application/vnd.monnai.mock.v2.0+json"
  ##    And header Content-Type = "application/vnd.monnai.v1.2+json"
  #    And header Authorization = BearerToken
  #    #UI auth flow
  #    And header id_token = id_token
  #    And request payload.request
  #    When method POST
  #    * set payload.response.meta.referenceId = "#ignore"
  #    * set payload.response.data.device.deviceRecords[*].lastModified = "#ignore"
  #    # cloud watch traces -start
  #    * print karate.request.headers
  #    * print karate.response.headers
  #    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
  #    * def reference_id = karate.request.headers['x-reference-id']
  #    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
  #    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
  #    # ResponseTime
  #    * print 'responseTime----->',responseTime
  #    # Request-response
  #    * print 'API Request----->',payload.request
  #    * print 'Expected Response---->',payload.response
  #    * print 'Actual Response---->',karate.pretty(response)
  #    Then status <statusCode>
  #    Then print payload.response
  #    Then match $.data.business contains payload.response.data.business
  #    * match  $.meta contains  payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #    * match  $.errors contains only deep  payload.response.errors
  #    Examples:
  #      | Scenario                                                 | statusCode |
  #      | BUSINESS_REGISTRATION_mock_response_businessName_udyamID | 200        |
  ##Not yet implemeted by dev team    | BUSINESS_REGISTRATION_mock_packageDetails_S2101_dp_response_No_record_found | 200        |
  #  #  Not yet implemeted by dev team    | BUSINESS_REGISTRATION_mock_packageDetails_S5103_dp_response_Source_Down | 200        |
  #  #  Not yet implemeted by dev team  | BUSINESS_REGISTRATION_mock_packageDetails_S5101_dp_response_ParameterMissing_or_Consentmissingorinvalid | 200        |


  Scenario Outline: Validate DPI BUSINESS_REGISTRATION positive scenario when "phoneDefaultCountryCode" other than IN -> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/BUSINESS_REGISTRATION/Negative/<Scenario>.json")
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
    * match $.meta contains only deep payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                                 | statusCode |
      | BUSINESS_REGISTRATION_when_request_phoneDefaultCountryCode_other_then_IN | 501        |


  Scenario Outline: Validate DPI BUSINESS_REGISTRATION Negative scenario -> <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/BUSINESS_REGISTRATION/Negative/<Scenario>.json")
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
    * match $.meta contains only deep payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                                                                             | statusCode |
      | BUSINESS_REGISTRATION_Negative_scenarios_INVALID_PHONE_NUMBER                                                        | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_INVALID_PHONE_NUMBER_as_junk_value                                          | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneNumber_with_empty_string                                          | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneNumber_with_space                                                 | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneNumber_with_number                                                | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneNumber_with_boolean                                               | 400        |

      | BUSINESS_REGISTRATION_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE                                          | 501        |
      | BUSINESS_REGISTRATION_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME                        | 501        |
      | BUSINESS_REGISTRATION_Negative_scenarios_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY                                      | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_empty_string                              | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_space                                     | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_number                                    | 501        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_boolean                                   | 501        |

      #  https://monnai.atlassian.net/browse/MB-7196    | BUSINESS_REGISTRATION_Negative_scenarios_when_type_is_invalid                                                        | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_space                                     | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_number                                    | 501        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_boolean                                   | 501        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_empty_string                              | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_when_phoneDefaultCountryCode_with_space                                     | 400        |

      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_DETAILS_when_both_phonenumber_id_missing                     | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_STATUS_when_both_phonenumber_phoneDefaultCountryCode_missing | 400        |

      #   https://monnai.atlassian.net/browse/MB-7195  https://monnai.atlassian.net/browse/MB-7196
      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_DETAILS_when_id_is_invalid                                   | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_DETAILS_when_id_is_junk                                      | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_DETAILS_when_id_is_abc                                       | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_DETAILS_when_id_is_number                                    | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_DETAILS_when_id_is_boolean                                   | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_DETAILS_when_id_is_space                                     | 400        |
      | BUSINESS_REGISTRATION_Negative_scenarios_for_type_UDYAM_DETAILS_when_id_is_empty_string                              | 400        |
