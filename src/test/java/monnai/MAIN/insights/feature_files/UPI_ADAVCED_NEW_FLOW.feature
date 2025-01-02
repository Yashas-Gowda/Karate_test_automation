@UPI_ADVANCED @regTest_4 @UPI
Feature:Testing of DPI - UPI_ADVANCED_NEW_FLOW feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  #SC002 Validate the UPI_ADVANCE package when upiApplicationName = GOOGLE_PAY

  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName = GOOGLE_PAY with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data.upi.advanced contains payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                                        | statusCode |
      | UPI_ADVANCED_POSITIVE_with_phone_email_input_account_upiApplicationName_GOOGLE_PAY              | 200        |
      | UPI_ADVANCED_POSITIVE_with_only_email_input_account_upiApplicationName_GOOGLE_PAY               | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_GOOGLE_PAY_upiIdCount_0                                | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_GOOGLE_PAY_upiIdCount_1_okhdfcbank_dpCall_cloudwatch_1 | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_GOOGLE_PAY_upiIdCount_1_okicici_dpCall_cloudwatch_2    | 200        |
      #data needs to find | UPI_ADVANCED_POSITIVE_upiApplicationName_GOOGLE_PAY_upiIdCount_1_okaxis_dpCall_cloudwatch_3     | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_GOOGLE_PAY_upiIdCount_1_oksbi_dpCall_cloudwatch_4      | 200        |


  Scenario Outline: Validate the UPI_ADVANCE NEGATIVE package when upiApplicationName = GOOGLE_PAY with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data == null
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                          | statusCode |
      | UPI_ADVANCED_NEGATIVE_with_only_phone_input_account_upiApplicationName_GOOGLE_PAY | 400        |

  #SC003  Validate the UPI_ADVANCE package when upiApplicationName = PHONEPE
  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName = PHONEPE with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data.upi.advanced contains payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                              | statusCode |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PHONEPE_upiIdCount_0                         | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PHONEPE_upiIdCount_1_ybl_dpCall_cloudwatch_1 | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PHONEPE_upiIdCount_1_axl_dpCall_cloudwatch_2 | 200        |
  # data not found  | UPI_ADVANCED_POSITIVE_upiApplicationName_PHONEPE_upiIdCount_1_ibl_dpCall_cloudwatch_4 | 200        |

  Scenario Outline: Validate the UPI_ADVANCE NEGATIVE package when upiApplicationName = PHONEPE with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data == null
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                       | statusCode |
      | UPI_ADVANCED_NEGATIVE_with_only_email_input_account_upiApplicationName_PHONEPE | 400        |

  # SC004 - Validate the UPI_ADVANCE package when upiApplicationName = PAYTM

  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName = PAYTM with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data.upi.advanced contains payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                    | statusCode |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PAYTM_upiIdCount_0 | 200        |
  # Data not found     | UPI_ADVANCED_POSITIVE_upiApplicationName_PAYTM_upiIdCount_1_paytm_dpCall_cloudwatch_1 | 200        |


  Scenario Outline: Validate the UPI_ADVANCE NEGATIVE package when upiApplicationName = PAYTM with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data == null
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                     | statusCode |
      | UPI_ADVANCED_NEGATIVE_with_only_email_input_account_upiApplicationName_PAYTM | 400        |

  # SC005 - Validate the UPI_ADVANCE package when upiApplicationName = PRIMARY

  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName = PRIMARY with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data.upi.advanced contains payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                                  | statusCode |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_0                             | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_PHONEPE             | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_GOOGLEPAY           | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_PAYTM               | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_OTHER_MobiKwik      | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_OTHER_Slice         | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_OTHER_Amazon_Pay    | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_OTHER_Bajaj_Finserv | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_OTHER_Jupiter_Money | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_OTHER_Navi          | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_OTHER_Samsung_Pay   | 200        |


  Scenario Outline: Validate the UPI_ADVANCE NEGATIVE package when upiApplicationName = PRIMARY with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data == null
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                       | statusCode |
      | UPI_ADVANCED_NEGATIVE_with_only_email_input_account_upiApplicationName_PRIMARY | 400        |


  #SC006  Validate the UPI_ADVANCE package when upiApplicationName = ALL

  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName = ALL with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data.upi.advanced contains only deep payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                                                   | statusCode |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_upiIdCount_0_all_other_handles_should_call_with_null_response | 200        |
  #      Data changed
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_upiIdCount_3_when_PRIMARY_GOOGLEPAY_other_GOOGLEPAY_handles_should_not_call | 200        |
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_upiIdCount_3_when_PRIMARY_PAYTM_other_PAYTM_handles_should_not_call         | 200        |
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_upiIdCount_3_when_PRIMARY_PHONEPE_other_PHONEPE_handles_should_not_call     | 200        |
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_upiIdCount_3_appName_OTHER_MobiKwik__all_other_handles_should_call          | 200        |
  #      # Data changed so haven't find number with 4 ids     | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_upiIdCount_4_appName_OTHER_MobiKwik__all_other_handles_should_call          | 200        |
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_upiIdCount_3_appName_OTHER_Slice_all_other_handles_should_call              | 200        |

  # when phone number with country code appended in the request
  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName = ALL with combination of phone number with 91-cleansingFlag combination and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data.upi.advanced contains only deep payload.response.data.upi.advanced
    # https://monnai.atlassian.net/browse/MB-3738
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                                                                                        | statusCode |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_cleansingFlag_true_with_country_code_upiIdCount_0_all_other_handles_should_call_with_null_response | 200        |
  #      Data changed
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_cleansingFlag_true_with_country_code_upiIdCount_3_when_PRIMARY_GOOGLEPAY_other_GOOGLEPAY_handles_should_not_call | 200        |
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_cleansingFlag_true_with_country_code_upiIdCount_3_when_PRIMARY_PAYTM_other_PAYTM_handles_should_not_call         | 200        |
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_cleansingFlag_true_with_country_code_upiIdCount_3_when_PRIMARY_PHONEPE_other_PHONEPE_handles_should_not_call     | 200        |
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_cleansingFlag_true_with_country_code_upiIdCount_3_appName_OTHER_MobiKwik__all_other_handles_should_call          | 200        |
  #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_cleansingFlag_true_with_country_code_upiIdCount_3_appName_OTHER_Slice__all_other_handles_should_call             | 200        |


  Scenario Outline: Validate the UPI_ADVANCE NEGATIVE package when upiApplicationName = ALL with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    Then match $.data == null
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                   | statusCode |
      | UPI_ADVANCED_NEGATIVE_with_only_email_input_account_upiApplicationName_ALL | 400        |

  #  SC007 - Validate the UPI_ADVANCE package when upiApplicationName = ANY - Not developed yet
  #  SC008 - Already covered in other scenarios
  #  SC009 - Validate the UPI_ADVANCE package for default upiApplicationName cases,"",NULL ETC -> all negative scenarios

  #  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName key is not present(DEFAULT=ALL) with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #    Then status <statusCode>
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
  ##    Then match $.data.upi.advanced.upiIdCount == payload.response.data.upi.advanced.upiIdCount
  #    Then match $.data.upi.advanced contains only deep payload.response.data.upi.advanced
  #    Then match $.meta contains payload.response.meta
  #    Then match $.errors contains payload.response.errors
  #
  #    Examples:
  #      | Scenario                                                             | statusCode |
  #      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_ALL_upiIdCount_0 | 200        |
  #      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_ALL_upiIdCount_1 | 200        |
  #      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_ALL_upiIdCount_2 | 200        |
  #      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_ALL_upiIdCount_3 | 200        |

  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName key is not present(DEFAULT=PRIMARY) with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    #    Then match $.data.upi.advanced.upiIdCount == payload.response.data.upi.advanced.upiIdCount
    Then match $.data.upi.advanced contains only deep payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                                | statusCode |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_upiIdCount_0                | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_PhonePe             | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_Google_Pay          | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_MobiKwik            | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_Slice               | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_OTHER_Amazon_Pay    | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_OTHER_Bajaj_Finserv | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_OTHER_Jupiter_Money | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_OTHER_Navi          | 200        |
      | UPI_ADVANCED_POSITIVE_NO_upiApplicationName_DEFAULT_PRIMARY_appName_OTHER_Samsung_Pay   | 200        |

  Scenario Outline: Validate the UPI_ADVANCE package when upiApplicationName key is not present(DEFAULT_ALL) with combination of phone and email input  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    #    Then match $.data.upi.advanced.upiIdCount == payload.response.data.upi.advanced.upiIdCount
    Then match $.data.upi.advanced contains only deep payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors
    Examples:
      | Scenario                                                                                                   | statusCode |
      #    Data not found
      #      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_cleansingFlag_true_with_country_code_upiIdCount_3_when_PRIMARY_GOOGLEPAY_other_GOOGLEPAY_handles_should_not_call | 200        |
      #      | UPI_ADVANCED_POSITIVE_upiApplicationName_PRIMARY_upiIdCount_1_appName_OTHER_MobiKwik                                                                          | 200        |
      | UPI_ADVANCED_POSITIVE_upiApplicationName_ALL_upiIdCount_0_all_other_handles_should_call_with_null_response | 200        |

  Scenario Outline: Validation of UPI_ADVANCED Possitive scenario for packageDetails <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
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
    #    Then match $.data.upi.advanced.upiIdCount == payload.response.data.upi.advanced.upiIdCount
    Then match $.data.upi.advanced contains only deep payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                                    | statusCode |
      | UPI_ADVANCED_POSITVE_with_packageDetails_S2101_when_DP_says_No_UPI_ID_found | 200        |


  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when upiApplicationName is invalid / null as input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
    And request payload.request.upiApplicationName = <upiApplicationName>
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
    Then match $.data == null
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors


    Examples:
      | Scenario                                                       | upiApplicationName | statusCode |
      | UPI_ADVANCED_NEGATIVE_upiApplicationName_invalid_or_null_input | ""                 | 400        |
      | UPI_ADVANCED_NEGATIVE_upiApplicationName_invalid_or_null_input | " "                | 400        |
      #https://monnai.atlassian.net/browse/MB-3564   | UPI_ADVANCED_NEGATIVE_upiApplicationName_invalid_or_null_input | null               | 400        |
      | UPI_ADVANCED_NEGATIVE_upiApplicationName_invalid_or_null_input | "abc"              | 400        |
      | UPI_ADVANCED_NEGATIVE_upiApplicationName_invalid_or_null_input | "123"              | 400        |
      | UPI_ADVANCED_NEGATIVE_upiApplicationName_invalid_or_null_input | 123                | 400        |


  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an invalid / null / empty phoneNumber input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneNumber = <phoneNumber>
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
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"


    Examples:
      | Scenario                                              | phoneNumber | statusCode | errorCode            | errorMessage                     |
      | UPI_ADVANCED_NEGATIVE_phonenumber_empty_or_null_input | ""          | 400        | MISSING_PHONE_NUMBER | PhoneNumber cannot be blank/null |
      | UPI_ADVANCED_NEGATIVE_phonenumber_empty_or_null_input | null        | 400        | MISSING_PHONE_NUMBER | PhoneNumber cannot be blank/null |


  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an invalid / null / empty phoneNumber input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneNumber = <phoneNumber>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.request.phoneNumber = <phoneNumber>
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
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"

    Examples:
      | Scenario                                               | phoneNumber | statusCode | errorCode            | errorMessage                     |
      | UPI_ADVANCED_NEGATIVE_phonenumber_empty_or_null_input1 | " "         | 400        | MISSING_PHONE_NUMBER | PhoneNumber cannot be blank/null |

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an  null / empty phoneDefaultCountryCode input -> <Scenario> | InputIP -> <phoneDefaultCountryCode>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
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
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"


    Examples:
      | Scenario                                                          | phoneDefaultCountryCode | statusCode | errorCode                          | errorMessage                       |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_empty_or_null_input | ""                      | 400        | MISSING_PHONE_DEFAULT_COUNTRY_CODE | Missing phone default country code |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_empty_or_null_input | null                    | 400        | MISSING_PHONE_DEFAULT_COUNTRY_CODE | Missing phone default country code |

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an  null / empty phoneDefaultCountryCode input -> <Scenario> | InputIP -> <phoneDefaultCountryCode>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
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
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"


    Examples:
      | Scenario                                                           | phoneDefaultCountryCode | statusCode | errorCode                          | errorMessage                       |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_empty_or_null_input1 | " "                     | 400        | MISSING_PHONE_DEFAULT_COUNTRY_CODE | Missing phone default country code |

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an input is INVALID phoneDefaultCountryCode  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.meta.inputPhoneNumber = "#ignore"
    * set payload.response.meta.inputPhoneDefaultCountryCode = "#ignore"
    * set payload.response.meta.cleansedPhoneNumber = "##string"
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
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"


    Examples:
      | Scenario                                                    | phoneDefaultCountryCode | statusCode | errorCode                          | errorMessage                       |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_invalid_input | "INN"                   | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_invalid_input | "In123"                 | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code |
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_invalid_input | "123"                   | 400        | INVALID_PHONE_DEFAULT_COUNTRY_CODE | Invalid phone default country code |


  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code SERVICE_UNAVAILABLE_FOR_COUNTRY when an input is  phoneDefaultCountryCode other then IN  -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED_NEW/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.meta.inputPhoneNumber = "#ignore"
    #    * set payload.response.meta.cleansedPhoneNumber = "##string"
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
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"
    Examples:
      | Scenario                                                                              | phoneDefaultCountryCode | statusCode | errorCode                       | errorMessage                              |
      #  https://monnai.atlassian.net/browse/MB-3555
      | UPI_ADVANCED_NEGATIVE_phoneDefaultCountryCode_invalid_SERVICE_UNAVAILABLE_FOR_COUNTRY | "ID"                    | 501        | SERVICE_UNAVAILABLE_FOR_COUNTRY | Service unavailable for country Indonesia |

  #  https://monnai.atlassian.net/browse/MB-1548
  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an input is invalid phoneNumber https://monnai.atlassian.net/browse/MB-1548-> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read( "../" + source + "/UPI_ADVANCED/<Scenario>.json")
    And request payload.request.phoneNumber = <phoneNumber>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.meta.inputPhoneNumber = "#ignore"
    * set payload.response.meta.cleansedPhoneNumber = "##string"
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
    Then match $ contains payload.response
    And match $.errors[0].code == "<errorCode>"
    And match $.errors[0].message == "<errorMessage>"


    Examples:
      | Scenario                                        | phoneNumber    | statusCode | errorCode            | errorMessage         |
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "910851asdwer" | 400        | INVALID_PHONE_NUMBER | Invalid Phone Number |
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "9108511"      | 400        | INVALID_PHONE_NUMBER | Invalid Phone Number |
      | UPI_ADVANCED_NEGATIVE_phonenumber_invalid_input | "asdfasdadfg"  | 400        | INVALID_PHONE_NUMBER | Invalid Phone Number |



  # tc related to spyclopud are commented as Spycloud datapartner in UPI_ADVANCED is disabled

  #Plase see cloud watch for below scenario, for phone and email input - SPY Cloud should not be called.

  #  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input( spycloud not called in cloudwatch)with all 3 appNames like { Paytm,Google Pay,PhonePe} ACCOUNT in Output-> <Scenario> | InputIP -> <phoneNumber>.
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/UPI_ADVANCED/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #   # cloud watch traces -start
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
  #    * match $.data.upi.advanced.accounts[*].appName contains only [Paytm,Google Pay,PhonePe]
  ##    Then match $.data.upi contains only  payload.response.data.upi
  #
  #    Examples:
  #      | Scenario                                                                                   | statusCode |
  #      | UPI_ADVANCED_POSITIVE_Phone&Email_input_No_SpyCloud_call_output_phonepay_GooglePay_PhonePe | 200        |
  #
  #  @upi_prod_sanity
  #     #Plase see cloud watch for below scenario,for only phone input - SPY Cloud should  be called.
  #  Scenario Outline: Validation of UPI_ADVANCED Positive scenario for valid phoneNumber & email input( spycloud  called in cloudwatch)with all 3 appNames like { Paytm,Google Pay,PhonePe} ACCOUNT in Output-> <Scenario> | InputIP -> <phoneNumber>.
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/UPI_ADVANCED/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #   # cloud watch traces -start
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
  #    * match $.data.upi.advanced.accounts[*].appName contains only [Paytm,Google Pay,PhonePe]
  ##    Then match $.data.upi contains  payload.response.data.upi
  #
  #    Examples:
  #      | Scenario                                                                                         | statusCode |
  #      | UPI_ADVANCED_POSITIVE_Phone_input_only_with_must_SpyCloud_call_output_phonepay_GooglePay_PhonePe | 200        |

