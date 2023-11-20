@debug
Feature: Testing of DPI  - DEVICE_DETAILS feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario Outline: Validate DPI DEVICE_DETAILS positive scenario with single valid input <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/DEVICE_DETAILS/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    When method POST
    * set payload.response.meta.referenceId = "#ignore"
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
    Then print payload.response
    Then match $.data.device contains payload.response.data.device

    Examples:
      | Scenario                              | statusCode |
      | Device_Details_Positive_1_valid_input | 200        |

  Scenario Outline: Validate DPI DEVICE_DETAILS Positive scenario with Multiple valid input(TWO devices) - Device_Details_Possitive_Multiple(TWO)_valid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Possitive_Multiple(TWO)_valid_input.json'
    And def payload = read("data/" + source + "/DEVICE_DETAILS/"+ Scenario)
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status 200
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
    Then match $.data.device contains payload.response.data.device

    Then print payload.response
    # [2] - validate the number of deviceRecords
    And match payload.response.data.device.deviceRecords == '#[2]'

    Examples:
      | deviceIds                                                                       |
      | ["97867bc8-0cdc-4072-86c4-2cc7e9d05616","1db61125-297f-4544-abad-eae8a56ecd90"] |

  Scenario Outline: Validate DPI DEVICE_DETAILS positive scenario with Multiple valid input(10 devices) - Device_Details_Possitive_Multiple_MAX(10)_valid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Possitive_Multiple_MAX(10)_valid_input.json'
    And def payload = read("data/" + source + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
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
    Then status 200
    Then match $.data.device contains payload.response.data.device
    Then match payload.response.data.device.deviceRecords == '#[10]'

    Examples:
      | deviceIds                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | ["1db61125-297f-4544-abad-eae8a56ecd90","1db61125-297f-4544-abad-eae8a56ecd90","880ff4be-1bcb-453c-a823-5a35c8cd9642","e84d8f43-d986-45bc-a529-ed9d494dac01","9723ec2b-17e2-43da-86c6-76f30a4c4f39","bc42981d-6231-4834-a076-83a83478dbe8","702f643d-8c6f-4150-8d6a-6851ab58be09","de2aa48d-7654-46b3-957d-11bb1b206c59","9cb44865-1d74-4744-b056-d7e71070da3c","0b45e826-d875-4d7f-8b8d-30388ebf40d2","0bb3f398-184d-43a1-aea6-637521dcf368"] |


#      | "3342b21d-6ba2-4294-b808-f9612b24fed6" |
#      | "d498b340-25fc-4cf3-a927-c9a37f885841" |
#      | "8d182c92-781c-441f-a179-4dcdac151bb3" |
#      | "345d1cd3-a754-4556-800f-65fb37ccce66" |
#      | "2dd3825c-22b8-4efb-97f0-f1cfdeda4641" |
#      | "64aa8f98-9d60-4d72-a178-b06034cda47a" |
#      | "7dfdd56e-e795-4cfa-99d6-d548aaf55866" |
#      | "1db61125-297f-4544-abad-eae8a56ecd90" |
#      | "cab22197-414b-4ceb-9517-183774766d00" |
#      | "a439a0c4-343b-41f3-b62b-64b1be2e3a7f" |


  Scenario Outline: Validate DPI DEVICE_DETAILS Negitive scenario with Multiple valid input(11 devices) - Device_Details_Negitive_Multiple_(MAX+1)_11_valid_input.json - <deviceIds>
    Given url requestUrl
    * def Scenario = 'Device_Details_Negitive_Multiple_(MAX+1)_11_valid_input.json'
    And def payload = read("data/" + source + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then print payload.response
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
    Then status 400
    And match $.errors[0].message == "Number of devices Ids are more than 10"
    And match $.errors[0].code == "NUMBER_OF_DEVICE_IDS_EXCEEDED"
    And match $.errors[0].package == "DEVICE_DETAILS"
    Then match $ contains payload.response

    Examples:
      | deviceIds                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
#    old  | ["3342b21d-6ba2-4294-b808-f9612b24fed6","d498b340-25fc-4cf3-a927-c9a37f885841","8d182c92-781c-441f-a179-4dcdac151bb3","345d1cd3-a754-4556-800f-65fb37ccce66","2dd3825c-22b8-4efb-97f0-f1cfdeda4641","64aa8f98-9d60-4d72-a178-b06034cda47a","7dfdd56e-e795-4cfa-99d6-d548aaf55866","1db61125-297f-4544-abad-eae8a56ecd90","cab22197-414b-4ceb-9517-183774766d00","a439a0c4-343b-41f3-b62b-64b1be2e3a7f","c8ce79ec-dd48-4ad0-8a7b-6637decd91b5"]                                        |
      | ["97867bc8-0cdc-4072-86c4-2cc7e9d05616","1db61125-297f-4544-abad-eae8a56ecd90","1db61125-297f-4544-abad-eae8a56ecd90","880ff4be-1bcb-453c-a823-5a35c8cd9642","e84d8f43-d986-45bc-a529-ed9d494dac01","9723ec2b-17e2-43da-86c6-76f30a4c4f39","bc42981d-6231-4834-a076-83a83478dbe8","702f643d-8c6f-4150-8d6a-6851ab58be09","de2aa48d-7654-46b3-957d-11bb1b206c59","9cb44865-1d74-4744-b056-d7e71070da3c","0b45e826-d875-4d7f-8b8d-30388ebf40d2","0bb3f398-184d-43a1-aea6-637521dcf368"] |


#      | "3342b21d-6ba2-4294-b808-f9612b24fed6" |
#      | "d498b340-25fc-4cf3-a927-c9a37f885841" |
#      | "8d182c92-781c-441f-a179-4dcdac151bb3" |
#      | "345d1cd3-a754-4556-800f-65fb37ccce66" |
#      | "2dd3825c-22b8-4efb-97f0-f1cfdeda4641" |
#      | "64aa8f98-9d60-4d72-a178-b06034cda47a" |
#      | "7dfdd56e-e795-4cfa-99d6-d548aaf55866" |
#      | "8d182c92-781c-441f-a179-4dcdac151bb9" |
#      | "1db61125-297f-4544-abad-eae8a56ecd90" |
#      | "cab22197-414b-4ceb-9517-183774766d00" |
#      | "a439a0c4-343b-41f3-b62b-64b1be2e3a7f" |
#      | "c8ce79ec-dd48-4ad0-8a7b-6637decd91b5" |

  Scenario Outline: Validation of DEVICE_DETAILS Package Negative scenarios with Invalid inputs - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/DEVICE_DETAILS/<Scenario>.json")
    And request payload.request.deviceIds = <deviceIds>
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
    And match $.errors[0].message == "Device Ids cannot blank/null"
    And match $.errors[0].code == "MISSING_DEVICE_IDS"
    And match $.errors[0].package == "DEVICE_DETAILS"

    Examples: # Multiple invalid inputs
      | Scenario                                 | statusCode | deviceIds      |
      | Device_Details_Negitive_withInvalidInput | 400        | null           |
      | Device_Details_Negitive_withInvalidInput | 400        | []             |
      | Device_Details_Negitive_withInvalidInput | 400        | [null]         |
      | Device_Details_Negitive_withInvalidInput | 400        | [null,null]    |
      | Device_Details_Negitive_withInvalidInput | 400        | [""]           |
      | Device_Details_Negitive_withInvalidInput | 400        | ["   ",""," "] |
      | Device_Details_Negitive_withInvalidInput | 400        | ["","",""]     |


  Scenario Outline: Validation of DEVICE_DETAILS Package Negative scenarios with Invalid inputs - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/DEVICE_DETAILS/<Scenario>.json")
    And request payload.request.deviceIds = <deviceIds>
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
    And match $.errors[0].message == "Device Ids cannot blank/null"
    And match $.errors[0].code == "MISSING_DEVICE_IDS"
    And match $.errors[0].package == "DEVICE_DETAILS"

    Examples:
      | Scenario                                 | statusCode | deviceIds |
      | Device_Details_Negitive_withInvalidInput | 400        | null      |


#Bug raised https://monnai.atlassian.net/browse/MB-1314


  Scenario Outline: Validation of DEVICE_DETAILS Package Positive with at least one valid deviceId attribute in request -Bug-MB 1314 - Device_Details_Positive_atleast_one_valid_input_with invalid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Positive_atleast_one_valid_input_with invalid_input.json'
    And def payload = read("data/" + source + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
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
    Then status 200
    Then match $.data.device contains payload.response.data.device
    Then print payload.request
    Then print payload.response
    And match payload.response.data.device == "#notnull"
    And match payload.response.data.device.errors != '#[0]'


    Examples:
      | deviceIds                                                  |
      | ["3342b21d-6ba2-4294-b808-f9612b24fed6","  ",null,"",null] |


  Scenario Outline: Validate DPI DEVICE_DETAILS Validation of DEVICE_DETAILS Package with null/empty countryCode inputs - Device_Details_Negative_CountryCode_Empty&null_input.json - <countryCode>
    Given url requestUrl
    * def Scenario = 'Device_Details_Negative_CountryCode_Empty&null_input.json'
    And def payload = read("data/" + source + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.countryCode = <countryCode>
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
    Then status 400
    And match $.errors[0].message == "Missing Country Code"
    And match $.errors[0].code == "MISSING_COUNTRY_CODE"
    And match $.errors[0].package == "DEVICE_DETAILS"
    Then match $ contains payload.response

    Examples:
      | countryCode |
      | null        |
      | ""          |
      | "  "        |

  Scenario Outline: Validate DPI DEVICE_DETAILS Validation of DEVICE_DETAILS Package with Invalid countryCode inputs - Device_Details_Negative_CountryCode_invalid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Negative_CountryCode_invalid_input.json'
    And def payload = read("data/" + source + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.countryCode = <countryCode>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then print payload.response
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
    Then status 400
    And match $.errors[0].message == "Invalid country code"
    And match $.errors[0].code == "INVALID_COUNTRY_CODE"
    And match $.errors[0].package == "DEVICE_DETAILS"
    Then match $ contains payload.response

    Examples:
      | countryCode |
      | "idd"       |
      | "123"       |
      | "ab1"       |


  Scenario Outline: Validate DPI DEVICE_DETAILS Validation of DEVICE_DETAILS Package with INVALID Device_id & CountryCode inputs - Device_Details_Negative_CountryCode_invalid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Negative_InvalidCountryCode_InvalidDeviceid_input.json'
    And def payload = read("data/" + source + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.countryCode = <countryCode>
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then print payload.response
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
    Then status 400
    And match $.errors[*].message contains only ["Device Id Format is invalid/incorrect","Invalid country code"]
    And match $.errors[*].code contains only ["INVALID_COUNTRY_CODE","INVALID_DEVICE_ID"]
    And match $.errors[*].package contains any ["DEVICE_DETAILS"]
#    And match $.errors[*].message == ["Device Id Format is invalid/incorrect"]
#    And match $.errors[*].code == ["INVALID_DEVICE_ID"]
#    And match $.errors[*].package == ["DEVICE_DETAILS"]
    Then match $.meta contains payload.response.meta

    Examples:
      | countryCode | deviceIds  |
      | "idd"       | ["abc" ]   |
      | "123"       | ["123"]    |
      | "ab1"       | ["123abc"] |

  Scenario Outline: Validate DPI DEVICE_DETAILS Validation of DEVICE_DETAILS Package with INVALID Device_id & CountryCode inputs - Device_Details_Negitive_InvalidDeviceid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Negitive_InvalidDeviceid_input.json'
    And def payload = read("data/" + source + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then print payload.response
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
    Then status 400
    And match $.errors[0].message == "Device Id Format is invalid/incorrect"
    And match $.errors[0].code == "INVALID_DEVICE_ID"
    And match $.errors[0].package == "DEVICE_DETAILS"
    Then match $ contains payload.response
    Examples:
      | deviceIds  |
      | ["abc" ]   |
      | ["123"]    |
      | ["123abc"] |

    
#valid device id
#  "97867bc8-0cdc-4072-86c4-2cc7e9d05616",
#  "1db61125-297f-4544-abad-eae8a56ecd90",
#  "1db61125-297f-4544-abad-eae8a56ecd90",
#  880ff4be-1bcb-453c-a823-5a35c8cd9642
#  e84d8f43-d986-45bc-a529-ed9d494dac01
#  9723ec2b-17e2-43da-86c6-76f30a4c4f39
#
#  bc42981d-6231-4834-a076-83a83478dbe8
#  702f643d-8c6f-4150-8d6a-6851ab58be09
#  de2aa48d-7654-46b3-957d-11bb1b206c59
#  9cb44865-1d74-4744-b056-d7e71070da3c
#  0b45e826-d875-4d7f-8b8d-30388ebf40d2
#
#  0bb3f398-184d-43a1-aea6-637521dcf368
#
#
# 11 device id - ["97867bc8-0cdc-4072-86c4-2cc7e9d05616","1db61125-297f-4544-abad-eae8a56ecd90","1db61125-297f-4544-abad-eae8a56ecd90","880ff4be-1bcb-453c-a823-5a35c8cd9642","e84d8f43-d986-45bc-a529-ed9d494dac01","9723ec2b-17e2-43da-86c6-76f30a4c4f39","bc42981d-6231-4834-a076-83a83478dbe8","702f643d-8c6f-4150-8d6a-6851ab58be09","de2aa48d-7654-46b3-957d-11bb1b206c59","9cb44865-1d74-4744-b056-d7e71070da3c","0b45e826-d875-4d7f-8b8d-30388ebf40d2","0bb3f398-184d-43a1-aea6-637521dcf368"]

# 10 device id - ["1db61125-297f-4544-abad-eae8a56ecd90","1db61125-297f-4544-abad-eae8a56ecd90","880ff4be-1bcb-453c-a823-5a35c8cd9642","e84d8f43-d986-45bc-a529-ed9d494dac01","9723ec2b-17e2-43da-86c6-76f30a4c4f39","bc42981d-6231-4834-a076-83a83478dbe8","702f643d-8c6f-4150-8d6a-6851ab58be09","de2aa48d-7654-46b3-957d-11bb1b206c59","9cb44865-1d74-4744-b056-d7e71070da3c","0b45e826-d875-4d7f-8b8d-30388ebf40d2","0bb3f398-184d-43a1-aea6-637521dcf368"]

