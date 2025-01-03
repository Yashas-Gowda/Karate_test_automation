@KYC_MOBILE @regTest_4 @KYC

Feature: Testing of DPI  - Verification KYC_MOBILE Package scenarios

  Background:
    * configure charset = null
    * path '/api/verification/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  #  @KYC_MOBILE_region_ID
  Scenario Outline: Validate DPI KYC_MOBILE positive scenarios with all input fields  for Country ID <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/ID/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyc.government == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.mobile.matchFirstName == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchMiddleName == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchLastName == "NOT_SUPPORTED"

    Then match $.data.kyc.mobile.matchAddress == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchAddressLine1 == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchId1 == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchStreet == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchCity == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchPostalCode == "NOT_SUPPORTED"


    Then match payload.response.data.kyc.mobile contains only $.data.kyc.mobile
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors


    Examples:
      | Scenario                                                                                                                                                                     | statusCode |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_dateOfBirth_phoneNumber_output_matchFullGivenName_matchPhoneNumber_MATCH_matchDateOfBirth_NO_MATCH                               | 200        |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_dateOfBirth_phoneNumber_output_matchFullGivenName_NO_MATCH_matchDateOfBirth_matchPhoneNumber_MATCH_with_appendedFields_validName | 200        |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_dateOfBirth_phoneNumber_output_matchFullGivenName_matchDateOfBirth_NO_DATA_matchPhoneNumber_NO_MATCH                             | 200        |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_dateOfBirth_phoneNumber_output_matchFullGivenName_matchDateOfBirth_matchPhoneNumber_MATCH                                        | 200        |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_dateOfBirth_phoneNumber_output_matchFullGivenName_matchDateOfBirth_NO_MATCH_matchPhoneNumber_MATCH_with_appendedFields_validName | 200        |



  #  @KYC_MOBILE_region_ID
  Scenario Outline: Validate DPI KYC_MOBILE Negative scenarios with all input fields for Country ID <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/ID/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyc.government == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.aml == "#null"

    Then match $.data.kyc.mobile == "#null"
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                 | statusCode |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_empty_string | 400        |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_with_space   | 400        |
      | KYC_MOBILE_Indonesia_ID_input_Key_fullGivenName_missing  | 400        |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_empty_string | 400        |
      | KYC_MOBILE_Indonesia_ID_input_fullGivenName_with_space   | 400        |
      | KYC_MOBILE_Indonesia_ID_input_Key_fullGivenName_missing  | 400        |




  #  @KYC_MOBILE_region_FR
  Scenario Outline: Validate DPI KYC_MOBILE positive scenarios with all input fields  for Country FR <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/FR/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyb == "#null"
    Then match $.data.kyc.government == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.mobile.matchMiddleName == "NOT_SUPPORTED"

    Then match $.data.kyc.mobile.matchAddressLine1 == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchId1 == "NOT_SUPPORTED"

    Then match $.data.kyc.mobile.matchStreetNumber == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchStreet == "NOT_SUPPORTED"

    Then match payload.response.data.kyc.mobile contains only $.data.kyc.mobile
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors


    Examples:
      | Scenario                                                                                                                                                            | statusCode |
      | KYC_MOBILE_France_FR_output_matchFirstName_matchLastName_matchFullGivenName_matchDateOfBirth_matchPhoneNumber_matchAddress_matchCity_matchPostalCode_MATCH          | 200        |
      | KYC_MOBILE_France_FR_output_matchFirstName_matchLastName_matchFullGivenName_matchDateOfBirth_matchAddress_matchCity_matchPostalCode_NO_MATCH_matchPhoneNumber_MATCH | 200        |
      | KYC_MOBILE_France_FR_output_matchPostalCode_NO_DATA                                                                                                                 | 200        |
      | KYC_MOBILE_France_FR_output_matchFirstName_matchLastName_matchFullGivenName_matchDateOfBirth_matchAddress_matchCity_matchPostalCode_NO_DATA                         | 200        |

      | KYC_MOBILE_France_FR_output_When_input_optional_field_dateOfBirth_value_null                                                                                        | 200        |
      | KYC_MOBILE_France_FR_output_When_input_optional_field_city_value_null                                                                                               | 200        |
      | KYC_MOBILE_France_FR_output_When_input_optional_field_streetNumber_value_null                                                                                       | 200        |
      | KYC_MOBILE_France_FR_output_When_input_optional_field_streetName_value_null                                                                                         | 200        |


  #  @KYC_MOBILE_region_FR
  Scenario Outline: Validate DPI KYC_MOBILE positive scenarios with all input fields  for Country FR <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/FR/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyb == "#null"
    Then match $.data.kyc.government == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.aml == "#null"


    Then match payload.response.data.kyc.mobile == null
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors


    Examples:
      | Scenario                                | statusCode |
      | KYC_MOBILE_France_FR_output_mobile_null | 200        |


  #  @KYC_MOBILE_region_FR
  Scenario Outline: Validate DPI KYC_MOBILE Negative scenarios with all input fields for Country FR <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/FR/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyc.government == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.aml == "#null"

    Then match $.data.kyc.mobile == "#null"
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                           | statusCode |
      | KYC_MOBILE_France_FR_input_firstName_empty_string  | 400        |
      | KYC_MOBILE_France_FR_input_firstName_with_space    | 400        |
      | KYC_MOBILE_France_FR_input_Key_firstName_missing   | 400        |
      #    https://monnai.atlassian.net/browse/MB-5685
      #      | KYC_MOBILE_France_FR_input_firstName_with_number                                    | 400        |
      #      | KYC_MOBILE_France_FR_input_firstName_with_bollen                                    | 400        |

      | KYC_MOBILE_France_FR_input_lastName_empty_string   | 400        |
      | KYC_MOBILE_France_FR_input_lastName_with_space     | 400        |
      | KYC_MOBILE_France_FR_input_Key_lastName_missing    | 400        |
      #    https://monnai.atlassian.net/browse/MB-5685
      #      | KYC_MOBILE_France_FR_input_lastName_with_number                                    | 400        |
      #      | KYC_MOBILE_France_FR_input_lastName_with_bollen                                    | 400        |

      | KYC_MOBILE_France_FR_input_postalCode_empty_string | 400        |
      | KYC_MOBILE_France_FR_input_postalCode_with_space   | 400        |
      | KYC_MOBILE_France_FR_input_Key_postalCode_missing  | 400        |
  #    https://monnai.atlassian.net/browse/MB-5685
  #      | KYC_MOBILE_France_FR_input_postalCode_with_number                                    | 400        |
  #      | KYC_MOBILE_France_FR_input_postalCode_with_bollen                                    | 400        |


  #  @KYC_MOBILE_region_DE
  Scenario Outline: Validate DPI KYC_MOBILE positive scenarios with all input fields  for Country DE <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/DE/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyb == "#null"
    Then match $.data.kyc.government == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.mobile.matchMiddleName == "NOT_SUPPORTED"

    Then match $.data.kyc.mobile.matchAddressLine1 == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchId1 == "NOT_SUPPORTED"

    Then match $.data.kyc.mobile.matchStreetNumber == "NOT_SUPPORTED"
    Then match $.data.kyc.mobile.matchStreet == "NOT_SUPPORTED"

    Then match payload.response.data.kyc.mobile contains only $.data.kyc.mobile
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors


    Examples:
      | Scenario                                                                                                                                                             | statusCode |
      | KYC_MOBILE_Germany_DE_output_matchFirstName_matchLastName_matchFullGivenName_matchDateOfBirth_matchPhoneNumber_matchAddress_matchCity_matchPostalCode_MATCH          | 200        |
      | KYC_MOBILE_Germany_DE_output_matchFirstName_matchLastName_matchFullGivenName_matchDateOfBirth_matchAddress_matchCity_matchPostalCode_NO_MATCH_matchPhoneNumber_MATCH | 200        |
      | KYC_MOBILE_Germany_DE_output_matchFirstName_matchLastName_matchFullGivenName_matchDateOfBirth_matchAddress_matchCity_matchPostalCode_NO_DATA                         | 200        |

      | KYC_MOBILE_Germany_DE_output_When_input_optional_field_dateOfBirth_value_null                                                                                        | 200        |
      | KYC_MOBILE_Germany_DE_output_When_input_optional_field_city_value_null                                                                                               | 200        |
      | KYC_MOBILE_Germany_DE_output_When_input_optional_field_streetNumber_value_null                                                                                       | 200        |
      | KYC_MOBILE_Germany_DE_output_When_input_optional_field_streetName_value_null                                                                                         | 200        |


  #  @KYC_MOBILE_region_DE
  Scenario Outline: Validate DPI KYC_MOBILE Negative scenarios with all input fields for Country DE <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/DE/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyc.government == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.aml == "#null"

    Then match $.data.kyc.mobile == "#null"
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                            | statusCode |
      | KYC_MOBILE_Germany_DE_input_firstName_empty_string  | 400        |
      | KYC_MOBILE_Germany_DE_input_firstName_with_space    | 400        |
      | KYC_MOBILE_Germany_DE_input_Key_firstName_missing   | 400        |
      #    https://monnai.atlassian.net/browse/MB-5685
      #      | KYC_MOBILE_Germany_DE_input_firstName_with_number                                    | 400        |
      #      | KYC_MOBILE_Germany_DE_input_firstName_with_bollen                                    | 400        |

      | KYC_MOBILE_Germany_DE_input_lastName_empty_string   | 400        |
      | KYC_MOBILE_Germany_DE_input_lastName_with_space     | 400        |
      | KYC_MOBILE_Germany_DE_input_Key_lastName_missing    | 400        |
      #    https://monnai.atlassian.net/browse/MB-5685
      #      | KYC_MOBILE_France_FR_input_lastName_with_number                                    | 400        |
      #      | KYC_MOBILE_France_FR_input_lastName_with_bollen                                    | 400        |

      | KYC_MOBILE_Germany_DE_input_postalCode_empty_string | 400        |
      | KYC_MOBILE_Germany_DE_input_postalCode_with_space   | 400        |
      | KYC_MOBILE_Germany_DE_input_Key_postalCode_missing  | 400        |
  #    https://monnai.atlassian.net/browse/MB-5685
  #      | KYC_MOBILE_France_FR_input_postalCode_with_number                                    | 400        |
  #      | KYC_MOBILE_France_FR_input_postalCode_with_bollen                                    | 400        |


  #  @KYC_MOBILE_neg
  Scenario Outline: Validate DPI KYC_MOBILE Negative scenarios with all input fields for all the Country  <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyc.government == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.aml == "#null"

    Then match $.data.kyc.mobile == "#null"
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                  | statusCode |
      | KYC_MOBILE_input_phoneNumber_empty_string | 400        |
      | KYC_MOBILE_input_phoneNumber_with_space   | 400        |
      | KYC_MOBILE_input_phoneNumber_key_missing  | 400        |


  #  @KYC_MOBILE_neg
  Scenario Outline: Validate DPI KYC_MOBILE Negative scenarios with all input fields for all the Country  <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_MOBILE/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # request/response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $.data.kyc == "#null"
    Then match $.data.kyb == "#null"

    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                               | statusCode |
      | KYC_MOBILE_input_phoneDefaultCountryCode_empty_string  | 400        |
      | KYC_MOBILE_input_phoneDefaultCountryCode_with_space    | 400        |
      | KYC_MOBILE_input_phoneDefaultCountryCode_key_missing   | 400        |

      | KYC_MOBILE_input_phoneDefaultCountryCode_value_abc     | 400        |
      | KYC_MOBILE_input_phoneDefaultCountryCode_value_abc123  | 400        |
      | KYC_MOBILE_input_phoneDefaultCountryCode_value_123     | 400        |
      | KYC_MOBILE_input_phoneDefaultCountryCode_value_bollean | 400        |

      | KYC_MOBILE_input_phoneNumber_value_abc                 | 400        |
      | KYC_MOBILE_input_phoneNumber_value_abc123              | 400        |
      | KYC_MOBILE_input_phoneNumber_value_123                 | 400        |
      | KYC_MOBILE_input_phoneNumber_value_bollean             | 400        |




