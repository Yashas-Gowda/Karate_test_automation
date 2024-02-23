@PHONE_BASIC_FULL
Feature: Testing of DPI  - Phone_basic Sub package TopUP History scenarios for ID Region

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @smokeTest @PHONE_BASIC @topUpHistory @izidata
  Scenario Outline:  DPI PHONE_BASIC_Sub_topUpHistory positive scenario for Indonesia region with validation of data-points in topUpHistory - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/topUpHistory/<Scenario>.json")
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
    And match $.data.phone.basic == '#notnull'
    And match $.data.phone.basic.topUpHistory == '#notnull'
    And match $.data.phone.basic.topUpHistory[*].topUpCount != 0

    * match each $.data.phone.basic.topUpHistory contains { "currency": "IDR"}
    * match each $.data.phone.basic.topUpHistory contains { "topUpCount": '#? _ >=1'}

    * match each $.data.phone.basic.topUpHistory contains { "minimumTopUpAmount": '#? _ >=1000' }
    * match each $.data.phone.basic.topUpHistory contains { "maximumTopUpAmount": '#? _ >=1000' }
    * match each $.data.phone.basic.topUpHistory contains { "averageTopUpAmount": '#? _ >=1000' }

    * match $.data.phone.basic.topUpHistory == payload.response.data.phone.basic.topUpHistory
    * match $.meta == payload.response.meta

    Examples:
      | Scenario                                                                                                                      | statusCode |
      | PHONE_BASIC_Sub_topUpHistory_ID_sanity_check_for_currency_topUpCount_minimumTopUpAmount_maximumTopUpAmount_averageTopUpAmount | 200        |

  @PHONE_BASIC @topUpHistory @izidata
  Scenario Outline:  DPI PHONE_BASIC_Sub_topUpHistory positive scenario for Indonesia region with validation of data-points in topUpHistory - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/topUpHistory/<Scenario>.json")
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
    And match $.data.phone.basic == '#notnull'
    And match $.data.phone.basic.topUpHistory == '#notnull'
    And match $.data.phone.basic.topUpHistory[*].topUpCount != 0
   And match $.data.phone.basic.topUpHistory[*].topUpCount contains any <topUpCount>


    * match each $.data.phone.basic.topUpHistory contains { "currency": "IDR"}
    * match each $.data.phone.basic.topUpHistory contains { "topUpCount": '#? _ >=1'}

    * match each $.data.phone.basic.topUpHistory contains { "minimumTopUpAmount": '#? _ >=1000' }
    * match each $.data.phone.basic.topUpHistory contains { "maximumTopUpAmount": '#? _ >=1000' }
    * match each $.data.phone.basic.topUpHistory contains { "averageTopUpAmount": '#? _ >=1000' }

    * match $.data.phone.basic.topUpHistory == payload.response.data.phone.basic.topUpHistory
    * match $.meta == payload.response.meta

    Examples:
      | Scenario                                                              | statusCode | topUpCount |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_1       | 200        | 1          |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_max_9   | 200        | 9          |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_max_128 | 200        | 128        |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_max_197 | 200        | 197        |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_more_then_max_290 | 200        | 297        |

  @PHONE_BASIC @topUpHistory @izidata
  Scenario Outline:  DPI PHONE_BASIC_Sub_topUpHistory positive scenario for Indonesia region with validation of data-points in topUpHistory - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/topUpHistory/<Scenario>.json")
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
    And match $.data.phone.basic == '#notnull'
    And match $.data.phone.basic.topUpHistory == '#notnull'
    And match $.data.phone.basic.topUpHistory[*].topUpCount != 0

    * def Expected_topUpArray_count = <No_of_array_objects>
    # Expected_topUpArray_count is count of array objects expected
    * print Expected_topUpArray_count
    * def Actual_topUpArray =  $.data.phone.basic.topUpHistory
    * print Actual_topUpArray
    * def Actual_topUpArray_count =  Actual_topUpArray.length
     # Actual_topUpArray_count is count of array objects come up in actual response
    * print Actual_topUpArray_count
    * match Expected_topUpArray_count  == Actual_topUpArray_count

#    _$ --> The 'parent' of 'self' or 'current' item in the list, relevant when using match each


    * match each $.data.phone.basic.topUpHistory contains  { "currency": "IDR"}
    * match each $.data.phone.basic.topUpHistory contains { "topUpCount": '#number? _ >=1'}

    * match each $.data.phone.basic.topUpHistory contains { "minimumTopUpAmount": '#number? _ >=1000' }
    * match each $.data.phone.basic.topUpHistory contains { "maximumTopUpAmount": '#number? _ >=1000' }
    * match each $.data.phone.basic.topUpHistory contains { "averageTopUpAmount": '#number? _ >=1000' }

    * match $.data.phone.basic.topUpHistory == payload.response.data.phone.basic.topUpHistory
    * match $.meta == payload.response.meta

    Examples:
      | Scenario                                                                 | statusCode | No_of_array_objects |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_10 | 200        | 10                  |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_9  | 200        | 9                   |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_8  | 200        | 8                   |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_7  | 200        | 7                   |
     | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_5  | 200        | 5                   |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_4  | 200        | 4                   |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_3  | 200        | 3                   |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_2  | 200        | 2                   |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_1  | 200        | 1                   |

  @PHONE_BASIC @topUpHistory @izidata @Negative
  Scenario Outline:  DPI PHONE_BASIC_Sub_topUpHistory Negative scenario for Indonesia region with validation of data-points in topUpHistory where no response is given by datapoint  - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/topUpHistory/<Scenario>.json")
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
    And match $.data.phone.basic == '#notnull'
    And match $.data.phone.basic.topUpHistory == '#null'


    Examples:
      | Scenario                                                                         | statusCode |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_with_null_response_from_data_partner | 200        |

#PHONE_BASIC_Sub_topUpHistory_ID_region_Phonenumber_with_null_response_from_data_partner


  @PHONE_BASIC @topUpHistory @izidata @Negative
  Scenario Outline:  DPI PHONE_BASIC_Sub_topUpHistory Negative scenario for region other then Indonesia(india) with validation of data-points in topUpHistory where  response is "topUpHistory": null   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/topUpHistory/<Scenario>.json")
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
    And match $.data.phone.basic == '#notnull'
    And match $.data.phone.basic.topUpHistory == '#null'

    Examples:
      | Scenario                                                                                           | statusCode |
      | PHONE_BASIC_Sub_topUpHistory_When_phoneDefaultCountryCode_other_then_ID_response_topUpHistory_null | 200        |
