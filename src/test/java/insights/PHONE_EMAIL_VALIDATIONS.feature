 Feature: Testing of DPI  - Phone & Email Validations scenarios

   Background:
     * configure charset = null
     * path '/api/insights/'
     * def authFeature = call read('Auth_Token_Generation.feature')
     * def BearerToken = authFeature.authToken

   @smokeTest
   Scenario Outline:  DPI Identity Enrichment Scenarios of phone validations - <Scenario>
   Given url requestUrl
   And def payload = read("data/" + source + "/PHONE_EMAIL_VALIDATIONS/<Scenario>.json")
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
   And match $ contains payload.response

   Examples:
     | Scenario         | statusCode |
     | TC001            | 400        |
     | TC002            | 400        |
     | TC003            | 400        |
     | TC004            | 400        |
     | TC005            | 400        |
     | TC006            | 400        |
     | TC007            | 400        |
     | TC008            | 400        |
     | TC009            | 400        |
     | TC010            | 400        |
     | TC011            | 400        |
     | TC012            | 400        |