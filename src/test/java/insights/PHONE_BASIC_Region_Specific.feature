@PHONE_BASIC_FULL
Feature: Testing of DPI  - Phone_basic scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @PHONE_BASIC @smoke @all_data_partner @ported_prod_sanity
  Scenario Outline:  DPI PHONE_BASIC full package positive scenario for across regions with validation of full response - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_Region_Specific/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.phone.basic.portedHistory.portedSinceXDays = "#ignore"
    * set payload.response.data.phone.basic.activeSinceXDays = "#ignore"
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
    Then match $.data.phone.basic contains payload.response.data.phone.basic

    Examples:
      | Scenario                                                   | statusCode |
      | PHONE_BASIC_response_region_Singapore_SG                   | 200        |
      | PHONE_BASIC_response_region_Thailand_TH_with_ported        | 200        |
      | PHONE_BASIC_response_region_Thailand_TH_without_ported     | 200        |
      | PHONE_BASIC_response_region_Philippines_PH                 | 200        |
      | PHONE_BASIC_response_region_Malaysia_MY                    | 200        |
      | PHONE_BASIC_response_region_Indonesia_ID                   | 200        |

      | PHONE_BASIC_response_region_BRAZIL_BR_without_ported       | 200        |
      | PHONE_BASIC_response_region_UnitedStates_US_with_ported    | 200        |
      | PHONE_BASIC_response_region_UnitedStates_US_without_ported | 200        |
      | PHONE_BASIC_response_region_MEXICO_MX_with_ported          | 200        |
      | PHONE_BASIC_response_region_MEXICO_MX_without_ported       | 200        |
      | PHONE_BASIC_response_region_India_IN                       | 200        |

      | PHONE_BASIC_response_region_BRAZIL_BR_with_ported          | 200        |
#  PH(639058248748), SG(6596610822) , MY(60129279293),GB(447826292229),CY(35796898016) -( TMT is returning"porting_history": "n/a"- seems region not supported)
#
#  BR(554730385113) ,FR(33622788226),NL(31703923875),US(19193456619)-Seems TMT retuned [] meaning region is supported by TMT
#
#  VN(84389879520) ,ID(6282220000000) - Seems TMT retuned [] meaning region is supported by TMT (we have not got data)

  @PHONE_BASIC @smoke @all_data_partner
  Scenario Outline:  DPI PHONE_BASIC full package positive scenario for across regions with validation of full response - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/PHONE_BASIC_Region_Specific/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.phone.basic.portedHistory.portedSinceXDays = "#ignore"
    * set payload.response.data.phone.basic.activeSinceXDays = "#ignore"
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
    Then match $.data.phone.basic contains payload.response.data.phone.basic


    Examples:
      | Scenario                                                  | statusCode |
      | PHONE_BASIC_response_region_Vietnam_VN                    | 200        |
      | PHONE_BASIC_response_region_Malaysia_MY                   | 200        |
      | PHONE_BASIC_response_region_Cyprus_CY                     | 200        |

      | PHONE_BASIC_response_region_UnitedKingdom_GB              | 200        |
      | PHONE_BASIC_response_region_Italy_IT_with_ported          | 200        |
      | PHONE_BASIC_response_region_Italy_IT_without_ported       | 200        |

      | PHONE_BASIC_response_region_FRANCE_FR_with_ported         | 200        |
      | PHONE_BASIC_response_region_FRANCE_FR_without_ported      | 200        |
      | PHONE_BASIC_response_region_Netherlands_NL_with_ported    | 200        |
      | PHONE_BASIC_response_region_Netherlands_NL_without_ported | 200        |
