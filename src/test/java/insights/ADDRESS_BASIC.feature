@debug
Feature: Testing of DPI  - ADDRESS_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @smokeTest @smokeTest
  Scenario Outline: Validate DPI ADDRESS_BASIC positive scenarios with all input fields(q-addressLine1-8,qq-postal code,city,state,country) <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
#    Then match $ contains payload.response
    * def Original_Address_basic = payload.response.data.address.basic
    Then match $.data.address.basic contains payload.response.data.address.basic
    Then match $.meta contains payload.response.meta

    Examples:
      | Scenario                                            | statusCode |
      | Address_BASIC_positive_AllInputFields_Both_Q_and_QQ | 200        |

#  Scenario Outline: https://monnai.atlassian.net/browse/MB-1410 -Validate DPI ADDRESS_BASIC positive scenarios with 'q' input fields(q-addressLine1-8) <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    * print karate.pretty(response)
#    Then print payload.response
#    Then status <statusCode>
#    Then match $ contains payload.response
#
#    Examples:
#      | Scenario                                                              | statusCode |
#      | Address_BASIC_positive_AllInputFields_without_QQ_with_Q_input_Adrline1 | 200        |

  Scenario Outline: Validate DPI ADDRESS_BASIC positive scenarios with 'Q' input fields(q-addressLine1 only) input and optional fields keys are missing <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response

    Examples:
      | Scenario                                                    | statusCode |
      | Address_BASIC_positive_AllInputFields_Q_input_Adrline1_only | 200        |
  @smokeTest
  Scenario Outline: Validate DPI ADDRESS_BASIC positive scenarios with 'Q' input fields(q-addressLine1,2) input <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response

    Examples:
      | Scenario                                                 | statusCode |
      | Address_BASIC_positive_AllInputFields_Q_input_Adrline1,2 | 200        |
  @smokeTest
  Scenario Outline: Validate DPI ADDRESS_BASIC positive scenarios with all input fields(q-addressLine1-8,qq-individual fields like postal code) <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * print payload.request.postalCode
    * def expectedPostalCode = payload.request.address.postalCode
    * print expectedPostalCode
    * def actualPostalCode = $.data.address.basic.records[*].postalCode
    * print actualPostalCode
#    * match actualPostalCode == [expectedPostalCode]
    * match ([expectedPostalCode]) contains only actualPostalCode
    Then match $ contains payload.response

    Examples:
      | Scenario                                                            | statusCode |
      | Address_BASIC_positive_AllInputFields_Q_and_QQ_with_postalCode_only | 200        |

  Scenario Outline: Validate DPI ADDRESS_BASIC positive scenarios with all input fields(q-addressLine1-8,qq-individual fields like city) <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * print payload.request.city
    * def expectedCity = payload.request.address.city
    * print expectedCity
    * def actualCity = $.data.address.basic.records[*].city
    * print actualCity
    * match ([expectedCity]) contains only actualCity
    Then match $ contains payload.response

    Examples:
      | Scenario                                                      | statusCode |
      | Address_BASIC_positive_AllInputFields_Q_and_QQ_with_city_only | 200        |


  Scenario Outline: Validate DPI ADDRESS_BASIC positive scenarios with all input fields(q-addressLine1-8,qq-individual fields like state) <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * print payload.request.city
    * def expectedState = payload.request.address.state
    * print expectedState
    * def actualState = $.data.address.basic.records[*].state
    * print actualState
#    * match actualCity == [expectedCity]
    * match ([expectedState]) contains only actualState
    Then match $ contains payload.response

    Examples:
      | Scenario                                                       | statusCode |
      | Address_BASIC_positive_AllInputFields_Q_and_QQ_with_state_only | 200        |


#  Scenario Outline:https://monnai.atlassian.net/browse/MB-1683 Validate DPI ADDRESS_BASIC positive scenarios with all input fields(q-addressLine1-8,qq-individual fields like country) <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    * print karate.pretty(response)
#    Then print payload.response
#    Then status <statusCode>
#    Then match $ contains payload.response
#    * print payload.request.city
#    * def expectedCountry = payload.request.address.country
#    * print expectedCountry
#    * def actualCountryName = $.data.address.basic.records[*].countryName
#    * print actualCountryName
##    * match actualCity == [expectedCity]
#    * match ([expectedCountry]) contains only actualCountryName
#    Examples:
#      | Scenario                                                         | statusCode |
#      | Address_BASIC_positive_AllInputFields_Q_and_QQ_with_country_only | 200        |

  Scenario Outline: Validate DPI ADDRESS_BASIC negative scenario where mandatory field "addressLine1" is missing in request <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.errors[0].package == "ADDRESS_BASIC"
    And match $.errors[0].message == "address.addressLine1 is missing"
    And match $.errors[0].code == "MISSING_ADDRESSLINE1"
    And match $.errors[0].type == "INVALID_INPUT"

    Examples:
      | Scenario                                                  | statusCode |
      | Address_BASIC_Negative_Mandatory_Addressline1_Key_Missing | 400        |

    #this same as above sceanrio?? CHECK
  Scenario Outline: Validate DPI ADDRESS_BASIC negative scenario where mandatory field "addressLine1" is with invalid input <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request.address.addressLine1 = <addressLine1>
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.errors[0].package == "ADDRESS_BASIC"
    And match $.errors[0].message == "address.addressLine1 is missing"
    And match $.errors[0].code == "MISSING_ADDRESSLINE1"
    And match $.errors[0].type == "INVALID_INPUT"

    Examples:
      | Scenario                                                                  | statusCode | addressLine1 |
      | Address_BASIC_Negative_Mandatory_Addressline1_invalid_empty_or_null_input | 400        | null         |
      | Address_BASIC_Negative_Mandatory_Addressline1_invalid_empty_or_null_input | 400        | ""           |


  Scenario Outline: Validate DPI ADDRESS_BASIC negative scenario where optional field 'postalCode' validation <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request.address.addressLine1 = <addressLine1>
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>

    Examples:
      | Scenario                                                                  | statusCode | addressLine1 |
      | Address_BASIC_Negative_Mandatory_Addressline1_invalid_empty_or_null_input | 400        | null         |

#  Scenario Outline: https://monnai.atlassian.net/browse/MB-1682 Validate DPI ADDRESS_BASIC negative scenario where optional field 'postalCode' validation <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/ADDRESS_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request.address.postalCode = <postalCode>
#    And request payload.request
#    When method POST
#    * print karate.pretty(response)
#    Then print payload.response
#    Then status <statusCode>
#    * print payload.request.postalCode
#    * def expectedPostalCode = payload.request.address.postalCode
#    * print expectedPostalCode
#    * match expectedPostalCode == '#number'
#    * def actualPostalCode = $.data.address.basic.records[*].postalCode
#    * print actualPostalCode
##    * match actualPostalCode == [expectedPostalCode]
#    * match ([expectedPostalCode]) contains only actualPostalCode
#    Then match $ contains payload.response
#
#    Examples:
#      | Scenario                                                                  | statusCode | postalCode |
#      | Address_BASIC_Negative_AllInputFields_Q_and_QQ_with_postalCode_Validation | 200        | '123456'    |
##      | Address_BASIC_Negative_AllInputFields_Q_and_QQ_with_postalCode_Validation | 400        | 'abc123 '    |
##      | Address_BASIC_Negative_AllInputFields_Q_and_QQ_with_postalCode_Validation | 400        | abcedAB    |
