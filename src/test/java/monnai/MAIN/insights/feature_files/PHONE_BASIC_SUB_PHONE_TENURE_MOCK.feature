@PHONE_BASIC_SUB_PHONE_TENURE_MOCK @MOCK
Feature: MOCK -> Testing of DPI - Phone_basic sub package PHONE_TENURE MOCK scenarios for ID region

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

    
  Scenario Outline:MOCK -> Testing PHONE_TENURE scenarios data partners fall back for ID region
    Given url requestUrl
    And def payload = read( "../" + source + "/Z_MOCK_PHONE_BASIC_SUB_PHONE_TENURE/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/vnd.monnai.mock.v2.0+json"
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
    Examples:
      | Scenario                                                                                                                                                     | statusCode | activationDate | activeSinceXDays | phoneNumberAge | phoneNumberAgeDescription | phoneTenure | phoneTenure_min | phoneTenure_max |

      #        | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_phoneNumberAge_1_phoneNumberAgeDescription_Below_3_Months_phoneTenure_1_2          | 200        | "#null"        | "#null"          | 1              | "Below 3 Months"          | "#notnull"  | 2               | 3               |
      #  Non-indosat     | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_phoneNumberAge_2_phoneNumberAgeDescription_3_to_6_Months_phoneTenure_4_5           | 200        | "#null"        | "#null"          | 2              | "3 to 6 Months"           | "#notnull"  | 4               | 5               |
      #      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_phoneNumberAge_3_phoneNumberAgeDescription_6_to_12_Months_phoneTenure_8_10         | 200        | "#null"        | "#null"          | 3              | "6 to 12 Months"          | "#notnull"  | 8               | 10              |
      #      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_phoneNumberAge_3_phoneNumberAgeDescription_6_to_12_Months_phoneTenure_10_12        | 200        | "#null"        | "#null"          | 3              | "6 to 12 Months"          | "#notnull"  | 10              | 12              |
      #      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_phoneNumberAge_4_phoneNumberAgeDescription_12_to_24_Months_phoneTenure_12_24       | 200        | "#null"        | "#null"          | 4              | "12 to 24 Months"         | "#notnull"  | 12              | 24              |
      #    628561731975
      #        | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_phoneNumberAge_5_phoneNumberAgeDescription_24_to_36_Months_phoneTenure_24_36       | 200        | "#null"        | "#null"          | 5              | "24 to 36 Months"         | "#notnull"  | 24              | 36              |
      #      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_phoneNumberAge_6_phoneNumberAgeDescription_Above_36_Months_phoneTenure_36_null     | 200        | "#null"        | "#null"          | 6              | "Above 36 Months"         | "#notnull"  | 36              | null            |
      #      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_INDOSAT_NUMBER_phoneNumberAge_null_phoneNumberAgeDescription_null_phoneTenure_null                | 200        | "#null"        | "#null"          | null           | null                      | "#null"     | "#notpresent"   | "#notpresent"   |


      # for below test cases added mock for izidata partner - 01H63M3M35NE02S2S0Y4CB7K09 -izidata_phoneage_v3
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_1_phoneNumberAgeDescription_Below_3_Months_phoneTenure_1_2      | 200        | "#null"        | "#null"          | 1              | "Below 3 Months"          | "#notnull"  | 1               | 2               |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_2_phoneNumberAgeDescription_3_to_6_Months_phoneTenure_4_5       | 200        | "#null"        | "#null"          | 2              | "3 to 6 Months"           | "#notnull"  | 4               | 5               |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_3_phoneNumberAgeDescription_6_to_12_Months_phoneTenure_6_8      | 200        | "#null"        | "#null"          | 3              | "6 to 12 Months"          | "#notnull"  | 6               | 8               |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_3_phoneNumberAgeDescription_6_to_12_Months_phoneTenure_8_10     | 200        | "#null"        | "#null"          | 3              | "6 to 12 Months"          | "#notnull"  | 8               | 10              |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_3_phoneNumberAgeDescription_6_to_12_Months_phoneTenure_10_12    | 200        | "#null"        | "#null"          | 3              | "6 to 12 Months"          | "#notnull"  | 10              | 12              |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_4_phoneNumberAgeDescription_12_to_24_Months_phoneTenure_12_24   | 200        | "#null"        | "#null"          | 4              | "12 to 24 Months"         | "#notnull"  | 12              | 24              |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_5_phoneNumberAgeDescription_24_to_36_Months_phoneTenure_24_36   | 200        | "#null"        | "#null"          | 5              | "24 to 36 Months"         | "#notnull"  | 24              | 36              |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_6_phoneNumberAgeDescription_Above_24_Months_phoneTenure_36_null | 200        | "#null"        | "#null"          | 6              | "Above 36 Months"         | "#notnull"  | 36              | null            |
      | PHONE_BASIC_Sub_PHONE_TENURE_Monnai_Derived_for_country_ID_NON_INDOSAT_NUMBER_phoneNumberAge_null_phoneNumberAgeDescription_null_phoneTenure_null            | 200        | "#null"        | "#null"          | null           | null                      | "#null"     | "#notpresent"   | "#notpresent"   |

  # 01H59C8RQXXBWKN96B6Q3XEP78 - AsliRi Phone Age
  # 01GS9WPEQTWWHN5GE9AQ1VVKA0 - TMT
  #01H5SHKJWTEASSH4Z0GQDGX6Y9 - indosat_tenure
  #01H3VRG72GYJQNBP8KT6A31J9Z - izidata_phone_topUpBehavior
  # 01H63M3M35NE02S2S0Y4CB7K09 -izidata_phoneage_v3


  # 01GS9WPEQTWWHN5GE9AQ1VVKA0 - TMT
  # 01H080GAQ57DJ58CF5R3BYHKDN - Xconnect
  # 01HMTGDSMM68TSXE0EVCYSJ8W3 - indosat_deactivation
  # 01H59C8RQXXBWKN96B6Q3XEP78 - izidata_phoneage_v3

  #  01H5SHKJWTEASSH4Z0GQDGX6Y9 - indosat_tenure
  #  01H5Q0GFVRJJHZS0STT5DDG0K2 - indosat_prepaid
  #  01H3VRG72GYJQNBP8KT6A31J9Z - izidata_phone_topUpBehavior

  #  01GS9WPEQTWWHN5GE9AQ1VVKA0 - TMT Phone
  #  01H59C8RQXXBWKN96B6Q3XEP78 - AsliRi Phone Age
  #  ds - indosat_tenure
  #

  #  for ID numbers
  #
  #  TELKOMSEL PREFIX:
  #  '851', '852', '853', '811', '812', '813', '821', '822', '823'
  #
  #  HUTCH 3 PREFIX:
  #  '895', '896', '897', '898', '899'
  #
  #  XL PREFIX:
  #  '817', '818', '819', '831', '832', '833', '838', '859', '877', '878', '879'
  #
  #  INDOSAT PREFIX:
  #  '814', '815', '816', '855', '856', '857', '858'
  #
  #  PT Indosat (Source : Telephone numbers in Indonesia )
  #     IM3 (Prepaid and Postpaid) prefix: 814, 815, 816, 855, 856, 857, 858.
  #     3 Indonesia (merged with Indosat) prefix: 895, 896, 897, 898, 899.

  #01H5SHKJWTEASSH4Z0GQDGX6Y9
  #01H5Q0GFVRJJHZS0STT5DDG0K2
  #01HMTGDSMM68TSXE0EVCYSJ8W3
  #01H5HNMAC0X160B925RFG0J23P
  #01H63M3M35NE02S2S0Y4CB7K09
  #01GTK64PA63X2QYXJR1SRTXGSA
  #01H3VRG72GYJQNBP8KT6A31J9Z
  #01GS9WPEQTWWHN5GE9AQ1VVKA0
  #01H080GAQ57DJ58CF5R3BYHKDN
  #01H59C8RQXXBWKN96B6Q3XEP78