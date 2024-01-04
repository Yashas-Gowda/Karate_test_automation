@PORTED_DETAILS @PHONE_BASIC_FULL
Feature: Testing of DPI  - Phone_basic scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  @PHONE_BASIC @phoneNumber
  Scenario Outline:  DPI PHONE_BASIC full package positive scenario Validation for cleansingFlag_false and PhoneNumber added along with +91- <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_with_cleansingFlag_eventType/<Scenario>.json")
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
      | Scenario                                                                | statusCode |
      | PHONE_BASIC_response_region_IN_phoneNumber_with_+91_cleansingFlag_false | 200        |

  @PHONE_BASIC @eventType
  Scenario Outline:  DPI PHONE_BASIC package positive scenario Validation for cleansingFlag_false and eventType { ACCOUNT_CREATION,ACCOUNT_TRANSACTION,ACCOUNT_LOGIN,ACCOUNT_UPDATE,ACCOUNT_DELETE } <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_with_cleansingFlag_eventType/<Scenario>.json")
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
    * match $.errors == '#[0]'

    Examples:
      | Scenario                                                                         | statusCode |
      | PHONE_BASIC_response_region_IN_cleansingFlag_false_eventType_ACCOUNT_CREATION    | 200        |
      | PHONE_BASIC_response_region_IN_cleansingFlag_false_eventType_ACCOUNT_TRANSACTION | 200        |
      | PHONE_BASIC_response_region_IN_cleansingFlag_false_eventType_ACCOUNT_LOGIN       | 200        |
      | PHONE_BASIC_response_region_IN_cleansingFlag_false_eventType_ACCOUNT_UPDATE      | 200        |
      | PHONE_BASIC_response_region_IN_cleansingFlag_false_eventType_ACCOUNT_DELETE      | 200        |

  @PHONE_BASIC @Negative
  Scenario Outline:  DPI PHONE_BASIC Negative scenario for validation of  individual eventType  - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_with_cleansingFlag_eventType/<Scenario>.json")
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
    And match $.data == '#null'
    And match $.meta == '#null'
    And match $.errors[0].package == <package>
    And match $.errors[0].message == <message>
    And match $.errors[0].code == "<code>"
    And match $.errors[0].type == "<type>"

    Examples:
      | Scenario                                                | statusCode | package | message              | code               | type          |
      | PHONE_BASIC_Negative_scenarios_INVALID_EVENT_TYPE       | 400        | '#null' | "Invalid event type" | INVALID_EVENT_TYPE | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_MISSING_EVENT_TYPE_KEY   | 400        | '#null' | "Missing event type" | MISSING_EVENT_TYPE | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_MISSING_EVENT_TYPE_VALUE | 400        | '#null' | "Missing event type" | MISSING_EVENT_TYPE | INVALID_INPUT |

  @PHONE_BASIC @Negative
  Scenario Outline:  DPI PHONE_BASIC Negative scenario for validation of  individual PhoneNumber and countrycode separate - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_with_cleansingFlag_eventType/<Scenario>.json")
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
    And match $.data == '#null'

    And match $.meta.inputPhoneNumber == "##string"
    And match $.meta.cleansedPhoneNumber == "##string"
    And match $.meta.referenceId == "#string"
    And match $.meta.requestedPackages[0] == "PHONE_BASIC"


    And match $.errors[0].package == "<package>"
    And match $.errors[0].message == <message>
    And match $.errors[0].code == "<code>"
    And match $.errors[0].type == "<type>"

    Examples:
      | Scenario                                                                                    | statusCode | package     | message                            | code                 | type          |
      | PHONE_BASIC_Negative_scenarios_Phonenumber_with_countrycode_appended_cleansingFlag_false    | 400        | PHONE_BASIC | "Invalid Phone Number"             | INVALID_PHONE_NUMBER | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_Phonenumber_without_countrycode_appended_cleansingFlag_false | 400        | PHONE_BASIC | "Invalid Phone Number"             | INVALID_PHONE_NUMBER | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_Invalid_Phonenumber_cleansingFlag_false                      | 400        | PHONE_BASIC | "Invalid Phone Number"             | INVALID_PHONE_NUMBER | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_INVALID_PHONE_NUMBER_as_junk_value_cleansingFlag_false       | 400        | PHONE_BASIC | "Invalid Phone Number"             | INVALID_PHONE_NUMBER | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_MISSING_PHONE_NUMBER_VALUE_cleansingFlag_false               | 400        | PHONE_BASIC | "PhoneNumber cannot be blank/null" | MISSING_PHONE_NUMBER | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_MISSING_PHONE_NUMBER_KEY_cleansingFlag_false                 | 400        | PHONE_BASIC | "PhoneNumber cannot be blank/null" | MISSING_PHONE_NUMBER | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_PHONE_NUMBER_as_NotString_cleansingFlag_false                | 400        | PHONE_BASIC | "Invalid Phone Number"             | INVALID_PHONE_NUMBER | INVALID_INPUT |
#   https://monnai.atlassian.net/browse/MB-2368
#      | PHONE_BASIC_Negative_scenarios_Valid_PHONE_NUMBER_cleansingFlag_null                        | 400        | PHONE_BASIC | "Invalid Cleansing Flag"             | INVALID_CLEANSING_FLAG | INVALID_INPUT |
#  https://monnai.atlassian.net/browse/MB-2368
#      | PHONE_BASIC_Negative_scenarios_without_Mandatory_cleansingFlag_Key                        | 400        | PHONE_BASIC | "Invalid Cleansing Flag"             | INVALID_CLEANSING_FLAG | INVALID_INPUT |


