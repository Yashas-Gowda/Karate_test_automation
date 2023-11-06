@aml
Feature: Testing of DPI  - Verification AML Package scenarios

  Background:
    * configure charset = null
    * path '/api/verification/'


  @smokeTest @smokeTest
  Scenario Outline: Validate DPI AML positive scenarios with all input fields <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/AML/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
      # request/response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match payload.response.data.kyc.aml contains only $.data.kyc.aml
    Then match $.meta contains payload.response.meta

    Examples:
      | Scenario                                                                                                                        | statusCode |
      | AML_Verification_Package_INDIVIDUAL_matchFound_true_with_default_recordLimit_20_matchThreshold_80_noOfProfiles_1_totalRecords_1 | 200        |


  Scenario Outline: Validate DPI AML positive scenarios with input fields where there is no record found for input <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/AML/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # request/response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match payload.response.data.kyc.aml contains only $.data.kyc.aml
    Then match $.meta contains payload.response.meta
    Examples:
      | Scenario                                                                                     | statusCode |
      | AML_Verification_Package_ORGANISATION_kyc_is_not_null                                        | 200        |

  Scenario Outline: Validate DPI AML INDIVIDUAL positive scenarios with input fields where  "noOfProfiles": 472,"totalRecords": 974   <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/AML/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # request/response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $.meta contains payload.response.meta
    Then match payload.response.data.kyc.aml.summary contains only $.data.kyc.aml.summary
    Examples:
      | Scenario                                                                                     | statusCode |
    # Data partner query  | AML_Verification_Package_INDIVIDUAL_kyc_default_recordLimit_20_matchThreshold_80             | 200        |
      | AML_Verification_Package_matchFound_true_VladimirPutin_with_recordLimit_50_matchThreshold_60 | 200        |

  Scenario Outline: Validate DPI AML INDIVIDUAL positive scenarios with input fields where recordLimit,matchThreshold values for max and min from monnai validation <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/AML/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    # Sanction scaner should not be called in the cloud watch traces
    * print Cloud_Watch_Traces
    # request/response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>

    Then match $ contains payload.response


    Examples:
      | Scenario                                                                  | statusCode |

      | AML_Verification_Package_INDIVIDUAL_kyc_is_null                           | 200        |
      | AML_Verification_Package_ORGANISATION_kyc_is_null                         | 200        |

      | AML_Verification_Package_Negative_kyc_recordLimit_is_more_then_max_51     | 200        |
# Data partner not honouring limit     | AML_Verification_Package_Negative_kyc_recordLimit_is_less_then_min_0      | 200        |
      | AML_Verification_Package_Negative_kyc_recordLimit_is_negative             | 200        |
      | AML_Verification_Package_Negative_kyc_recordLimit_is_default              | 200        |

      | AML_Verification_Package_Negative_kyc_matchThreshold_is_more_then_max_101 | 200        |
      | AML_Verification_Package_Negative_kyc_matchThreshold_is_less_then_min_49  | 200        |
      | AML_Verification_Package_Negative_kyc_matchThreshold_is_negative          | 200        |
      | AML_Verification_Package_Negative_kyc_matchThreshold_is_default           | 200        |

  Scenario Outline: Validate DPI AML INDIVIDUAL positive scenarios with input fields when KYC is null <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/AML/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # request/response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>

    Then match $ contains payload.response
    Examples:
      | Scenario                                                                  | statusCode |
      | AML_Verification_Package_INDIVIDUAL_kyc_is_null                           | 200        |
      | AML_Verification_Package_ORGANISATION_kyc_is_null                         | 200        |


  Scenario Outline: Validate DPI AML INDIVIDUAL positive scenarios with input fields where type PEP  validation <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/AML/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    # request/response
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * def Actual_type = get $.data.kyc.aml.records[*].type
    * print Actual_type
    * def Expected_type = [<type>]
    * print Expected_type
    * match Actual_type contains Expected_type
#    * assert Actual_type.contains('<expected_type>')
#    * match ("<expected_type>") contains any Actual_type
    Then match payload.response.data.kyc.aml contains only $.data.kyc.aml
    Then match $.meta contains payload.response.meta


    Examples:
      | Scenario                                                | statusCode | type      |
      | AML_Verification_Package_INDIVIDUAL_with_type_PEP       | 200        | PEP       |
      | AML_Verification_Package_INDIVIDUAL_with_type_SANCTION  | 200        | SANCTION  |
      | AML_Verification_Package_INDIVIDUAL_with_type_WATCHLIST | 200        | WATCHLIST |
      | AML_Verification_Package_INDIVIDUAL_with_type_WANTED    | 200        | WANTED    |

