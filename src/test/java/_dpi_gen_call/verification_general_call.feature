@gen_verification
Feature: DEVICE_DETAILS MOBILE WALLA Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * path '/api/verification/'
    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario: Verification DPI general call
    Given url requestUrl
    And def requestPayload =
      """
      {
        "eventType": "ACCOUNT_CREATION",
        "entityType": "INDIVIDUAL",
        "userDetails": {
          "fullGivenName": "Vladimir Putin",
          "dateOfBirth": null
        },
        "recordLimit": null,
        "matchThreshold": null,
        "packages": [
          "KYC_AML"
        ]
      }
      """
    And headers headers
    And header Authorization = BearerToken
    And request requestPayload
    #    * set payload.response.meta.referenceId = "#ignore"
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
    * print 'requestUrl---->',requestUrl
    * print 'API Request----->',requestPayload
    * print 'Actual Response---->',karate.pretty(response)
    Then status 200

