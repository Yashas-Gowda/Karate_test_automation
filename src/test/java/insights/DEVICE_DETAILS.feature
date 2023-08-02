@debug
Feature: Testing of DPI  - DEVICE_DETAILS feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'


  Scenario Outline: Validate DPI DEVICE_DETAILS possitive scenario with single valid input <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/DEVICE_DETAILS/<Scenario>.json")
    And headers headers
    And request payload.request
    When method POST
    * set payload.response.meta.referenceId = "#ignore"
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then print payload.response
    Then match $ contains payload.response

    Examples:
      | Scenario                               | statusCode |
      | Device_Details_Possitive_1_valid_input | 200        |

  @smokeTest
  Scenario Outline: Validate DPI DEVICE_DETAILS possitive scenario with Multiple valid input(TWO devices) - Device_Details_Possitive_Multiple(TWO)_valid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Possitive_Multiple(TWO)_valid_input.json'
    And def payload = read("data/" + env + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status 200
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then match $ contains payload.response

    Then print payload.response
    # [2] - validate the number of deviceRecords
    And match payload.response.data.device.deviceRecords == '#[2]'

    Examples:
      | deviceIds                                                                       |
      | ["345d1cd3-a754-4556-800f-65fb37ccce66","8d182c92-781c-441f-a179-4dcdac151bb3"] |


  Scenario Outline: Validate DPI DEVICE_DETAILS possitive scenario with Multiple valid input(10 devices) - Device_Details_Possitive_Multiple_MAX(10)_valid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Possitive_Multiple_MAX(10)_valid_input.json'
    And def payload = read("data/" + env + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status 200
    Then match $ contains payload.response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then print payload.response
    Then match payload.response.data.device.deviceRecords == '#[10]'
    Examples:
      | deviceIds                                                                                                                                                                                                                                                                                                                                                                                               |
      | ["3342b21d-6ba2-4294-b808-f9612b24fed6","d498b340-25fc-4cf3-a927-c9a37f885841","8d182c92-781c-441f-a179-4dcdac151bb3","345d1cd3-a754-4556-800f-65fb37ccce66","2dd3825c-22b8-4efb-97f0-f1cfdeda4641","64aa8f98-9d60-4d72-a178-b06034cda47a","7dfdd56e-e795-4cfa-99d6-d548aaf55866","1db61125-297f-4544-abad-eae8a56ecd90","cab22197-414b-4ceb-9517-183774766d00","a439a0c4-343b-41f3-b62b-64b1be2e3a7f"] |


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
    And def payload = read("data/" + env + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then print payload.response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status 400
    And match $.errors[0].message == "Number of devices Ids are more than 10"
    And match $.errors[0].code == "NUMBER_OF_DEVICE_IDS_EXCEEDED"
    And match $.errors[0].package == "DEVICE_DETAILS"
    Then match $ contains payload.response
    Examples:
      | deviceIds                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | ["3342b21d-6ba2-4294-b808-f9612b24fed6","d498b340-25fc-4cf3-a927-c9a37f885841","8d182c92-781c-441f-a179-4dcdac151bb3","345d1cd3-a754-4556-800f-65fb37ccce66","2dd3825c-22b8-4efb-97f0-f1cfdeda4641","64aa8f98-9d60-4d72-a178-b06034cda47a","7dfdd56e-e795-4cfa-99d6-d548aaf55866","1db61125-297f-4544-abad-eae8a56ecd90","cab22197-414b-4ceb-9517-183774766d00","a439a0c4-343b-41f3-b62b-64b1be2e3a7f","c8ce79ec-dd48-4ad0-8a7b-6637decd91b5"] |



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

  Scenario Outline: Validation of DEVICE_DETAILS Package Negitive senarios with Invalid inputs - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/DEVICE_DETAILS/<Scenario>.json")
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
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


  Scenario Outline: Validation of DEVICE_DETAILS Package Negitive senarios with Invalid inputs - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/DEVICE_DETAILS/<Scenario>.json")
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
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
    And def payload = read("data/" + env + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status 200
    Then match $ contains payload.response
    Then print payload.request
    Then print payload.response
    And match payload.response.data.device == "#notnull"
    And match payload.response.data.device.errors != '#[0]'

    Examples:
      | deviceIds                                                  |
      | ["3342b21d-6ba2-4294-b808-f9612b24fed6","  ",null,"",null] |


  Scenario Outline: Validate DPI DEVICE_DETAILS Validation of DEVICE_DETAILS Package with null/empty countryCode inputs - Device_Details_Negitive_CountryCode_Empty&null_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Negitive_CountryCode_Empty&null_input.json'
    And def payload = read("data/" + env + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.countryCode = <countryCode>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * print payload.request
    * print payload.response
    * print karate.pretty(response)

    When method POST
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

  Scenario Outline: Validate DPI DEVICE_DETAILS Validation of DEVICE_DETAILS Package with Invalid countryCode inputs - Device_Details_Negitive_CountryCode_invalid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Negitive_CountryCode_invalid_input.json'
    And def payload = read("data/" + env + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.countryCode = <countryCode>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then print payload.response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
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


  Scenario Outline: Validate DPI DEVICE_DETAILS Validation of DEVICE_DETAILS Package with INVALID Device_id & CountryCode inputs - Device_Details_Negitive_CountryCode_invalid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Negitive_InvalidCountryCode_InvalidDeviceid_input.json'
    And def payload = read("data/" + env + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.countryCode = <countryCode>
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then print payload.response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status 400
    And match $.errors[*].message contains only ["Device Id Format is invalid/incorrect","Invalid country code"]
    And match $.errors[*].code contains only ["INVALID_COUNTRY_CODE","INVALID_DEVICE_ID"]
    And match $.errors[*].package contains any ["DEVICE_DETAILS"]
#    And match $.errors[*].message == ["Device Id Format is invalid/incorrect"]
#    And match $.errors[*].code == ["INVALID_DEVICE_ID"]
#    And match $.errors[*].package == ["DEVICE_DETAILS"]
    Then match $ contains any payload.response
    Examples:
      | countryCode | deviceIds  |
      | "idd"       | ["abc" ]   |
      | "123"       | ["123"]    |
      | "ab1"       | ["123abc"] |

  Scenario Outline: Validate DPI DEVICE_DETAILS Validation of DEVICE_DETAILS Package with INVALID Device_id & CountryCode inputs - Device_Details_Negitive_InvalidDeviceid_input.json
    Given url requestUrl
    * def Scenario = 'Device_Details_Negitive_InvalidDeviceid_input.json'
    And def payload = read("data/" + env + "/DEVICE_DETAILS/" + Scenario)
    And request payload.request.deviceIds = <deviceIds>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then print payload.response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status 400
    And match $.errors[0].message == "Device Id Format is invalid/incorrect"
    And match $.errors[0].code == "INVALID_DEVICE_ID"
    And match $.errors[0].package == "DEVICE_DETAILS"
    Examples:
      | deviceIds  |
      | ["abc" ]   |
      | ["123"]    |
      | ["123abc"] |

    

