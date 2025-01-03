@KYC_GOVERNMENT @regTest_4 @KYC

Feature: Testing of DPI  - Verification KYC_MOBILE Package scenarios

  Background:
    * configure charset = null
    * path '/api/verification/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  #  @KYC_GOVERNMENT_TH
  Scenario Outline: Validate DPI KYC_GOVERNMENT positive scenarios with all input fields  for Country Thailand (TH) <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_GOVERNMENT/TH/<Scenario>.json")
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
    Then match $.data.kyc.mobile == "#null"
    Then match $.data.kyc.consumer == "#null"
    Then match $.data.kyc.aml == "#null"
    Then match $.data.kyc.government.matchMiddleName == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchFullGivenName == "NOT_SUPPORTED"

    Then match $.data.kyc.government.matchGender == "NOT_SUPPORTED"

    Then match $.data.kyc.government.matchId2 == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchId3 == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchId4 == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchId5 == "NOT_SUPPORTED"

    Then match $.data.kyc.government.matchBuildingNumber == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchBuildingName == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchUnitNumber == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchStreetName == "NOT_SUPPORTED"


    Then match $.data.kyc.government.matchPoBox == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchCity == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchState == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchCountry == "NOT_SUPPORTED"

    Then match $.data.kyc.government.matchAdditionalAddressField3 == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchPhone == "NOT_SUPPORTED"
    Then match $.data.kyc.government.matchEmail == "NOT_SUPPORTED"

    Then match payload.response.data.kyc.government contains only $.data.kyc.government
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors


    Examples:
      | Scenario                                                                                                                                                                                                                                       | statusCode |
      | KYC_GOVERNMENT_Thailand_TH_input_firstName_lastName_dateOfBirth_id1_addressLine1_city_output_matchAddressLine1_NO_DATA_matchAddressLine2_matchAdditionalAddressField1_matchAdditionalAddressField2_NO_INPUT                                    | 200        |
      | KYC_GOVERNMENT_Thailand_TH_input_firstName_lastName_dateOfBirth_id1_addressLine1_city_output_matchFirstName_matchLastName_matchDateOfBirth_matchId1_MATCH_matchAddressLine2_matchAdditionalAddressField1_matchAdditionalAddressField2_NO_INPUT | 200        |
#      | KYC_GOVERNMENT_Thailand_TH_input_firstName_lastName_dateOfBirth_id1_addressLine1_city_output_matchLastName_matchDateOfBirth_matchId1_MATCH_matchFirstName_NO_MATCH_matchAddressLine1_NO_DATA                                                   | 200        |
#      | KYC_GOVERNMENT_Thailand_TH_input_firstName_lastName_dateOfBirth_id1_output_matchDateOfBirth_matchId1_MATCH_matchFirstName_matchLastName_NO_MATCH                                                                                               | 200        |
#
#  #  @KYC_GOVERNMENT_TH
#  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country Thailand (TH) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/TH/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#    Then match $.data.kyc.government == "#null"
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#
#    Examples:
#      | Scenario                                                  | statusCode |
#      | KYC_GOVERNMENT_Thailand_TH_input_firstName_empty_string   | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_firstName_with_space     | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_Key_firstName_missing    | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_firstName_with_null      | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Thailand_TH_input_firstName_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Thailand_TH_input_firstName_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Thailand_TH_input_lastName_empty_string    | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_lastName_with_space      | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_Key_lastName_missing     | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_lastName_with_null       | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Thailand_TH_input_lastName_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Thailand_TH_input_lastName_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Thailand_TH_input_dateOfBirth_empty_string | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_dateOfBirth_with_space   | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_Key_dateOfBirth_missing  | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_dateOfBirth_with_null    | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Thailand_TH_input_dateOfBirth_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Thailand_TH_input_dateOfBirth_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Thailand_TH_input_id1_empty_string         | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_id1_with_space           | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_Key_id1_missing          | 400        |
#      | KYC_GOVERNMENT_Thailand_TH_input_id1_with_null            | 400        |
#  # https://monnai.atlassian.net/browse/MB-5814
#  #      | KYC_GOVERNMENT_Thailand_TH_input_id1_with_number                                   | 400        |
#  #      | KYC_GOVERNMENT_Thailand_TH_input_id1_with_bollean                                  | 400        |
#  #      | KYC_GOVERNMENT_Thailand_TH_input_id1_with_alphanumaric                                  | 400        |
#
#  #  @KYC_GOVERNMENT_IN
#  Scenario Outline: Validate DPI KYC_GOVERNMENT positive scenarios with all input fields  for Country India (IN) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/IN/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#    Then match payload.response.data.kyc.government contains only $.data.kyc.government
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#
#    Examples:
#      | Scenario                                                                                                                                                                      | statusCode |
#      | KYC_GOVERNMENT_India_IN_input_idType_PSP_firstName_lastName_fullGivenName_dateOfBirth_id1_id2_output_matchFirstName_matchLastName_matchDateOfBirth_matchId1_matchId2_MATCH    | 200        |
#      | KYC_GOVERNMENT_India_IN_input_idType_PSP_firstName_lastName_fullGivenName_dateOfBirth_id1_id2_output_matchFirstName_matchLastName_matchDateOfBirth_matchId1_matchId2_NO_MATCH | 200        |
#
#  @KYC_GOVERNMENT_IN
#  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country India (IN) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/IN/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#    Then match $.data.kyc.government == "#null"
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#
#    Examples:
#      | Scenario                                               | statusCode |
#      | KYC_GOVERNMENT_India_IN_input_idType_empty_string      | 400        |
#      | KYC_GOVERNMENT_India_IN_input_idType_with_space        | 400        |
#      | KYC_GOVERNMENT_India_IN_input_Key_idType_missing       | 400        |
#      | KYC_GOVERNMENT_India_IN_input_idType_with_null         | 400        |
#      | KYC_GOVERNMENT_India_IN_input_idType_with_number       | 400        |
#      | KYC_GOVERNMENT_India_IN_input_idType_with_bollean      | 400        |
#      | KYC_GOVERNMENT_India_IN_input_idType_with_alphanumaric | 400        |
#
#
#      | KYC_GOVERNMENT_India_IN_input_firstName_empty_string   | 400        |
#      | KYC_GOVERNMENT_India_IN_input_firstName_with_space     | 400        |
#      | KYC_GOVERNMENT_India_IN_input_Key_firstName_missing    | 400        |
#      | KYC_GOVERNMENT_India_IN_input_firstName_with_null      | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_India_IN_input_firstName_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_India_IN_input_firstName_with_bollean                                  | 400        |
#
#
#      | KYC_GOVERNMENT_India_IN_input_lastName_empty_string    | 400        |
#      | KYC_GOVERNMENT_India_IN_input_lastName_with_space      | 400        |
#      | KYC_GOVERNMENT_India_IN_input_Key_lastName_missing     | 400        |
#      | KYC_GOVERNMENT_India_IN_input_lastName_with_null       | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_India_IN_input_lastName_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_India_IN_input_lastName_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_India_IN_input_dateOfBirth_empty_string | 400        |
#      | KYC_GOVERNMENT_India_IN_input_dateOfBirth_with_space   | 400        |
#      | KYC_GOVERNMENT_India_IN_input_Key_dateOfBirth_missing  | 400        |
#      | KYC_GOVERNMENT_India_IN_input_dateOfBirth_with_null    | 400        |
#      #     https://monnai.atlassian.net/browse/MB-5815
#      #      |  KYC_GOVERNMENT_India_IN_input_dateOfBirth_with_number                                   | 400        |
#
#
#      | KYC_GOVERNMENT_India_IN_input_id1_empty_string         | 400        |
#      | KYC_GOVERNMENT_India_IN_input_id1_with_space           | 400        |
#      | KYC_GOVERNMENT_India_IN_input_Key_id1_missing          | 400        |
#      | KYC_GOVERNMENT_India_IN_input_id1_with_null            | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      | KYC_GOVERNMENT_India_IN_input_id1_with_number          | 400        |
#      | KYC_GOVERNMENT_India_IN_input_id1_with_bollean         | 400        |
#
#      | KYC_GOVERNMENT_India_IN_input_id2_empty_string         | 400        |
#      | KYC_GOVERNMENT_India_IN_input_id2_with_space           | 400        |
#      | KYC_GOVERNMENT_India_IN_input_Key_id2_missing          | 400        |
#      | KYC_GOVERNMENT_India_IN_input_id2_with_null            | 400        |
#  # https://monnai.atlassian.net/browse/MB-5814
#  #      | KYC_GOVERNMENT_India_IN_input_id2_with_number                                   | 400        |
#  #      | KYC_GOVERNMENT_India_IN_input_id2_with_bollean                                  | 400        |
#
#  #  @KYC_GOVERNMENT_IN
#  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country India (IN) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/IN/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    #    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    #    Then match $.data.kyc.mobile == "#null"
#    #    Then match $.data.kyc.consumer == "#null"
#    #    Then match $.data.kyc.aml == "#null"
#    #
#    #    Then match $.data.kyc.government == "#null"
#    Then match $.data == "#null"
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#
#    Examples:
#      | Scenario                                               | statusCode |
#      | KYC_GOVERNMENT_India_IN_input_dateOfBirth_with_bollean | 400        |
#
#  @KYC_GOVERNMENT_PH
#  Scenario Outline: Validate DPI KYC_GOVERNMENT positive scenarios with all input fields  for Country Philippines (PH) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/PH/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#    Then match $.data.kyc.government.matchFullGivenName == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchGender == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchId2 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchId3 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchId4 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchId5 == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchBuildingNumber == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchBuildingName == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchUnitNumber == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchStreetName == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchPoBox == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchCity == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchState == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchCountry == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchPostalCode == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchAdditionalAddressField1 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchAdditionalAddressField2 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchAdditionalAddressField3 == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchPhone == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchEmail == "NOT_SUPPORTED"
#
#    Then match payload.response.data.kyc.government contains only $.data.kyc.government
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#
#    Examples:
#      | Scenario | statusCode |
#  # data not found     | KYC_GOVERNMENT_Philippines_PH_input_firstName_lastName_dateOfBirth_id1_output_matchDateOfBirth_matchId1_MATCH_matchFirstName_matchLastName_NO_MATCH | 200        |
#  # data not found        | KYC_GOVERNMENT_Philippines_PH_input_firstName_lastName_dateOfBirth_id1_output_matchDateOfBirth_matchId1_MATCH_matchFirstName_matchLastName_NO_MATCH_Thailand_TH_input_firstName_lastName_dateOfBirth_id1_addressLine1_city_output_matchLastName_matchDateOfBirth_matchId1_MATCH_matchFirstName_NO_MATCH_matchAddressLine1_NO_DATA | 200        |
#
#  #  @KYC_GOVERNMENT_PH
#  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country Philippines (PH) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/PH/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#    Then match $.data.kyc.government == "#null"
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#    Examples:
#      | Scenario                                                     | statusCode |
#      | KYC_GOVERNMENT_Philippines_PH_input_idType_empty_string      | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_idType_with_space        | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_Key_idType_missing       | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_idType_with_null         | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Philippines_PH_input_idType_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Philippines_PH_input_idType_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Philippines_PH_input_id1_empty_string         | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_id1_with_space           | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_Key_id1_missing          | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_id1_with_null            | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Philippines_PH_input_id1_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Philippines_PH_input_id1_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Philippines_PH_input_firstName_empty_string   | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_firstName_with_space     | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_firstName_with_null      | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Philippines_PH_input_firstName_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Philippines_PH_input_firstName_with_bollean                                  | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_Key_firstName_missing    | 400        |
#
#      | KYC_GOVERNMENT_Philippines_PH_input_lastName_empty_string    | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_lastName_with_space      | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_lastName_with_null       | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Philippines_PH_input_lastName_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Philippines_PH_input_lastName_with_bollean                                  | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_Key_lastName_missing     | 400        |
#
#      | KYC_GOVERNMENT_Philippines_PH_input_dateOfBirth_empty_string | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_dateOfBirth_with_space   | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_dateOfBirth_with_null    | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Philippines_PH_input_dateOfBirth_with_number                                   | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_Key_dateOfBirth_missing  | 400        |
#
#  #  @KYC_GOVERNMENT_PH
#  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country Philippines (PH) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/PH/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    #    Then match $.data.kyc.mobile == "#null"
#    #    Then match $.data.kyc.consumer == "#null"
#    #    Then match $.data.kyc.aml == "#null"
#    #
#    #    Then match $.data.kyc.government == "#null"
#    Then match $.data == "#null"
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta == "#null"
#    Then match $.errors contains payload.response.errors
#
#
#    Examples:
#      | Scenario                                                                  | statusCode |
#      | KYC_GOVERNMENT_Philippines_PH_input_dateOfBirth_with_bollean              | 400        |
#      | KYC_GOVERNMENT_Philippines_PH_input_dateOfBirth_with_alphanumaric_invalid | 400        |
#
#
#  @KYC_GOVERNMENT_ID
#  Scenario Outline: Validate DPI KYC_GOVERNMENT positive scenarios with all input fields  for Country Indonesia (ID)  <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/ID/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#    Then match $.data.kyc.government.matchFirstName == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchMiddleName == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchLastName == "NOT_SUPPORTED"
#
#    #    Then match $.data.kyc.government.matchGender == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchId2 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchId3 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchId4 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchId5 == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchBuildingNumber == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchBuildingName == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchUnitNumber == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchStreetName == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchPoBox == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchCity == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchState == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchCountry == "NOT_SUPPORTED"
#
#    #    Then match $.data.kyc.government.matchPostalCode == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchAdditionalAddressField1 == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchAdditionalAddressField3 == "NOT_SUPPORTED"
#
#    Then match $.data.kyc.government.matchPhone == "NOT_SUPPORTED"
#    Then match $.data.kyc.government.matchEmail == "NOT_SUPPORTED"
#
#    Then match payload.response.data.kyc.government contains only $.data.kyc.government
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#
#    Examples:
#      | Scenario                                                                                                                                                                                                   | statusCode |
#      | KYC_GOVERNMENT_Indonesia_ID_input_all_mandatory_optional_datapoints_output_matchFullGivenName_matchDateOfBirth_matchGender_matchId1_matchAddressLine1_matchAddressLine2_matchAdditionalAddressField2_MATCH | 200        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_all_mandatory_datapoints_output_matchFullGivenName_matchDateOfBirth_matchGender_matchId1_matchAddressLine1_matchAddressLine2_matchAdditionalAddressField2_MATCH          | 200        |
#
#  #  @KYC_GOVERNMENT_ID
#  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country Indonesia (ID) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/ID/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#    Then match $.data.kyc.government == "#null"
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#    Examples:
#      | Scenario                                                     | statusCode |
#      | KYC_GOVERNMENT_Indonesia_ID_input_id1_empty_string           | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_id1_with_space             | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_Key_id1_missing            | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_id1_with_null              | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Indonesia_ID_input_id1_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Indonesia_ID_input_id1_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Indonesia_ID_input_fullGivenName_empty_string | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_fullGivenName_with_space   | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_Key_fullGivenName_missing  | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_fullGivenName_with_null    | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Indonesia_ID_input_fullGivenName_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Indonesia_ID_input_fullGivenName_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Indonesia_ID_input_dateOfBirth_empty_string   | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_dateOfBirth_with_space     | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_dateOfBirth_with_null      | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Indonesia_ID_input_dateOfBirth_with_number                                   | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_Key_dateOfBirth_missing    | 400        |
#
#  #  @KYC_GOVERNMENT_ID
#  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country Indonesia (ID) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/ID/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    #    Then match $.data.kyc.mobile == "#null"
#    #    Then match $.data.kyc.consumer == "#null"
#    #    Then match $.data.kyc.aml == "#null"
#    #
#    #    Then match $.data.kyc.government == "#null"
#    Then match $.data == "#null"
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta == "#null"
#    Then match $.errors contains payload.response.errors
#
#    Examples:
#      | Scenario                                                                | statusCode |
#      | KYC_GOVERNMENT_Indonesia_ID_input_dateOfBirth_with_bollean              | 400        |
#      | KYC_GOVERNMENT_Indonesia_ID_input_dateOfBirth_with_alphanumaric_invalid | 400        |
#
#  @KYC_GOVERNMENT_MY
#  Scenario Outline: Validate DPI KYC_GOVERNMENT positive scenarios with all input fields  for Country Malaysia (MY)  <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/MY/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#
#    Then match payload.response.data.kyc.government contains only $.data.kyc.government
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#
#    Examples:
#      | Scenario                                                                                                                                         | statusCode |
#      | KYC_GOVERNMENT_Malaysia_MY_input_mandatory_with_optional_output_matchFullGivenName_matchDateOfBirth_matchGender_matchId1_matchAddressLine1_MATCH | 200        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_with_only_mandatory_output_matchFullGivenName_matchDateOfBirth_matchGender_matchId1_matchAddressLine1_MATCH     | 200        |
#
#  #  @KYC_GOVERNMENT_MY
#  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country Malaysia (MY) <Scenario>
#    Given url requestUrl
#    And def payload = read( "../" + source + "/KYC_GOVERNMENT/MY/<Scenario>.json")
#    And headers headers
#    And header Authorization = BearerToken
#    And request payload.request
#    * set payload.response.meta.referenceId = "#ignore"
#    When method POST
#    # cloud watch traces -start
#    * print karate.request.headers
#    * print karate.response.headers
#    * print karate.request.headers['x-reference-id']
#    * def reference_id = karate.request.headers['x-reference-id']
#    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
#    * print Cloud_Watch_Traces
#    # ResponseTime
#    * print 'responseTime----->',responseTime
#    # request/response
#    * print 'API Request----->',payload.request
#    * print 'Expected Response---->',payload.response
#    * print 'Actual Response---->',karate.pretty(response)
#    Then status <statusCode>
#    Then match $.data.kyc.mobile == "#null"
#    Then match $.data.kyc.consumer == "#null"
#    Then match $.data.kyc.aml == "#null"
#
#    Then match $.data.kyc.government == "#null"
#    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
#    Then match $.meta contains payload.response.meta
#    Then match $.errors contains payload.response.errors
#
#    Examples:
#      | Scenario                                                    | statusCode |
#      | KYC_GOVERNMENT_Malaysia_MY_input_id1_empty_string           | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_id1_with_space             | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_Key_id1_missing            | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_id1_with_null              | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Malaysia_MY_input_id1_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Malaysia_MY_input_id1_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Malaysia_MY_input_fullGivenName_empty_string | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_fullGivenName_with_space   | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_Key_fullGivenName_missing  | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_fullGivenName_with_null    | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Malaysia_MY_input_fullGivenName_with_number                                   | 400        |
#      #      | KYC_GOVERNMENT_Malaysia_MY_input_fullGivenName_with_bollean                                  | 400        |
#
#      | KYC_GOVERNMENT_Malaysia_MY_input_dateOfBirth_empty_string   | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_dateOfBirth_with_space     | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_dateOfBirth_with_null      | 400        |
#      # https://monnai.atlassian.net/browse/MB-5814
#      #      | KYC_GOVERNMENT_Malaysia_MY_input_dateOfBirth_with_number                                   | 400        |
#      | KYC_GOVERNMENT_Malaysia_MY_input_Key_dateOfBirth_missing    | 400        |
#

  #  @KYC_GOVERNMENT_MY
  Scenario Outline: Validate DPI KYC_GOVERNMENT Negative scenarios with all input fields  for Country Malaysia (MY) <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/KYC_GOVERNMENT/MY/<Scenario>.json")
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
    #    Then match $.data.kyc.mobile == "#null"
    #    Then match $.data.kyc.consumer == "#null"
    #    Then match $.data.kyc.aml == "#null"
    #
    #    Then match $.data.kyc.government == "#null"
    Then match $.data == "#null"
    Then match payload.response.data.kyc.mobile.appendedFields contains only $.data.kyc.mobile.appendedFields
    Then match $.meta == "#null"
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                                                               | statusCode |
      | KYC_GOVERNMENT_Malaysia_MY_input_dateOfBirth_with_bollean              | 400        |
      | KYC_GOVERNMENT_Malaysia_MY_input_dateOfBirth_with_alphanumaric_invalid | 400        |


