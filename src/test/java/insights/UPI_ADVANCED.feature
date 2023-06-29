Feature:Testing of DPI - UPI_ADVANCED feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an invalid / null / empty phoneNumber input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneNumber = <phoneNumber>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"

    Examples:
      | Scenario                                              | phoneNumber | statusCode | errorCode            | errorMessage                     |
      | UPI_ADVANCED_NEGATIVE_phonenumber_empty_or_null_input | ""          | 400        | MISSING_PHONE_NUMBER | PhoneNumber cannot be blank/null |
      | UPI_ADVANCED_NEGATIVE_phonenumber_empty_or_null_input | null        | 400        | MISSING_PHONE_NUMBER | PhoneNumber cannot be blank/null |

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an invalid / null / empty phoneNumber input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneNumber = <phoneNumber>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"

    Examples:
      | Scenario                                               | phoneNumber | statusCode | errorCode            | errorMessage                     |
      | UPI_ADVANCED_NEGATIVE_phonenumber_empty_or_null_input1 | " "         | 400        | MISSING_PHONE_NUMBER | PhoneNumber cannot be blank/null |

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an  null / empty phoneDefaultCountryCode input -> <Scenario> | InputIP -> <phoneDefaultCountryCode>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"

    Examples:
      | Scenario                                                          | phoneDefaultCountryCode | statusCode | errorCode                          | errorMessage                       |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_empty_or_null_input | ""                      | 400        | MISSING_PHONE_DEFAULT_COUNTRY_CODE | Missing phone default country code |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_empty_or_null_input | null                    | 400        | MISSING_PHONE_DEFAULT_COUNTRY_CODE | Missing phone default country code |

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an  null / empty phoneDefaultCountryCode input -> <Scenario> | InputIP -> <phoneDefaultCountryCode>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print karate.pretty(response)
    Then print payload.response
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"

    Examples:
      | Scenario                                                           | phoneDefaultCountryCode | statusCode | errorCode                          | errorMessage                       |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_empty_or_null_input1 | " "                     | 400        | MISSING_PHONE_DEFAULT_COUNTRY_CODE | Missing phone default country code |

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an invalid phoneNumber input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"

    Examples:
      | Scenario                                        | phoneDefaultCountryCode | statusCode | errorCode                          | errorMessage         |
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "INN"                   | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code|
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "In123"                 | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code|
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "123"                   | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code |

#  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an invalid phoneNumber input -> <Scenario> | InputIP -> <phoneNumber>.
#    Given url requestUrl
#    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
#    And request payload.request.phoneNumber = <phoneNumber>
#    And headers headers
#    And request payload.request
#    When method POST
#    * print karate.pretty(response)
#    Then print payload.request
#    Then print payload.response
#    Then status <statusCode>
#    Then match $ contains payload.response
#    And match $.errors[0].code == "<errorCode>"
#    And match $.errors[0].message == "<errorMessage>"
#
#    Examples:
#      | Scenario                                        | phoneNumber    | statusCode | errorCode            | errorMessage                       |
#      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "910851asdwer" | 400        | MISSING_PHONE_NUMBER | Missing phone default country code |
#      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "9108511"      | 400        | MISSING_PHONE_NUMBER | Missing phone default country code |
#      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "asdfasdadfg"  | 400        | MISSING_PHONE_NUMBER | Missing phone default country code |

  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print karate.pretty(response)
    * print payload.request
    * print payload.response
    Then status <statusCode>
    * def UPI_ID_TYPE = $.data.upi.advanced.accounts[*].appName
    Then match UPI_ID_TYPE contains any [Paytm,PhonePe,Google Pay]
#    * print $.data.upi.advanced.accounts[*]
#    Then match $.data.upi.advanced.accounts[*] contains only [{"appName": "Paytm","nameAtBank": "Krishan Kumar","upiId": "9910872581@paytm"},{"appName": "PhonePe","nameAtBank": "KRISHAN KUMAR","upiId": "9910872581@ybl"},{"appName": "Google Pay","nameAtBank": "KRISHAN KUMAR","upiId": "krishankumar.1765@okhdfcbank"}]
#    Then match $.data.upi.advanced.accounts[*] contains [{"appName": "Paytm","nameAtBank": "Krishan Kumar","upiId": "9910872581@paytm"},{"appName": "PhonePe","nameAtBank": "KRISHAN KUMAR","upiId": "9910872581@ybl"},{"appName": "Google Pay","nameAtBank": "KRISHAN KUMAR","upiId": "krishankumar.1765@okhdfcbank"}]

    Examples:
      | Scenario                                                        | statusCode |
      | UPI_ADVANCED_POSITIVE_phone&Email_input_@ybl_@paytm_@okhdfcbank | 200        |
      | UPI_ADVANCED_POSITIVE_phone&Email_input_@ibl_@paytm_@okhdfcbank | 200        |
#      | UPI_ADVANCED_POSITIVE_Phone&Email_input_output_without_@paytm    | 200        |
#      | UPI_ADVANCED_POSITIVE_Phone&Email_input_output_without_@Phonepay | 200        |

  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input without PAYTM ACCOUNT in Output-> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print karate.pretty(response)
    * print payload.request
    * print payload.response
    Then status <statusCode>
    * def UPI_ID_TYPE = $.data.upi.advanced.accounts[*].appName
    Then match UPI_ID_TYPE contains any [PhonePe,Google Pay]

    Examples:
      | Scenario                                                      | statusCode |
      | UPI_ADVANCED_POSITIVE_Phone&Email_input_output_without_@paytm | 200        |

  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input without PHONEPE ACCOUNT in Output-> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print karate.pretty(response)
    * print payload.request
    * print payload.response
    Then status <statusCode>
    * def UPI_ID_TYPE = $.data.upi.advanced.accounts[*].appName
    * match UPI_ID_TYPE == [Paytm,Google Pay]

    Examples:
      | Scenario                                                         | statusCode |
      | UPI_ADVANCED_POSITIVE_Phone&Email_input_output_without_@Phonepay | 200        |

  Scenario Outline: Validate the UPI_ADVANCE package with valid input of Phone only - Phonepe, Paytm ids for phone and make a call to SPY CLOUD PHONE API to fetch 3 Gmail ids, which can form 1 valid Gpay UpiId to stop calling. -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    * def UPI_ID_TYPE = $.data.upi.advanced.accounts[*].appName
    * match UPI_ID_TYPE == [Paytm,PhonePe,Google Pay]

    Examples:
      | Scenario                                                                        | statusCode |
      | UPI_ADVANCED_POSITIVE_Phone_input_only_&_get_output_1Gpayid_with_spycloud_email | 200        |


  Scenario Outline: Validate the UPI_ADVANCE package with valid input of Phone only - Phonepe, Paytm ids for phone and make a call to SPY CLOUD PHONE API to fetch 3 Gmail ids, which can not form gapy wiyhoutGpayid_with_spycloud_no_email . -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    * def UPI_ID_TYPE = $.data.upi.advanced.accounts[*].appName
    * match UPI_ID_TYPE contains [PhonePe,Paytm]

    Examples:
      | Scenario                                                                                 | statusCode |
      | UPI_ADVANCED_POSITIVE_Phone_input_only_&_get_output_wiyhoutGpayid_with_spycloud_no_email | 200        |

  Scenario: sample assertions
    Given url requestUrl
    And headers headers
    * def data = { foo: [1, 2, 3] }
    * match data.foo contains any [9, 2, 8]

    * def data = { foo: [1, 2, 3] }
    * match data.foo contains only [3, 2, 1]
    * match data.foo contains only [2, 3, 1]

  Scenario: sample assertions
    Given url requestUrl
    And headers headers
    * def cat =
  """
  {
    name: 'Billie',
    kittens: [
      { id: 23, name: 'Bob' },
      { id: 42, name: 'Wild' }
    ]
  }
  """
    * def kitnums = $cat.kittens[*]
    * print kitnums

    * def kitnums = $cat.kittens[*].name
    * print kitnums


