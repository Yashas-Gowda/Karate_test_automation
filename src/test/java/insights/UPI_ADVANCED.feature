@upi
Feature:Testing of DPI - UPI_ADVANCED feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @123
  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an invalid / null / empty phoneNumber input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneNumber = <phoneNumber>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

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
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

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
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

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
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                                           | phoneDefaultCountryCode | statusCode | errorCode                          | errorMessage                       |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_empty_or_null_input1 | " "                     | 400        | MISSING_PHONE_DEFAULT_COUNTRY_CODE | Missing phone default country code |

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an input is INVALID phoneDefaultCountryCode  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.meta.inputPhoneNumber = "#ignore"
    * set payload.response.meta.cleansedPhoneNumber = "##string"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                                    | phoneDefaultCountryCode | statusCode | errorCode                          | errorMessage                       |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_invalid_input | "INN"                   | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_invalid_input | "In123"                 | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_invalid_input | "123"                   | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code |

#  https://monnai.atlassian.net/browse/MB-1548
  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an input is invalid phoneNumber https://monnai.atlassian.net/browse/MB-1548-> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneNumber = <phoneNumber>
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.meta.inputPhoneNumber = "#ignore"
    * set payload.response.meta.cleansedPhoneNumber = "##string"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                        | phoneNumber    | statusCode | errorCode            | errorMessage         |
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "910851asdwer" | 400        | INVALID_PHONE_NUMBER | Invalid Phone Number |
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "9108511"      | 400        | INVALID_PHONE_NUMBER | Invalid Phone Number |
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "asdfasdadfg"  | 400        | INVALID_PHONE_NUMBER | Invalid Phone Number |

  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input -> <Scenario> | InputIP -> <phoneNumber>.
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
    * def UPI_appNames = get $.data.upi.advanced.accounts[*].appName
    * print UPI_appNames
    Then match $ contains any payload.response
#    * def UPI_ID_TYPE = $.data.upi.advanced.accounts[*].appName
#    Then match UPI_ID_TYPE contains any [Paytm,PhonePe,Google Pay]
#    * print $.data.upi.advanced.accounts[*]
#    Then match $.data.upi.advanced.accounts[*] contains only [{"appName": "Paytm","nameAtBank": "Krishan Kumar","upiId": "9910872581@paytm"},{"appName": "PhonePe","nameAtBank": "KRISHAN KUMAR","upiId": "9910872581@ybl"},{"appName": "Google Pay","nameAtBank": "KRISHAN KUMAR","upiId": "krishankumar.1765@okhdfcbank"}]
#    Then match $.data.upi.advanced.accounts[*] contains [{"appName": "Paytm","nameAtBank": "Krishan Kumar","upiId": "9910872581@paytm"},{"appName": "PhonePe","nameAtBank": "KRISHAN KUMAR","upiId": "9910872581@ybl"},{"appName": "Google Pay","nameAtBank": "KRISHAN KUMAR","upiId": "krishankumar.1765@okhdfcbank"}]
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                                        | statusCode |
      | UPI_ADVANCED_POSITIVE_phone&Email_input_@ybl_@paytm_@okhdfcbank | 200        |
      | UPI_ADVANCED_POSITIVE_phone&Email_input_@ibl_@paytm_@okhdfcbank | 200        |
      | UPI_ADVANCED_POSITIVE_phone&Email_input_@ybl_@paytm_@okaxis     | 200        |

  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input without PAYTM ACCOUNT in Output-> <Scenario> | InputIP -> <phoneNumber>.
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
    Then match $.data.upi.advanced.accounts[*].appName contains only [PhonePe]
    Then match $ contains any payload.response
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

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
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * match $.data.upi.advanced.accounts[*].appName contains only [Paytm,Google Pay]
    Then match $.data.upi contains only  payload.response.data.upi
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                                         | statusCode |
      | UPI_ADVANCED_POSITIVE_Phone&Email_input_output_without_@Phonepay | 200        |

  @smokeTest
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
    Then match $.data.upi contains only payload.response.data.upi
    * def UPI_ID_TYPE = $.data.upi.advanced.accounts[*].appName
    * match UPI_ID_TYPE  contains only [Paytm,PhonePe,Google Pay]
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

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
    * def UPI_ID_TYPE = $.data.upi.advanced.accounts[*].appName
    * match UPI_ID_TYPE contains only [PhonePe,Paytm]
    Then match $ contains any payload.response
# cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                                                                 | statusCode |
      | UPI_ADVANCED_POSITIVE_Phone_input_only_&_get_output_wiyhoutGpayid_with_spycloud_no_email | 200        |

    #Plase see cloud watch for below scenario, for phone and email input - SPY Cloud should not be called.
  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input( spycloud not called in cloudwatch)with all 3 appNames like { Paytm,Google Pay,PhonePe} ACCOUNT in Output-> <Scenario> | InputIP -> <phoneNumber>.
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
    * match $.data.upi.advanced.accounts[*].appName contains only [Paytm,Google Pay,PhonePe]
#    Then match $.data.upi contains only  payload.response.data.upi
     #Plase see cloud watch for below scenario, for phone and email input - SPY Cloud should not be called.
# cloud watch traces -start -
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                                                                   | statusCode |
      | UPI_ADVANCED_POSITIVE_Phone&Email_input_No_SpyCloud_call_output_phonepay_GooglePay_PhonePe | 200        |

     #Plase see cloud watch for below scenario,for only phone input - SPY Cloud should  be called.
  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input( spycloud  called in cloudwatch)with all 3 appNames like { Paytm,Google Pay,PhonePe} ACCOUNT in Output-> <Scenario> | InputIP -> <phoneNumber>.
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
    * match $.data.upi.advanced.accounts[*].appName contains only [Paytm,Google Pay,PhonePe]
#    Then match $.data.upi contains  payload.response.data.upi
    #Plase see cloud watch for below scenario,for only phone input - SPY Cloud should  be called.
# cloud watch traces start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    Examples:
      | Scenario                                                                                          | statusCode |
      | UPI_ADVANCED_POSITIVE_Phone_input_only_with_must_SpyCloud_call_output_phonepay_GooglePay_PhonePe | 200        |
