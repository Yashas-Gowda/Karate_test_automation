Feature: Testing of DPI  - Identity_Enrichment scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @smokeTest
  Scenario Outline:  DPI Identity Enrichment Scenarios for region India - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/IDENTITY_ENRICHMENT/<Scenario>.json")
    And headers headers
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
    And match $.data.identity.enrichment == '#notnull'
    Then match $.data.identity.enrichment contains payload.response.data.identity.enrichment

    Examples:
      | Scenario | statusCode |
      | TC001    | 200        |
      | TC002    | 200        |
      | TC003    | 200        |
      | TC004    | 200        |
      | TC005    | 200        |
      | TC006    | 200        |
      | TC007    | 200        |
      | TC008    | 200        |

  @smokeTest
  Scenario Outline:  DPI Identity Enrichment Scenarios for region Brazil - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/IDENTITY_ENRICHMENT/<Scenario>.json")
    And headers headers
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
    And match $.data.identity.enrichment == '#notnull'
    Then match $.data.identity.enrichment contains payload.response.data.identity.enrichment


    Examples:
      | Scenario | statusCode |
      | TC009    | 200        |
      | TC010    | 200        |
      | TC012    | 200        |

  @smokeTest
  Scenario Outline:  DPI Identity Enrichment Scenarios for region Indonesia - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/IDENTITY_ENRICHMENT/<Scenario>.json")
    And headers headers
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
    And match $.data.identity.enrichment == '#notnull'
    Then match $ contains payload.response
    Examples:
      | Scenario | statusCode |
      | TC014    | 200        |
      | TC015    | 200        |
      | TC016    | 200        |
      | TC017    | 200        |
      | TC018    | 200        |
         # | TC021            | 200        |
          #| TC022            | 200        |
  Scenario Outline:  DPI Identity Enrichment Scenarios for region Indonesia - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/IDENTITY_ENRICHMENT/<Scenario>.json")
    And headers headers
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
    And match $.data.identity.enrichment == '#notnull'
    Then match $.data.identity.enrichment contains payload.response.data.identity.enrichment


    Examples:
      | Scenario | statusCode |
      | TC014    | 200        |
      | TC015    | 200        |
      | TC016    | 200        |
      | TC017    | 200        |
      | TC018    | 200        |
      | TC021    | 200        |
      | TC022    | 200        |

  @smokeTest
  Scenario Outline:  DPI Identity Enrichment Scenarios for other Regions (US,MX, TH, PH, MY) - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/IDENTITY_ENRICHMENT/<Scenario>.json")
    And headers headers
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
    And match $.data.identity.enrichment == '#notnull'
    Then match $.data.identity.enrichment contains payload.response.data.identity.enrichment


    Examples:
      | Scenario | statusCode |
      | TC025    | 200        |
      | TC026    | 200        |
      | TC027    | 200        |
      | TC028    | 200        |
      | TC029    | 200        |


  @smokeTest
  Scenario Outline:  DPI Identity Enrichment Scenarios for null responses - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/IDENTITY_ENRICHMENT/<Scenario>.json")
    And headers headers
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
    And match $.data.identity.enrichment contains payload.response.data.identity.enrichment

    Examples:
      | Scenario | statusCode |
      | TC011    | 200        |
      | TC013    | 200        |
      | TC019    | 200        |
      | TC020    | 200        |
      | TC024    | 200        |