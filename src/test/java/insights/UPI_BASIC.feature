Feature: Testing of DPI  - UPI_BASIC feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @smokeTest
  Scenario Outline:  UPI BASIC POSITIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then match $ contains payload.response
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                 | statusCode |
      | UPI_BASIC_sc_@ybl        | 200        |
      | UPI_BASIC_sc_@ibl        | 200        |
      | UPI_BASIC_sc_@axl        | 200        |
      | UPI_BASIC_sc_@paytm      | 200        |
      | UPI_BASIC_sc_@oksbi      | 200        |
      | UPI_BASIC_sc_@okaxis     | 200        |
      | UPI_BASIC_sc_@okicici    | 200        |
      | UPI_BASIC_sc_@okhdfcbank | 200        |

  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    * match $.errors[*].message contains any "Missing UPI address"
    * match $.errors[*].message contains any "Invalid UPI address"

    * match $.errors[*].code contains any "MISSING_UPI"
    * match $.errors[*].code contains any "INVALID_UPI"
    Then match $ contains any payload.response
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario              | statusCode |
      | UPI_BASIC_sc_Ne_noUpi | 400        |

  @smokeTest
  Scenario Outline:  UPI BASIC NEGATIVE SC's Insights <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/UPI_BASIC/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * match $.errors[0].message contains any "Invalid UPI address"
    * match $.errors[0].code contains any "INVALID_UPI"
    Then match $ contains  payload.response
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22"+reference_id+"*22)~context~(timeRange~(delta~21600000)))"
    * print Cloud_Watch_Traces

    Examples:
      | Scenario                 | statusCode |
      | UPI_BASIC_sc_Ne_nohandle | 400        |
