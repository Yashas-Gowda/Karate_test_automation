@AML_FULL @regTest_4 @KYC
Feature: Testing of DPI  - Verification AML Package scenarios

  Background:
    * configure charset = null
    * path '/api/verification/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken



  Scenario Outline: Validate DPI AML positive scenarios with all input fields <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AML/<Scenario>.json")
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
    #    Then match payload.response.data.kyc.aml contains only $.data.kyc.aml
    Then match $.data.kyc.aml.summary contains {"matchFound": true,"noOfProfiles": "#number","totalRecords": "#number"}
    Then match payload.response.data.kyc.aml.records == '#[_ > 0]'
    Then match $.meta contains payload.response.meta
    Then match $.errors contains only payload.response.errors
    Examples:
      | Scenario                                                                                                                        | statusCode |
      | AML_Verification_Package_INDIVIDUAL_matchFound_true_with_default_recordLimit_20_matchThreshold_80_noOfProfiles_1_totalRecords_1 | 200        |


  Scenario Outline: Validate DPI AML positive scenarios with input fields where there are records found for input <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AML/<Scenario>.json")
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
    #    Then match payload.response.data.kyc.aml contains only $.data.kyc.aml
    Then match $.data.kyc.aml.summary contains {"matchFound": true,"noOfProfiles": "#number","totalRecords": "#number"}
    Then match payload.response.data.kyc.aml.records == '#[_ > 0]'
    Then match $.meta contains payload.response.meta
    Then match $.errors contains only payload.response.errors
    Then match $.meta contains payload.response.meta
    Examples:
      | Scenario                                              | statusCode |
      | AML_Verification_Package_ORGANISATION_kyc_is_not_null | 200        |
  #  https://monnai.atlassian.net/browse/MB-4377   | AML_Verification_Package_Positive_kyc_with_dateOfBirth_YYYY_MM_DD_format | 200        |

  Scenario Outline: Validate DPI AML INDIVIDUAL positive scenarios with input fields where  "noOfProfiles": 472,"totalRecords": 974   <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AML/<Scenario>.json")
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

    #    Then match payload.response.data.kyc.aml contains only $.data.kyc.aml
    Then match $.data.kyc.aml.summary contains {"matchFound": true,"noOfProfiles": "#number","totalRecords": "#number"}
    Then match payload.response.data.kyc.aml.records == '#[_ > 0]'
    Then match $.meta contains payload.response.meta
    Then match $.errors contains only payload.response.errors
    Examples:
      | Scenario                                                                                     | statusCode |
      # Data partner query  | AML_Verification_Package_INDIVIDUAL_kyc_default_recordLimit_20_matchThreshold_80             | 200        |
      | AML_Verification_Package_matchFound_true_VladimirPutin_with_recordLimit_50_matchThreshold_60 | 200        |


  Scenario Outline: Validate DPI AML INDIVIDUAL positive scenarios with input fields where recordLimit,matchThreshold values for max and min from monnai validation <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AML/<Scenario>.json")
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
    #    Then match payload.response.data.kyc.aml contains only $.data.kyc.aml
    Then match $.data.kyc.aml.summary contains {"matchFound": true,"noOfProfiles": "#number","totalRecords": "#number"}
    Then match payload.response.data.kyc.aml.records == '#[_ > 0]'
    Then match $.meta contains payload.response.meta
    Then match $.errors contains only payload.response.errors
    Examples:
      | Scenario                                                        | statusCode |
      | AML_Verification_Package_Positive_kyc_recordLimit_is_default    | 200        |
      | AML_Verification_Package_Positive_kyc_matchThreshold_is_default | 200        |
      | AML_Verification_Package_Positive_kyc_dateOfBirth_is_default    | 200        |

  # Below scenarios are commented beacuse there is no validation added at DPI side, for now valdiation is added from partner end
  #  Scenario Outline: Validate DPI AML INDIVIDUAL Negative scenarios with input fields where recordLimit,matchThreshold values for max+1 and min-1 from monnai validation <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../" + source + "/AML/Negative/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
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
  #    Then status <statusCode>
  #    Then match $.meta contains payload.response.meta
  #    Then match $.data.kyc contains payload.response.data.kyc
  #    Then match $.errors contains only deep payload.response.errors
  #
  #
  #    Examples:
  #      | Scenario | statusCode |
  #  #      | AML_Verification_Package_Negative_kyc_recordLimit_is_more_then_max_51     | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_recordLimit_is_less_then_min_0      | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_recordLimit_is_negative             | 400        |
  #  ##  https://monnai.atlassian.net/browse/MB-4386
  #  #      | AML_Verification_Package_Negative_kyc_matchThreshold_is_more_then_max_101 | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_matchThreshold_is_less_then_min_49  | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_matchThreshold_is_negative          | 400        |
  #
  #  #  https://monnai.atlassian.net/browse/MB-4375 | AML_Verification_Package_Negative_kyc_fullGivenName_with_5_characters           | 400        |
  #  #   https://monnai.atlassian.net/browse/MB-4375      | AML_Verification_Package_Negative_kyc_fullGivenName_with_less_then_5_characters | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_fullGivenName_key_is_missing        | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_fullGivenName_value_is_null         | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_fullGivenName_value_is_empty_string | 400        |
  #  #
  #  #      | AML_Verification_Package_Negative_kyc_entityType_with_abc                 | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_entityType_with_123                 | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_entityType_with_123abc              | 400        |
  #
  #  #      | AML_Verification_Package_Negative_kyc_dateOfBirth_with_DD_MM_YYYY_format  | 400        |
  #  #      | AML_Verification_Package_Negative_kyc_dateOfBirth_with_YYYY_format        | 400        |
  #  #  https://monnai.atlassian.net/browse/MB-4379 | AML_Verification_Package_Negative_kyc_dateOfBirth_with_value_123        | 400        |
  #  #  https://monnai.atlassian.net/browse/MB-4378     | AML_Verification_Package_Negative_kyc_dateOfBirth_with_year_less_then_1900 | 400        |


  Scenario Outline: Validate DPI AML INDIVIDUAL positive scenarios with input fields when KYC is null <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AML/<Scenario>.json")
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
    Then match $.meta contains payload.response.meta
    Then match $.data.kyc contains payload.response.data.kyc

    Examples:
      | Scenario                                          | statusCode |
      | AML_Verification_Package_INDIVIDUAL_kyc_is_null   | 200        |
      | AML_Verification_Package_ORGANISATION_kyc_is_null | 200        |


  Scenario Outline: Validate DPI AML INDIVIDUAL positive scenarios with input fields where type PEP  validation <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/AML/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken

    And request payload.request
    * set payload.response.data.kyc.aml.records[*].profileId = "#ignore"
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
    * def Actual_type = get $.data.kyc.aml.records[*].type
    * print Actual_type
    * def Expected_type = [<type>]
    * print Expected_type

    * match Actual_type contains Expected_type
    #    * assert Actual_type.contains('<expected_type>')
    #    * match ("<expected_type>") contains any Actual_type
    #    Then match payload.response.data.kyc.aml contains only $.data.kyc.aml
    Then match $.data.kyc.aml.summary contains {"matchFound": true,"noOfProfiles": "#number","totalRecords": "#number"}
    Then match payload.response.data.kyc.aml.records == '#[_ > 0]'
    Then match $.meta contains payload.response.meta
    Then match $.errors contains only payload.response.errors

    Examples:
      | Scenario                                                | statusCode | type      |
      | AML_Verification_Package_INDIVIDUAL_with_type_PEP       | 200        | PEP       |
      # for below data RCA is changed to SANCTION
      | AML_Verification_Package_INDIVIDUAL_with_type_RCA       | 200        | SANCTION  |
      | AML_Verification_Package_INDIVIDUAL_with_type_SANCTION  | 200        | SANCTION  |
      | AML_Verification_Package_INDIVIDUAL_with_type_WATCHLIST | 200        | WATCHLIST |
      | AML_Verification_Package_INDIVIDUAL_with_type_WANTED    | 200        | WANTED    |
      | AML_Verification_Package_INDIVIDUAL_with_type_SIP       | 200        | SIP       |

