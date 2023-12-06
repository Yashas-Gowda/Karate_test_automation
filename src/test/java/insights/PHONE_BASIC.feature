Feature: Testing of DPI  - Phone_basic scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken
#    * def BearerToken = "Bearer eyJraWQiOiJUU2xyaDVMTW03XC9ZYVJCNEdoUnRFQVVIdzNMeWVSV280c1hMeWthU1RKWT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmNDliOWM1ZS05YzQ1LTQ4NjAtYTdlMi0wNzBmMmViN2E0ZjkiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfMVdiZkJPN3lGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiNGpiZGYxNjJiZW40amxwZmFqM3FuNThwdjUiLCJvcmlnaW5fanRpIjoiOWFiOTQ4NzItNWY3ZC00OTZkLWE0YjItZWVkOTM0N2Y4MTBmIiwidG9rZW5fdXNlIjoiYWNjZXNzIiwic2NvcGUiOiJwaG9uZSBvcGVuaWQgcHJvZmlsZSBlbWFpbCIsImF1dGhfdGltZSI6MTcwMDcyMDU0MywiZXhwIjoxNzAwODA2OTQzLCJpYXQiOjE3MDA3MjA1NDQsImp0aSI6IjMwN2YyOWRjLTVlZDgtNGU4ZC04ODFkLWJiYjc1NTc5NjBmNSIsInVzZXJuYW1lIjoiZjQ5YjljNWUtOWM0NS00ODYwLWE3ZTItMDcwZjJlYjdhNGY5In0.E5XjO7rc7g1H5djWPxxUu4J9G39W1Yi3kMKefsBNd2omCjN2g_ArVR0FxT9iIKeOfHIkNTPgrLRnETANoq9u2xnoAoHW0IKzb_gncoFQdEkKgqsADUZKy--1TtpXFGk90r---aMV15ubJvCIBmSpkR14864X2d3DJKLwd2qaGT_x5dMH04BYo3_O-dEEKdrtdi9W7zuqdoGJWkAiBvJ5roMTtc_uCo3BXaRfk7u3MipdgL2dikbn52Qy0uRJFQvLL11VtidXrnw5Pg2VYqtsYT5kzzkqQXC_CKip1JlxR445FZlgncxCbNQgleJxYA6kF_IeYMZXrnwg2LFBKFEnRg"

  @PHONE_BASIC @PHONE_INFORMATION @phoneValid @phoneDisposable @no_data_partner
  Scenario Outline:  DPI PHONE_BASIC_Sub_PHONE_INFORMATION positive scenario for Indian region with validation of phoneValid,phoneDisposable - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/PHONE_INFORMATION/<Scenario>.json")
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
    And match $.data.phone.basic.phoneValid == true
    And match $.data.phone.basic.phoneDisposable == false

    Examples:
      | Scenario                                                                                   | statusCode |
      | PHONE_BASIC_Sub_PHONE_INFORMATION_region_India_phoneValid_phoneDisposable_true             | 200        |
      | PHONE_BASIC_Sub_PHONE_INFORMATION_region_UnitedKingdom(GB)_phoneValid_phoneDisposable_true | 200        |

  @smokeTest @PHONE_BASIC @SPAM_CHECK @isSpam  @Eyecon
  Scenario Outline:  DPI PHONE_BASIC_Sub_SPAM_CHECK positive scenario for Indian region with validation of isSpam - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/SPAM_CHECK/<Scenario>.json")
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
    And match $.data.phone.basic.isSpam == <isSpam>

    Examples:
      | Scenario                                                      | statusCode | isSpam |
      | PHONE_BASIC_Sub_SPAM_CHECK_Eyecon_India_isSpam_true           | 200        | true   |
      | PHONE_BASIC_Sub_SPAM_CHECK_Eyecon_India_isSpam_false          | 200        | false  |
      | PHONE_BASIC_Sub_SPAM_CHECK_Eyecon_OtherCountry_UK_isSpam_null | 200        | null   |

  @PHONE_BASIC @SIMTYPE @simType @Karza @WDD @INDOSAT
  Scenario Outline:  DPI PHONE_BASIC_Sub_SIMTYPE positive scenario for Indian region with validation of simType - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/SIMTYPE/<Scenario>.json")
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
    And match $.data.phone.basic.simType == <simType>

    Examples:
      | Scenario                                             | statusCode | simType    |
      | PHONE_BASIC_Sub_SIMTYPE_Karza_India_simType_PREPAID  | 200        | "PREPAID"  |
      | PHONE_BASIC_Sub_SIMTYPE_Karza_WDD_India_simType_null | 200        | null       |
      | PHONE_BASIC_Sub_SIMTYPE_Karza_India_simType_POSTPAID | 200        | "POSTPAID" |

      | PHONE_BASIC_Sub_SIMTYPE_WDD_Brazil_simType_POSTPAID  | 200        | "POSTPAID" |
      | PHONE_BASIC_Sub_SIMTYPE_WDD_Brazil_simType_PREPAID   | 200        | "PREPAID"  |


  @PHONE_BASIC @PORTED_DETAILS @TMT @ported @portedDate @numberOfPorts @portedSinceXDays @portedEvents
  Scenario Outline:  DPI PHONE_BASIC_Sub_PORTED_DETAILS positive scenario for Indian region with validation of ported  - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/PORTED_DETAILS/<Scenario>.json")
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

    And match $.data.phone.basic.ported == <ported>
    And match $.data.phone.basic.portedHistory.portedDate == <portedDate>
    And match $.data.phone.basic.portedHistory.numberOfPorts == <numberOfPorts>
    And match $.data.phone.basic.portedHistory.portedSinceXDays == <portedSinceXDays>
    And match $.data.phone.basic.portedHistory.portedEvents == <portedEvents>

    * match $.data.phone.basic.portedHistory == { portedDate:'##notnull',numberOfPorts:'#number',portedSinceXDays:'##number',currentCarrierCircle:'##string',originalCarrierCircle:'##string',changeInCarrierRegion:'##string',portedEvents:'#array'}

    Examples:
      | Scenario                                                                                                          | statusCode | ported | portedDate   | numberOfPorts | portedSinceXDays | portedEvents |
      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_US_ported_portedDate_numberOfPorts_portedSinceXDays_true                       | 200        | true   | "2020-04-12" | 3             | '#number'        | '#[3]'       |
      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_US_ported_portedDate_numberOfPorts_portedSinceXDays_false                      | 200        | false  | "2022-08-10" | 2             | '#number'        | '#[2]'       |
      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_IN_ported_portedDate_numberOfPorts_portedSinceXDays_true                       | 200        | true   | "2023-04-05" | 1             | '#number'        | '#[1]'       |
      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_IN_ported_portedDate_numberOfPorts_portedSinceXDays_false                      | 200        | false  | null         | 0             | null             | '#[0]'       |
      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_BR_ported_portedDate_numberOfPorts_portedSinceXDays_true                       | 200        | true   | "2022-05-07" | 1             | '#number'        | '#[1]'       |
      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_BR_ported_portedDate_numberOfPorts_portedSinceXDays_false                      | 200        | false  | null         | 0             | null             | '#[0]'       |
      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_IN_FIXED_LANDLINE_NUMBER_ported_portedDate_numberOfPorts_portedSinceXDays_null | 200        | false  | null         | 0             | null             | '#[0]'       |

#    Examples:
#      | Scenario                                                                                     | statusCode | ported | portedDate   | numberOfPorts | portedSinceXDays | currentCarrierCircle            | originalCarrierCircle           | changeInCarrierRegion |
#      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_US_ported_portedDate_numberOfPorts_portedSinceXDays_true  | 200        | true   | "2020-04-12" | 3             | '#number'        | "Verizon Verizon Wireless"      | "T-Mobile T-Mobile US"          | "NOT_SUPPORTED"       |
#      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_US_ported_portedDate_numberOfPorts_portedSinceXDays_false | 200        | false  | "2022-08-10" | 2             | '#number'        | "Verizon Verizon Wireless"      | "Verizon Verizon Wireless"      | "NOT_SUPPORTED"       |
#      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_IN_ported_portedDate_numberOfPorts_portedSinceXDays_true  | 200        | true   | "2023-04-05" | 1             | '#number'        | "Jio Karnataka"                 | "Airtel Karnataka"              | "NOT_CHANGED"         |
#      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_IN_ported_portedDate_numberOfPorts_portedSinceXDays_false | 200        | false  | null         | 0             | null             | "BSNL Mobile Maharashtra & Goa" | "BSNL Mobile Maharashtra & Goa" | "NOT_CHANGED"         |
#      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_BR_ported_portedDate_numberOfPorts_portedSinceXDays_true  | 200        | true   | "2022-05-07" | 1             | '#number'        | "Claro Claro"                   | "TIM Telecom Italia Mobile"     | "NOT_SUPPORTED"       |
#      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_BR_ported_portedDate_numberOfPorts_portedSinceXDays_false | 200        | false  | null         | 0             | null             | "CLARO S.A."                    | "CLARO S.A."                    | "NOT_SUPPORTED"       |



  @smokeTest1 @PHONE_BASIC @PHONE_TENURE @WDD @activationDate @activeSinceXDays @Asliri @phoneNumberAge @phoneNumberAgeDescription @Monnai_Derived @phoneTenure @min @max
  Scenario Outline:  DPI PHONE_BASIC_Sub_PHONE_TENURE positive scenario for Indian region with validation of simType - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/PHONE_TENURE/<Scenario>.json")
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
    And match $.data.phone.basic.activationDate == <activationDate>
    And match $.data.phone.basic.activeSinceXDays == <activeSinceXDays>

    And match $.data.phone.basic.phoneNumberAge == <phoneNumberAge>
    And match $.data.phone.basic.phoneNumberAgeDescription == <phoneNumberAgeDescription>

    And match $.data.phone.basic.phoneTenure == <phoneTenure>
    And match $.data.phone.basic.phoneTenure.min == <phoneTenure_min>
    And match $.data.phone.basic.phoneTenure.max == <phoneTenure_max>

# INDOSAT sceanrios are automated based on high level understanding as manual sign off was given by Sameena.

    Examples:
      | Scenario                                                                                                                             | statusCode | activationDate | activeSinceXDays | phoneNumberAge | phoneNumberAgeDescription | phoneTenure | phoneTenure_min | phoneTenure_max |
      | PHONE_BASIC_Sub_PHONE_TENURE_WDD_BR_ported_activationDate_activeSinceXDays_phoneNumberAge_phoneNumberAgeDescription_phoneTenure_null | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#null"     | "##null"        | "##null"        |
      | PHONE_BASIC_Sub_PHONE_TENURE_WDD_BR_activeSinceXDays_phoneNumberAge_null_ported_activationDate_phoneTenure_48_null                   | 200        | "2014-03-06"   | "#number"        | "#null"        | "#null"                   | "#notnull"  | 48              | null            |
#      | PHONE_BASIC_Sub_PHONE_TENURE_WDD_BR_activeSinceXDays_phoneNumberAge_null_ported_activationDate_phoneTenure_24_48                     | 200        | "2021-03-31"   | null             | "#null"        | "#null"                   | "#notnull"  | 24              | 48              |

      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_IN_activeSinceXDays_phoneNumberAge_ported_activationDate_null_phoneTenure_0_6            | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#notnull"  | 0               | 6               |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_IN_activeSinceXDays_phoneNumberAge_ported_activationDate_null_phoneTenure_6_12           | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#notnull"  | 12              | 24              |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_IN_activeSinceXDays_phoneNumberAge_ported_activationDate_null_phoneTenure_12_24          | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#notnull"  | 12              | 24              |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_IN_activeSinceXDays_phoneNumberAge_ported_activationDate_null_phoneTenure_24_48          | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#notnull"  | 24              | 48              |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_IN_activeSinceXDays_phoneNumberAge_ported_activationDate_null_phoneTenure_48_null        | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#notnull"  | 48              | null            |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_IN_when_lastDeactivated_returned_portedDate_null_then_phoneTenure_is_returned            | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#notnull"  | 12              | 24              |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_IN_when_lastDeactivated_null_portedDate_notnull_then_phoneTenure_is_returned             | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#notnull"  | 48              | null            |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_IN_when_lastDeactivated_portedDate_notnull_then_phoneTenure_is_returned                  | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#notnull"  | 48              | null            |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_other_then_ID_IN_BR_then_phoneTenure_null                                    | 200        | "#null"        | "#null"          | "#null"        | "#null"                   | "#null"     | "##null"        | "##null"        |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_called_INDOSAT_Data_partner                                | 200        | "#null"        | "#null"          | 5              | "Above 24 months"         | "#notnull"  | 24              | null            |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_IAM_NUMBER_called_INDOSAT_Data_partner                            | 200        | "#null"        | "#null"          | 1              | "Below 3 months"          | "#notnull"  | 0               | 3               |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_called_TMT_Data_partner                                | 200        | "#null"        | "#null"          | 4              | "Above 12 Months"         | "#notnull"  | 12              | null            |


  @PHONE_BASIC @LAST_DEACTIVATED @Zumigo @lastDeactivated @minimumTenureDays @minimumTenureDays
  Scenario Outline:  DPI PHONE_BASIC_Sub_LAST_DEACTIVATED positive scenario for Indian region with validation of LAST_DEACTIVATED - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/LAST_DEACTIVATED/<Scenario>.json")
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
    And match $.data.phone.basic.lastDeactivated == <lastDeactivated>
    And match $.data.phone.basic.lastDeactivated.minimumTenureDays == <lastDeactivated_minimumTenureDays>
    And match $.data.phone.basic.lastDeactivated.minimumTenureDays == <lastDeactivated_maximumTenureDays>

    Examples:
      | Scenario                                                                                    | statusCode | lastDeactivated | lastDeactivated_minimumTenureDays | lastDeactivated_maximumTenureDays |
      | PHONE_BASIC_Sub_LAST_DEACTIVATED_IN_Zumigo_True_deactivated_India_lastDeactivated_notnull   | 200        | "#notnull"      | "#number"                         | "#number"                         |
      | PHONE_BASIC_Sub_LAST_DEACTIVATED_IN_Zumigo_false_deactivated_India_lastDeactivated_null     | 200        | null            | "##null"                          | "##null"                          |
      | PHONE_BASIC_Sub_LAST_DEACTIVATED_null_for_other_region_expect_india_BR_lastDeactivated_null | 200        | null            | "##null"                          | "##null"                          |

  @PHONE_BASIC @CARRIER_INFORMATION @TMT @currentCarrierCircle @originalCarrierCircle @changeInCarrierRegion
  Scenario Outline:  DPI PHONE_BASIC_Sub_CARRIER_INFORMATION positive scenario for Indian region with validation of changeInCarrierRegion - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/CARRIER_INFORMATION/<Scenario>.json")
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
    And match $.data.phone.basic.portedHistory.currentCarrierCircle == <currentCarrierCircle>
    And match $.data.phone.basic.portedHistory.originalCarrierCircle == <originalCarrierCircle>
    And match $.data.phone.basic.portedHistory.changeInCarrierRegion == <changeInCarrierRegion>

    Examples:
      | Scenario                                                                       | statusCode | currentCarrierCircle | originalCarrierCircle        | changeInCarrierRegion |
      | PHONE_BASIC_Sub_CARRIER_INFORMATION_IN_TMT_changeInCarrierRegion_CHANGED       | 200        | "Jio Maharashtra"    | "Vi India Maharashtra & Goa" | "CHANGED"             |
      | PHONE_BASIC_Sub_CARRIER_INFORMATION_IN_TMT_changeInCarrierRegion_NOT_CHANGED   | 200        | "Jio Karnataka"      | "Airtel Karnataka"           | "NOT_CHANGED"         |
      | PHONE_BASIC_Sub_CARRIER_INFORMATION_BR_TMT_changeInCarrierRegion_NOT_SUPPORTED | 200        | "CLARO S.A."         | "CLARO S.A."                 | "NOT_SUPPORTED"       |

  @PHONE_BASIC @CARRIER_INFORMATION @TMT @originalCarrier @localRoutingNumber @mobileCountryCode @mobileNetworkCode @networkName @serviceProfileId
  Scenario Outline:  DPI PHONE_BASIC_Sub_CARRIER_INFORMATION positive scenario for Indian region with validation of networkName - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/CARRIER_INFORMATION/<Scenario>.json")
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

    And match $.data.phone.basic.originalCarrier == <originalCarrier>

    And match $.data.phone.basic.currentNetwork == "#notnull"
    And match $.data.phone.basic.currentNetwork.localRoutingNumber == <localRoutingNumber>
    And match $.data.phone.basic.currentNetwork.mobileCountryCode == <mobileCountryCode>
    And match $.data.phone.basic.currentNetwork.mobileNetworkCode == <mobileNetworkCode>
    And match $.data.phone.basic.currentNetwork.networkName == "<networkName>"
    And match $.data.phone.basic.currentNetwork.serviceProfileId == "<serviceProfileId>"


    Examples:
      | Scenario                                                                                                    | statusCode | originalCarrier         | localRoutingNumber | mobileCountryCode | mobileNetworkCode | networkName                   | serviceProfileId |
      | PHONE_BASIC_Sub_CARRIER_INFORMATION_IN_TMT_networkName_JIO - Karnataka_with_max_7_ports                     | 200        | "Aircel - Karnataka"    | null               | "405"             | "861"             | JIO - Karnataka               | 91106            |
      | PHONE_BASIC_Sub_CARRIER_INFORMATION_IN_TMT_networkName_TATA - Karnataka_with_max_2_ports                    | 200        | "Airtel - Karnataka"    | null               | "405"             | "034"             | TATA - Karnataka              | 91191            |
      | PHONE_BASIC_Sub_CARRIER_INFORMATION_IN_TMT_networkName_Airtel_Karnataka_with_max_1_ports                    | 200        | "Vodafone - Karnataka"  | null               | "404"             | "45"              | Airtel - Karnataka            | 91031            |
      | PHONE_BASIC_Sub_CARRIER_INFORMATION_IN_TMT_networkName_Vodafone - Karnataka_with_max_1_ports                | 200        | "JIO - North East"      | null               | "404"             | "86"              | Vodafone - Karnataka          | 91241            |

      | PHONE_BASIC_Sub_CARRIER_INFORMATION_BR_TMT_networkName_CLARO S.A._with_max_0_ports                          | 200        | "CLARO S.A."            | null               | null              | null              | CLARO S.A.                    | 55321            |

      | PHONE_BASIC_Sub_CARRIER_INFORMATION_US_TMT_networkName_T-Mobile US-SVR-10X2_with_special_localRoutingNumber | 200        | "T-Mobile US-SVR-10X/2" | "9198055337"       | "310"             | "004"             | Verizon Wireless:6006 - SVR/2 | 151971           |

    #After discussion with roopa,Suggestion was to add YES,NO,Known for now and Our Automation is not handling fallback check for data partners
  @PHONE_BASIC @PHONE_STATUS @WDD @IPQS @TMT @Xconnect @active
  Scenario Outline:  DPI PHONE_BASIC_Sub_PHONE_STATUS positive scenario for Indian region with validation of active - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/PHONE_STATUS/<Scenario>.json")
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

    And match $.data.phone.basic.active == "<active>"

#  for BR : Data partner flow => WDD→ TMT-> X-connect.
#
#  for MX : Data partner flow => IPQS→ TMT-> X-connect.
#
#  for ID : Data partner flow => Indosat number then => INDOSAT DP→ TMT-> X-connect.
#                              => NON_Indosat number then => TMT-> X-connect.
#
#  for Other:  Data partner flow => TMT-> X-connect.

    Examples:
      | Scenario                                                | statusCode | active  |

      | PHONE_BASIC_Sub_PHONE_STATUS_NON_BRAZIL_US_PhoneNumber_TMT_UNKNOWN_Xconnect_active_yes_TC_68             | 200        | YES     |
      | PHONE_BASIC_Sub_PHONE_STATUS_NON_BRAZIL_US_PhoneNumber_TMT_UNKNOWN_Xconnect_active_UNKNOWN_TC69_TC70     | 200        | UNKNOWN |
      | PHONE_BASIC_Sub_PHONE_STATUS_BRAZIL_BR_PhoneNumber_WDD_UNKNOWN_TMT_UNKNOWN_Xconnect_active_UNKNOWN_TC_71 | 200        | UNKNOWN |
      | PHONE_BASIC_Sub_PHONE_STATUS_IN_PhoneNumber_TMT_YES_Xconnect_active_not_called_TC_72                     | 200        | YES     |

      | PHONE_BASIC_Sub_PHONE_STATUS_IN_PhoneNumber_TMT_UNKNOWN_Xconnect_active_UNKNOWN_TC_67                    | 200        | UNKNOWN |
      | PHONE_BASIC_Sub_PHONE_STATUS_NON_BRAZIL_US_PhoneNumber_TMT_YES_Xconnect_not_called                       | 200        | YES     |
      | PHONE_BASIC_Sub_PHONE_STATUS_NON_BRAZIL_US_PhoneNumber_TMT_YES_Xconnect_not_called                       | 200        | YES     |
      | PHONE_BASIC_Sub_PHONE_STATUS_MX_PhoneNumber_IPQS_return_active_YES                                       | 200        | YES     |

      | PHONE_BASIC_Sub_PHONE_STATUS_ID_INDOSAT_PhoneNumber_returns_active_YES_TC74                              | 200        | YES     |
      | PHONE_BASIC_Sub_PHONE_STATUS_ID_INDOSAT_PhoneNumber_returns_active_NO_TC75                               | 200        | NO      |
      | PHONE_BASIC_Sub_PHONE_STATUS_ID_INDOSAT_PhoneNumber_returns_active_NO_TC78                               | 200        | NO      |
      | PHONE_BASIC_Sub_PHONE_STATUS_ID_NON_INDOSAT_PhoneNumber_returns_active_YES_TC76                          | 200        | YES     |
      | PHONE_BASIC_Sub_PHONE_STATUS_ID_NON_INDOSAT_PhoneNumber_TMT_UNKNOWN_XConnect_returns_active_YES_TC77     | 200        | YES     |
      | PHONE_BASIC_Sub_PHONE_STATUS_ID_INDOSAT_PhoneNumber_returns_active_NO_TC75                               | 200        | NO      |



     #  https://monnai.atlassian.net/browse/MB-2865
     # | PHONE_BASIC_Sub_PHONE_STATUS_MX_PhoneNumber_IPQS_notreturn_TMT_notreturn_Xconnect_notreturn_null | 200        | YES     |


  @PHONE_BASIC @Negative
  Scenario Outline:  DPI PHONE_BASIC Negative scenario for validation of  individual PhoneNumber, countryCode separately - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/Negative_scenarios/<Scenario>.json")
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


    And match $.errors[0].package == <package>
    And match $.errors[0].message == <message>
    And match $.errors[0].code == "<code>"
    And match $.errors[0].type == "<type>"

    Examples:
      | Scenario                                                                            | statusCode | package       | message                              | code                               | type          |
      | PHONE_BASIC_Negative_scenarios_INVALID_PHONE_NUMBER                                 | 400        | "PHONE_BASIC" | "Invalid Phone Number"               | INVALID_PHONE_NUMBER               | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_INVALID_PHONE_NUMBER_as_junk_value                   | 400        | "PHONE_BASIC" | "Invalid Phone Number"               | INVALID_PHONE_NUMBER               | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE                   | 400        | "PHONE_BASIC" | "Invalid phone default country code" | INVALID_PHONE_DEFAULT_COUNTRY_CODE | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_INVALID_PHONE_DEFAULT_COUNTRY_CODE_FULL_COUNTRY_NAME | 400        | "PHONE_BASIC" | "Invalid phone default country code" | INVALID_PHONE_DEFAULT_COUNTRY_CODE | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_MISSING_PHONE_DEFAULT_COUNTRY_CODE_KEY               | 400        | "PHONE_BASIC" | "Missing phone default country code" | MISSING_PHONE_DEFAULT_COUNTRY_CODE | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_MISSING_PHONE_DEFAULT_COUNTRY_CODE_VALUE             | 400        | "PHONE_BASIC" | "Missing phone default country code" | MISSING_PHONE_DEFAULT_COUNTRY_CODE | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_MISSING_PHONE_NUMBER_KEY                             | 400        | "PHONE_BASIC" | "PhoneNumber cannot be blank/null"   | MISSING_PHONE_NUMBER               | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_MISSING_PHONE_NUMBER_VALUE                           | 400        | "PHONE_BASIC" | "PhoneNumber cannot be blank/null"   | MISSING_PHONE_NUMBER               | INVALID_INPUT |

  @PHONE_BASIC @Negative
  Scenario Outline:  DPI PHONE_BASIC Negative scenario for validation of PHONE_BASIC when package name is not specified  - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/Negative_scenarios/<Scenario>.json")
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
      | Scenario                                                       | statusCode | package | message                   | code                 | type          |
      | PHONE_BASIC_Negative_scenarios_When_Package_empty_Array        | 400        | null    | "package is not selected" | PACKAGE_NOT_SELECTED | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_When_Package_name_null          | 400        | null    | "package is not selected" | PACKAGE_NOT_SELECTED | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_When_Package_Key_is_not_present | 400        | null    | "package is not selected" | PACKAGE_NOT_SELECTED | INVALID_INPUT |
      | PHONE_BASIC_Negative_scenarios_When_Package_name_random        | 400        | null    | "invalid package name"    | INVALID_PACKAGE_NAME | INVALID_INPUT |


  @PHONE_BASIC @Negative
  Scenario Outline:  DPI PHONE_BASIC Negative scenario for validation of both PhoneNumber and countrycode togather- <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/Negative_scenarios/<Scenario>.json")
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

    And match $.meta.inputPhoneNumber == "##number"
    And match $.meta.cleansedPhoneNumber == "##string"
    And match $.meta.referenceId == "#string"
    And match $.meta.requestedPackages[0] == "PHONE_BASIC"

    And match $.errors[*].package contains any "PHONE_BASIC"
    And match $.errors[*].message contains any "PhoneNumber cannot be blank/null"
    And match $.errors[*].code contains any "MISSING_PHONE_NUMBER"
    And match $.errors[*].type contains any "INVALID_INPUT"

    And match $.errors[*].package contains any "PHONE_BASIC"
    And match $.errors[*].message contains any  "Missing phone default country code"
    And match $.errors[*].code contains any "MISSING_PHONE_DEFAULT_COUNTRY_CODE"
    And match $.errors[*].type contains any "INVALID_INPUT"

    Examples:
      | Scenario                                                                               | statusCode |
      | PHONE_BASIC_Negative_scenarios_MISSING_PHONE_NUMBER_MISSING_PHONE_DEFAULT_COUNTRY_CODE | 400        |


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
      | Scenario                                                        | statusCode |
      | PHONE_BASIC_Sub_topUpHistory_ID_HappyFlow                       | 200        |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_1 | 200        |

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
      | Scenario                                                            | statusCode | topUpCount |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_1     | 200        | 1          |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_max_9 | 200        | 8          |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_dpoint_topUpCount_max_48 | 200        | 48         |

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

    * def topUpArray = <No_of_array_objects>
    * print topUpArray
#    * match $.data.phone.basic.topUpHistory  == "#[topUpArray]"

    * match each $.data.phone.basic.topUpHistory contains { "currency": "IDR"}
    * match each $.data.phone.basic.topUpHistory contains { "topUpCount": '#? _ >=1'}

    * match each $.data.phone.basic.topUpHistory contains { "minimumTopUpAmount": '#? _ >=1000' }
    * match each $.data.phone.basic.topUpHistory contains { "maximumTopUpAmount": '#? _ >=1000' }
    * match each $.data.phone.basic.topUpHistory contains { "averageTopUpAmount": '#? _ >=1000' }

    * match $.data.phone.basic.topUpHistory == payload.response.data.phone.basic.topUpHistory
    * match $.meta == payload.response.meta

    Examples:
      | Scenario                                                                 | statusCode | No_of_array_objects |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_10 | 200        | 10                  |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_9  | 200        | 9                   |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_8  | 200        | 8                   |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_5  | 200        | 5                   |
#      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_3  | 200        | 3                   |
      | PHONE_BASIC_Sub_topUpHistory_ID_Phonenumber_topUpHistory_ArrayObjects_2  | 200        | 2                   |


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


  #CHECK - same as above scenario
  @PHONE_BASIC @topUpHistory @izidata @Negative
  Scenario Outline:  DPI PHONE_BASIC_Sub_topUpHistory Negative scenario for Indonesia region with validation of data-points in topUpHistory where  response is given by data partner as all response array    - <Scenario>
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

  @Schema_validation_1
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Schema_validation_1 - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/PHONE_INFORMATION/<Scenario>.json")
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
    And match $.data.phone.social == '#null'
    And match $.data.phone.basic == '#object'
    And match $.data.phone.identity == '#null'
    And match $.data.phone.basic contains deep {"phoneNumber":"#present","phoneValid":"#present","phoneType":"#present","phoneDisposable":"#present","active":"#present","activationDate":"#present","activeSinceXDays":"#present","simType":"#present","phoneNumberAge":"#present","phoneNumberAgeDescription":"#present","phoneTenure":"#object","country":"#present","originalCarrier":"#present","ported":"#present","lastDeactivated":"#present","isSpam":"#present","topUpHistory":"##present"}
    And match $.data.phone.basic.portedHistory contains deep {"portedDate":"#present","numberOfPorts":"#present","portedSinceXDays":"#present","currentCarrierCircle":"#present","originalCarrierCircle":"#present","changeInCarrierRegion":"#present"}
    And match $.data.phone.basic.portedHistory.portedEvents == '#array'
    And match $.data.phone.basic.currentNetwork contains deep {"localRoutingNumber":"#present","mobileCountryCode":"#present","mobileNetworkCode":"#present","networkName":"#present","serviceProfileId":"#present"}

    Examples:
      | Scenario                                                                       | statusCode |
      | PHONE_BASIC_Sub_PHONE_INFORMATION_region_India_phoneValid_phoneDisposable_true | 200        |

  @Schema_validation_1
  Scenario Outline:  DPI PHONE_BASIC_Sub_topUpHistory Negative scenario for Indonesia region with validation of data-points in topUpHistory where no response is given by datapoint  - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC/PHONE_INFORMATION/<Scenario>.json")
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

    Then match $ contains deep
    """
    {
	"data": {
		"phone": {
			"basic": {
				"phoneNumber": '#present',
				"phoneValid": '#present',
				"phoneType": '#present',
				"phoneDisposable": '#present',
				"active": '#present',
				"activationDate": '#present',
				"activeSinceXDays": '#present',
				"simType": '#present',
				"phoneNumberAge": '#present',
				"phoneNumberAgeDescription": '#present',
				"phoneTenure": '#object',
				"country": '#present',
				"originalCarrier": '#present',
				"ported": '#present',
				"portedHistory": {
					"portedDate": '#present',
					"numberOfPorts": '#present',
					"portedSinceXDays": '#present',
					"currentCarrierCircle": '#present',
					"originalCarrierCircle": '#present',
					"changeInCarrierRegion": '#present',
					"portedEvents": []
				},
				"currentNetwork": {
					"localRoutingNumber": '#present',
					"mobileCountryCode": '#present',
					"mobileNetworkCode": '#present',
					"networkName": '#present',
					"serviceProfileId": '#present'
				},
				"lastDeactivated": '#present',
				"isSpam": '#present',
				"topUpHistory": '##present'
			},
			"social": '#null',
			"identity": '#null'
		},
		"email": '#null',
		"address": '#null',
		"name": '#null',
		"ip": '#null',
		"identity": '#null',
		"upi": '#null',
		"device": '#null',
		"employment": '#null',
		"income": '#null',
		"blacklist": '#null',
		"bre": '#null'
	},
	"meta": {
		"inputPhoneNumber": '#present',
		"cleansedPhoneNumber": '#present',
		"referenceId": '#present',
		"requestedPackages": [
			"PHONE_BASIC"
		]
	},
	"errors": '#[0]'
}
    """

    Examples:
      | Scenario                                                                       | statusCode |
      | PHONE_BASIC_Sub_PHONE_INFORMATION_region_India_phoneValid_phoneDisposable_true | 200        |