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
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * match $ contains payload.response
    Then match $.meta contains payload.response.meta
 # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    Examples:
      | Scenario                                                                                                                        | statusCode |
      | AML_Verification_Package_INDIVIDUAL_matchFound_true_with_default_recordLimit_20_matchThreshold_80_noOfProfiles_1_totalRecords_1 | 200        |
#      | AML_Verification_Package_matchFound_true_VladimirPutin_with_recordLimit_50_matchThreshold_60                         | 200        |


  Scenario Outline: Validate DPI AML positive scenarios with input fields where there is no record found for input <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/AML/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * match $ contains payload.response
    Then match $.meta contains payload.response.meta
 # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces
    Examples:
      | Scenario                                          | statusCode |
      | AML_Verification_Package_INDIVIDUAL_kyc_is_null   | 200        |
      | AML_Verification_Package_ORGANISATION_kyc_is_null | 200        |
