Feature: Testing of DPI  - EMPLOYMENT_DETAILS feature scenarios

  Background:

    * configure charset = null
    * path '/api/insights/'Feature:

 @UAN_BASIC
  Scenario Outline: Validate DPI EMPLOYMENT_DETAILS Subpackage UAN_BASIC positive scenario  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMPLOYMENT_DETAILS/UAN_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
   # cloud watch traces -start
   * print karate.request.headers
   * print karate.response.headers
   * print karate.request.headers['x-reference-id']
   * def reference_id = karate.request.headers['x-reference-id']
   * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
   * print Cloud_Watch_Traces

    And match $.data.employment.details.pfVerification.summary.isEmployed == true
    And match $.data.employment.details.pfVerification == '#notnull'
    Then match $.data.employment contains payload.response.data.employment


    Examples:
      | Scenario                                                  | statusCode |
      | EMPLOYMENT_DETAILS_Sub_UAN_BASIC_  | 200        |