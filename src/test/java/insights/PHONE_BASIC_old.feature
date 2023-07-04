Feature: Testing of DPI  - Phone_basic and Phone_social scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

#  Scenario Outline:  DPI PHONE_BASIC positive scenario with different regions - <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/PHONE_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    * print payload.request
#    * print payload.response
#    * print karate.pretty(response)
#    Then status <statusCode>
#    Then match $ contains payload.response
#    Examples:
#      | Scenario                                   | statusCode |
#      | Phone_Basic_Positive_with_BrazilNumber     | 200        |
#      | Phone_Basic_Positive_with_GBNumber         | 200        |
#      | Phone_Basic_Positive_with_IndianNumber     | 200        |
#      | Phone_Basic_Positive_with_IndonesianNumber | 200        |
#      | Phone_Basic_Positive_with_ITNumber         | 200        |
#      | Phone_Basic_Positive_with_MalaysiaNumber   | 200        |
#      | Phone_Basic_Positive_with_PhillipineNumber | 200        |
#      | Phone_Basic_Positive_with_SGNumber         | 200        |
#      | Phone_Basic_Positive_with_USNumber         | 200        |
#      | Phone_Basic_Positive_with_VietnamNumber    | 200        |
#
#
#  Scenario Outline:  DPI PHONE_BASIC positive scenarios across different Data points - <Scenario>
#    Given url requestUrl
#    And def payload = read("data/" + env + "/PHONE_BASIC/<Scenario>.json")
#    And headers headers
#    And request payload.request
#    When method POST
#    * print payload.request
#    * print payload.response
#    * print karate.pretty(response)
#    Then status <statusCode>
#    Then match $ contains payload.response
#    Examples:
#      | Scenario                                                                                                                      | statusCode |
#      | Phone_Basic_Positive_ChangeInCarrier_NOTCHANGED                                                                               | 200        |
#      | Phone_Basic_Positive_IsSpamIs_Null_RegionOtherThen_India                                                                      | 200        |
#      | Phone_Basic_Positive_PhoneTenureIsCalculated_WhenPortedInformationIsNotReturned_ButLastDeactivateddateisReturned_IndianNumber | 200        |
#      | Phone_Basic_Positive_PhoneTypeIs_Mobile                                                                                       | 200        |
#      | Phone_Basic_Positive_Were_ActiveStatusIs_NO                                                                                   | 200        |
#      | Phone_Basic_Positive_Were_ActiveStatusIs_UNKNOWN                                                                              | 200        |
#      | Phone_Basic_Positive_Were_ActiveStatusIs_YES                                                                                  | 200        |
##      | Phone_Basic_Positive_Were_ChangeInCarrierCircleIs_CHANGED                                                                     | 200        |
#      | Phone_Basic_Positive_Were_ChangeInCarrierCircleIs_NOT_CHANGED                                                                  | 200        |
#      | Phone_Basic_Positive_Were_ChangeInCarrierCircleIs_NOT_SUPPORTED                                                             | 200        |
#      | Phone_Basic_Positive_were_changeInCarrierIs_NOTSUPPORTED_forregionOtherThenIndia                                              | 200        |
#      | Phone_Basic_Positive_were_DeactivationStatusIs_Present                                                                        | 200        |
#      | Phone_Basic_Positive_Were_PhoneDisaposable_True                                                                               | 200        |
#      | Phone_Basic_Positive_Were_PhoneTypeIs_FIXEDLINE                                                                               | 200        |
#      | Phone_Basic_Positive_Were_PhoneTypeIs_MOBILE                                                                                  | 200        |
#      | Phone_Basic_Positive_Were_PortedIsTrue_But_PortingDate_PortingHistoryNull                                                     | 200        |
#      | Phone_Basic_Positive_WerePhoneTenureisReturnedFor_IndianNumber_WithPortedInformation                                          | 200        |
#      | Phone_Basic_Positive_with_BrazilNumberWere_FallBackFrom_WDDToTMT                                                              | 200        |
#      | Phone_Basic_Positive_with_DeactivationIs_NULL                                                                                 | 200        |
#      | Phone_Basic_Positive_with_IsSpamIsFalseFor_IndianNumber                                                                       | 200        |
#      | Phone_Basic_Positive_with_SimTypeIs_POSTPAID                                                                                  | 200        |
#      | Phone_Basic_Positive_with_IsSpamIsTrueFor_IndianNumber                                                                        | 200        |
#      | Phone_Basic_Positive_WithoutPortedDetails                                                                                     | 200        |
#
#
#
#
#
#
#    #  @PHONE_BASIC @PORTED_DETAILS @TMT @ported @portedDate @numberOfPorts @portedSinceXDays
##  Scenario Outline:  DPI PHONE_BASIC_Sub_PORTED_DETAILS positive scenario for Indian region with validation of ported  - <Scenario>
##    Given url requestUrl
##    And def payload = read("data/" + env + "/PHONE_BASIC/PORTED_DETAILS/<Scenario>.json")
##    And headers headers
##    And request payload.request
##    When method POST
##    * print payload.request
##    * print payload.response
##    * print karate.pretty(response)
##    Then status <statusCode>
##    And match $.data.phone.basic == '#notnull'
##
##    * def given_us_ported_false_portedHistory =
##    """
##    {
##            "portedDate": "2022-08-10",
##            "numberOfPorts": 2,
##            "portedSinceXDays":'#number',
##            "currentCarrierCircle": "Verizon Verizon Wireless",
##            "originalCarrierCircle": "Verizon Verizon Wireless",
##            "changeInCarrierRegion": "NOT_SUPPORTED",
##            "portedEvents": [
##              {
##                "carrierCircle": null,
##                "portedDate": "2022-08-10"
##              },
##              {
##                "carrierCircle": null,
##                "portedDate": "2022-08-09"
##              }
##            ]
##          }
##    """
##    * def given_us_ported_true_portedHistory =
##    """
##    {
##            "portedDate": "2020-04-12",
##            "numberOfPorts": 3,
##            "portedSinceXDays": 1169,
##            "currentCarrierCircle": "Verizon Verizon Wireless",
##            "originalCarrierCircle": "T-Mobile T-Mobile US",
##            "changeInCarrierRegion": "NOT_SUPPORTED",
##            "portedEvents": [
##              {
##                "carrierCircle": null,
##                "portedDate": "2020-04-12"
##              },
##              {
##                "carrierCircle": null,
##                "portedDate": "2016-05-11"
##              },
##              {
##                "carrierCircle": null,
##                "portedDate": "2016-05-11"
##              }
##            ]
##          }
##    """
##
##
##
###    * def given_us_ported_true_portedHistory = {"portedDate":"2022-08-10","numberOfPorts":2,"portedSinceXDays":'#number',"currentCarrierCircle":"Verizon Verizon Wireless","originalCarrierCircle":"Verizon Verizon Wireless","changeInCarrierRegion":"NOT_SUPPORTED","portedEvents":[{"carrierCircle":null,"portedDate":"2022-08-10"},{"carrierCircle":null,"portedDate":"2022-08-09"}]}
##
##
##
##
##    And match $.data.phone.basic.portedHistory contains  <given>
##
##    Examples:
##      | Scenario                                                                                     | statusCode | given                               |
##      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_US_ported_portedDate_numberOfPorts_portedSinceXDays_true  | 200        | given_us_ported_true_portedHistory  |
##      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_US_ported_portedDate_numberOfPorts_portedSinceXDays_false | 200        | given_us_ported_false_portedHistory |
#
#  #one foiled portedSinceXDays is dynamic so data will fail.
##  @PHONE_BASIC @PORTED_DETAILS @TMT @ported @portedDate @numberOfPorts @portedSinceXDays
##  Scenario Outline:  DPI PHONE_BASIC_Sub_PORTED_DETAILS positive scenario for Indian region with validation of ported  - <Scenario>
##    Given url requestUrl
##    And def payload = read("data/" + env + "/PHONE_BASIC/PORTED_DETAILS/<Scenario>.json")
##    And headers headers
##    And request payload.request
###    * set payload.response.data.phone.basic.portedHistory.portedSinceXDays = "#number"
##    * set payload.response.meta.referenceId = "#ignore"
##    When method POST
##    * print payload.request
##    * print payload.response
##    * print karate.pretty(response)
##    Then status <statusCode>
##    And match $.data.phone.basic == '#notnull'
##    And match $.data.phone.basic.portedHistory.portedSinceXDays == "#present"
##
###    And match payload.response.data.phone.basic contains only  $.data.phone.basic
###    And match payload.response.meta contains  $.meta
##    And match $.meta contains payload.response.meta
##
##
##    Examples:
##      | Scenario                                                                                     | statusCode |
##      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_US_ported_portedDate_numberOfPorts_portedSinceXDays_true  | 200        |
##      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_US_ported_portedDate_numberOfPorts_portedSinceXDays_false | 200        |
##      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_IN_ported_portedDate_numberOfPorts_portedSinceXDays_true  | 200        |
##      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_IN_ported_portedDate_numberOfPorts_portedSinceXDays_false | 200        |
##      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_BR_ported_portedDate_numberOfPorts_portedSinceXDays_true  | 200        |
##      | PHONE_BASIC_Sub_PORTED_DETAILS_TMT_BR_ported_portedDate_numberOfPorts_portedSinceXDays_false | 200        |
