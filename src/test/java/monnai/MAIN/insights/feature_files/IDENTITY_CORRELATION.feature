@IDENTITIY_CORRELATION
Feature: Testing of DPI  - IDENTITY_CORRELATION feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline: Validate SAMPLE DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like email,ipAddress <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/IDENTITY_CORRELATION/<Scenario>.json")
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
    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndEmailMatched
    * match phoneAndIpAddressMatched != 'NO_INPUT'
    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
    * match phoneAndIpAddressMatched != 'NO_INPUT'
    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
    #  As IPQS credits are exacasted and aman  removed the partner partner * match phoneEmailAndIpAddressMatched != 'NO_INPUT'
    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
    * match phoneEmailAndIpAddressMatched != 'NO_INPUT'
    Then match $.data.identity.correlation contains payload.response.data.identity.correlation


    Examples:
      | Scenario                                                                    | statusCode |
      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_email_ipAddress_SAMPLE | 200        |

  ##  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like email,ipAddress where all are "YES" <Scenario>
  ##    Given url requestUrl
  ##    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  ##    And headers headers
  ##    And request payload.request
  ##    When method POST
  ##    * print payload.request
  ##    * print payload.response
  ##    * print karate.pretty(response)
  ##    Then status <statusCode>
  ##    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndEmailMatched
  ##    * match phoneAndIpAddressMatched != 'NO_INPUT'
  ##    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  ##    * match phoneAndIpAddressMatched != 'NO_INPUT'
  ##    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  ##    * match phoneEmailAndIpAddressMatched != 'NO_INPUT'
  ##    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  ##    * match phoneEmailAndIpAddressMatched != 'NO_INPUT'
  ##    Then match $ contains payload.response
  ##
  ##    Examples:
  ##      | Scenario                                                                     | statusCode |
  ##      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_email_ipAddress_all_YES | 200        |
  #
  ##  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like email,ipAddress where all are "YES" <Scenario>
  ##    Given url requestUrl
  ##    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  ##    And headers headers
  ##    And request payload.request
  ##    When method POST
  ##    * print payload.request
  ##    * print payload.response
  ##    * print karate.pretty(response)
  ##    Then status <statusCode>
  ##    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndEmailMatched
  ##    * match phoneAndIpAddressMatched != 'NO_INPUT'
  ##    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  ##    * match phoneAndIpAddressMatched != 'NO_INPUT'
  ##    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  ##    * match phoneEmailAndIpAddressMatched != 'NO_INPUT'
  ##    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  ##    * match phoneEmailAndIpAddressMatched != 'NO_INPUT'
  ##    Then match $ contains payload.response
  ##
  ##    Examples:
  ##      | Scenario                                                                                               | statusCode |
  ##      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_email_ipAddress_without_phoneAndIpLocationMatched | 200        |
  #
  #  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like email only - NO IP <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  #    And headers headers
  #    And request payload.request
  #    When method POST
  #    * print payload.request
  #    * print payload.response
  #    * print karate.pretty(response)
  #    Then status <statusCode>
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndEmailMatched
  #    * match phoneAndIpAddressMatched != 'NO_INPUT'
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  #    * match phoneAndIpAddressMatched == 'NO_INPUT'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    Then match $ contains payload.response
  #
  #    Examples:
  #      | Scenario                                                   | statusCode |
  #      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_email | 200        |
  #
  #  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like ipAddress and also with NO EMAIL Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  #    And headers headers
  #    And request payload.request
  #    When method POST
  #    * print payload.request
  #    * print payload.response
  #    * print karate.pretty(response)
  #    Then status <statusCode>
  #    * def phoneAndEmailMatched = $.data.identity.correlation.phoneAndEmailMatched
  #    * match phoneAndEmailMatched == 'NO_INPUT'
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  #    * match phoneAndIpAddressMatched != 'YES'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  #    * match phoneEmailAndIpAddressMatched == 'YES'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    Then match $ contains payload.response
  #
  #    Examples:
  #      | Scenario                                                                                                               | statusCode |
  #      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_ipAddress_with_phoneAndIpAddressMatched_phoneAndIpLocationMatched | 200        |


  #  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like ipAddress and also with NO EMAIL  where "phoneAndIpLocationMatched": "NO"<<Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  #    And headers headers
  #    And request payload.request
  #    When method POST
  #    * print payload.request
  #    * print payload.response
  #    * print karate.pretty(response)
  #    Then status <statusCode>
  #    * def phoneAndEmailMatched = $.data.identity.correlation.phoneAndEmailMatched
  #    * match phoneAndEmailMatched == 'NO_INPUT'
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  #    * match phoneAndIpAddressMatched != 'YES'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    Then match $ contains payload.response
  #
  #    Examples:
  #      | Scenario                                                                                                                       | statusCode |
  #      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_ipAddress_with_phoneAndIpAddressMatched_without_phoneAndIpLocationMatched | 200        |


  #  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like ipAddress  and also with NO EMAIL where "phoneAndIpLocationMatched": "YES"<Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  #    And headers headers
  #    And request payload.request
  #    When method POST
  #    * print payload.request
  #    * print payload.response
  #    * print karate.pretty(response)
  #    Then status <statusCode>
  #    * def phoneAndEmailMatched = $.data.identity.correlation.phoneAndEmailMatched
  #    * match phoneAndEmailMatched == 'NO_INPUT'
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  #    * match phoneAndIpAddressMatched != 'NO'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  #    * match phoneEmailAndIpAddressMatched == 'YES'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    Then match $ contains payload.response
  #
  #    Examples:
  #      | Scenario                                                                                                                       | statusCode |
  #      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_ipAddress_without_phoneAndIpAddressMatched_with_phoneAndIpLocationMatched | 200        |


  #  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like email,ipAddress where phoneEmailAndIpAddressMatched is UNKNOWN <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  #    And headers headers
  #    And request payload.request
  #    When method POST
  #    * print payload.request
  #    * print payload.response
  #    * print karate.pretty(response)
  #    Then status <statusCode>
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndEmailMatched
  #    * match phoneAndIpAddressMatched != 'NO_INPUT'
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  #    * match phoneAndIpAddressMatched != 'NO_INPUT'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  #    * match phoneEmailAndIpAddressMatched != 'NO_INPUT'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  #    * match phoneEmailAndIpAddressMatched == 'UNKNOWN'
  #    Then match $ contains payload.response
  #
  #    Examples:
  #      | Scenario                                                                                                        | statusCode |
  #      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_email_ipAddress_with_UNKNOWN_phoneEmailAndIpAddressMatched | 200        |

  #  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like email only where phoneAndEmailMatched is UNKNOWN- NO IP <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  #    And headers headers
  #    And request payload.request
  #    When method POST
  #    * print payload.request
  #    * print payload.response
  #    * print karate.pretty(response)
  #    Then status <statusCode>
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndEmailMatched
  #    * match phoneAndIpAddressMatched == 'UNKNOWN'
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  #    * match phoneAndIpAddressMatched == 'NO_INPUT'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    Then match $ contains payload.response
  #
  #    Examples:
  #      | Scenario                                                                                     | statusCode |
  #      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_email_with_UNKNOWN_phoneAndEmailMatched | 200        |

  #  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like ipAddress and also with NO EMAIL  where "phoneAndIpAddressMatched": "UNKNOWN"<<Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  #    And headers headers
  #    And request payload.request
  #    When method POST
  #    * print payload.request
  #    * print payload.response
  #    * print karate.pretty(response)
  #    Then status <statusCode>
  #    * def phoneAndEmailMatched = $.data.identity.correlation.phoneAndEmailMatched
  #    * match phoneAndEmailMatched == 'NO_INPUT'
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  #    * match phoneAndIpAddressMatched != 'UNKNOWN'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    Then match $ contains payload.response
  #
  #    Examples:
  #      | Scenario                                                                                             | statusCode |
  #      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_ipAddress_with_UNKNOWN_phoneAndIpAddressMatched | 200        |


  #  Scenario Outline: Validate DPI IDENTITY_CORRELATION positive scenarios with input mandatory field like phoneNumber and optional fields like ipAddress  and also with NO EMAIL where "phoneAndIpLocationMatched": "UNKNOWN"<Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + env + "/IDENTITY_CORRELATION/<Scenario>.json")
  #    And headers headers
  #    And request payload.request
  #    When method POST
  #    * print payload.request
  #    * print payload.response
  #    * print karate.pretty(response)
  #    Then status <statusCode>
  #    * def phoneAndEmailMatched = $.data.identity.correlation.phoneAndEmailMatched
  #    * match phoneAndEmailMatched == 'NO_INPUT'
  #    * def phoneAndIpAddressMatched = $.data.identity.correlation.phoneAndIpAddressMatched
  #    * match phoneAndIpAddressMatched != 'NO'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneAndIpLocationMatched
  #    * match phoneEmailAndIpAddressMatched == 'UNKNOWN'
  #    * def phoneEmailAndIpAddressMatched = $.data.identity.correlation.phoneEmailAndIpAddressMatched
  #    * match phoneEmailAndIpAddressMatched == 'NO_INPUT'
  #    Then match $ contains payload.response
  #
  #    Examples:
  #      | Scenario                                                                                              | statusCode |
  #      | IDENTITY_CORRELATION_Positive_with_input_phoneNumber_ipAddress_with_UNKNOWN_phoneAndIpLocationMatched | 200        |

  Scenario Outline: Validate DPI IDENTITY_CORRELATION Negative scenarios with phonenumber input is validated <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/IDENTITY_CORRELATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request.phoneNumber = <phoneNumber>
    And request payload.request
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
    And match $.errors[0].package == "IDENTITY_CORRELATION"
    And match $.errors[0].message == "Invalid Phone Number"
    And match $.errors[0].code == "INVALID_PHONE_NUMBER"
    And match $.errors[0].type == "INVALID_INPUT"

    Examples:
      | Scenario                                                        | statusCode | phoneNumber  |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | "ABCDEFGHIJ" |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | "12345678"   |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | "12345ABCD"  |

  Scenario Outline: Validate DPI IDENTITY_CORRELATION Negative scenarios for phonenumber with Empty/NULL input <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/IDENTITY_CORRELATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request.phoneNumber = <phoneNumber>
    And request payload.request
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
    And match $.errors[0].package == "IDENTITY_CORRELATION"
    And match $.errors[0].message == "PhoneNumber cannot be blank/null"
    And match $.errors[0].code == "MISSING_PHONE_NUMBER"
    And match $.errors[0].type == "INVALID_INPUT"
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                                        | statusCode | phoneNumber |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | ""          |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | " "         |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | null        |

  Scenario Outline: Validate DPI IDENTITY_CORRELATION Negative scenarios for phoneDefaultCountryCode with invalid input <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/IDENTITY_CORRELATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request.phoneDefaultCountryCode = "<phoneDefaultCountryCode>"
    And request payload.request
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
    And match $.errors[0].package == "IDENTITY_CORRELATION"
    And match $.errors[0].message == "Invalid phone default country code"
    And match $.errors[0].code == "INVALID_PHONE_DEFAULT_COUNTRY_CODE"
    And match $.errors[0].type == "INVALID_INPUT"
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                                                        | statusCode | phoneDefaultCountryCode |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | INN                     |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | INDIA                   |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | 123                     |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | IN123                   |

  Scenario Outline: Validate DPI IDENTITY_CORRELATION Negative scenarios for phoneDefaultCountryCode with EMPTY/NULL input <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/IDENTITY_CORRELATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
    And request payload.request
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
    And match $.errors[0].package == "IDENTITY_CORRELATION"
    And match $.errors[0].message == "Missing phone default country code"
    And match $.errors[0].code == "MISSING_PHONE_DEFAULT_COUNTRY_CODE"
    And match $.errors[0].type == "INVALID_INPUT"

    Examples:
      | Scenario                                                        | statusCode | phoneDefaultCountryCode |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | ""                      |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | " "                     |
      | IDENTITY_CORRELATION_Negative_with_input_phoneNumber_validation | 400        | null                    |


  Scenario Outline: Validate DPI IDENTITY_CORRELATION Negative scenarios for email with EMPTY/NULL input <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/IDENTITY_CORRELATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request.email = <email>
    And request payload.request
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
    And match $.errors[0].package == "IDENTITY_CORRELATION"
    And match $.errors[0].message == "At least one Additional search parameter email or ip address is required."
    And match $.errors[0].code == "MISSING_ADDITIONAL_SEARCH_PARAMETER"
    And match $.errors[0].type == "INVALID_INPUT"


    Examples:
      | Scenario                                                  | statusCode | email |
      | IDENTITY_CORRELATION_Negative_with_input_email_validation | 400        | ""    |
      | IDENTITY_CORRELATION_Negative_with_input_email_validation | 400        | " "   |
      | IDENTITY_CORRELATION_Negative_with_input_email_validation | 400        | null  |

  Scenario Outline: Validate DPI IDENTITY_CORRELATION Negative scenarios for IP with EMPTY/NULL input <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/IDENTITY_CORRELATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request.ipAddress = <ipAddress>
    And request payload.request
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
    And match $.errors[0].package == "IDENTITY_CORRELATION"
    And match $.errors[0].message == "At least one Additional search parameter email or ip address is required."
    And match $.errors[0].code == "MISSING_ADDITIONAL_SEARCH_PARAMETER"
    And match $.errors[0].type == "INVALID_INPUT"


    Examples:
      | Scenario                                                  | statusCode | ipAddress |
      | IDENTITY_CORRELATION_Negative_with_input_email_validation | 400        | ""        |
      | IDENTITY_CORRELATION_Negative_with_input_email_validation | 400        | " "       |
      | IDENTITY_CORRELATION_Negative_with_input_email_validation | 400        | null      |

  #Aug 1st 2023
  #Note: QA TEAM checked with TAPAN, as TAPAN CONFIRMED HE HAVEN'T RAN POC FOR Phone,Email, ip_adderessgit