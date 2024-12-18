@seon_phone @PHONE_SOCIAL_SEON @ignore
Feature: Testing of DPI  - PHONE_SOCIAL_SEON scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  #Note - PHONE_SOCAIL with Seon data partner response is highly unstable so some test cases will fail always.
  #  @PHONE_SOCIAL @seon
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL/<Scenario>.json")
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
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match $.data.phone.social.summary.lastActivity == "#number"
    * set payload.response.data.phone.social.summary.lastActivity = "#ignore"

    #    * match  $.data.phone.social contains  payload.response.data.phone.social
    * match payload.response.data.phone.social.summary contains $.data.phone.social.summary
    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
    * match payload.response.data.phone.social.profiles.messaging contains $.data.phone.social.profiles.messaging
    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}

    * match  $.meta contains  payload.response.meta

    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Examples:
      | Scenario                | statusCode |
      | PHONE_SOCIAL_Happy_flow | 200        |

  #  @PHONE_SOCIAL @seon
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL/<Scenario>.json")
  #    And headers headers
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
  #    And match $.data.phone.social == '#notnull'
  #    And match $.data.phone.social.summary == '#notnull'
  #    And match $.data.phone.social.profiles == '#notnull'
  #
  #    * match $.data.phone.social.summary.lastActivity == "#number"
  #    * set payload.response.data.phone.social.summary.lastActivity = "#ignore"
  #
  #    #    * match  $.data.phone.social contains  payload.response.data.phone.social
  #    * match payload.response.data.phone.social.summary contains $.data.phone.social.summary
  #    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
  #    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
  #    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
  #    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
  #    * match payload.response.data.phone.social.profiles.messaging contains $.data.phone.social.profiles.messaging
  #    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
  #
  #    * match  $.meta contains  payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #    Examples:
  #      | Scenario                                          | statusCode |
  #      | PHONE_SOCIAL_Seon_Summary_numberOfNamesReturned_1 | 200        |
  #
  #  @PHONE_SOCIAL @seon
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL/<Scenario>.json")
  #    And headers headers
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
  #    And match $.data.phone.social == '#notnull'
  #    And match $.data.phone.social.summary == '#notnull'
  #    And match $.data.phone.social.profiles == '#notnull'
  #
  #    * match payload.response.data.phone.social.summary contains $.data.phone.social.summary
  #    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
  #    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
  #    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
  #    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
  #    * match payload.response.data.phone.social.profiles.messaging contains $.data.phone.social.profiles.messaging
  #    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
  #
  #    * match  $.meta contains  payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #
  #    Examples:
  #      | Scenario                                                                                                        | statusCode |
  #      | PHONE_SOCIAL_Seon_profiles_google_flipkart_facebook_instagram_twitter_microsoft_snapchat_whatsapp_telegram_true | 200        |
  #
  #  @PHONE_SOCIAL @seon
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL/<Scenario>.json")
  #    And headers headers
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
  #    And match $.data.phone.social == '#notnull'
  #    And match $.data.phone.social.summary == '#notnull'
  #    And match $.data.phone.social.profiles == '#notnull'
  #
  #    * match payload.response.data.phone.social.summary contains $.data.phone.social.summary
  #    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
  #    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
  #    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
  #    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
  #    * match payload.response.data.phone.social.profiles.messaging contains $.data.phone.social.profiles.messaging
  #    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
  #
  #    * match  $.meta contains  payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #
  #    Examples:
  #      | Scenario                                   | statusCode |
  #      | PHONE_SOCIAL_Seon_profiles_messaging_skype | 200        |
  #
  #
  #  @PHONE_SOCIAL @seon
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL/<Scenario>.json")
  #    And headers headers
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
  #
  #    And match $.data.phone.social == '#notnull'
  #    And match $.data.phone.social.summary == '#notnull'
  #    And match $.data.phone.social.profiles == '#notnull'
  #
  #    * match payload.response.data.phone.social.summary contains $.data.phone.social.summary
  #    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
  #    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
  #    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
  #    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
  #    * match payload.response.data.phone.social.profiles.messaging contains $.data.phone.social.profiles.messaging
  #    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
  #
  #    * match  $.meta contains  payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #
  #    Examples:
  #      | Scenario                                                                           | statusCode |
  #      | PHONE_SOCIAL_summary_lastActivity_same_as_lastSeen_of_telegram_AND_line_registered | 200        |
  #
  #  @PHONE_SOCIAL @seon
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL/<Scenario>.json")
  #    And headers headers
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
  #
  #    And match $.data.phone.social == '#notnull'
  #    And match $.data.phone.social.summary == '#notnull'
  #    And match $.data.phone.social.profiles == '#notnull'
  #
  #    * match payload.response.data.phone.social.summary contains $.data.phone.social.summary
  #    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
  #    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
  #    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
  #    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
  #    * match payload.response.data.phone.social.profiles.messaging contains $.data.phone.social.profiles.messaging
  #    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
  #
  #    * match  $.meta contains  payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #
  #    Examples:
  #      | Scenario                          | statusCode |
  #      | PHONE_SOCIAL_FIXED_line_summary_0 | 200        |
  #
  #  @PHONE_SOCIAL @seon
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL/<Scenario>.json")
  #    And headers headers
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
  #
  #    * match payload.response.data.phone.social.summary contains $.data.phone.social.summary
  #    And match $.data.phone.social == '#notnull'
  #    And match $.data.phone.social.summary == '#notnull'
  #    And match $.data.phone.social.profiles == '#notnull'
  #
  #    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
  #    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
  #    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
  #    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
  #    * match payload.response.data.phone.social.profiles.messaging contains $.data.phone.social.profiles.messaging
  #    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
  #
  #    * match  $.meta contains  payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #
  #    Examples:
  #      | Scenario                                                                                                                            | statusCode |
  #      | PHONE_SOCIAL_country_Brazil_response                                                                                                | 200        |
  #      | PHONE_SOCIAL_country_Malaysia_response                                                                                              | 200        |
  #      | PHONE_SOCIAL_country_Indonesia_response                                                                                             | 200        |
  #      | PHONE_SOCIAL_country_Philippines_response                                                                                           | 200        |
  #      | PHONE_SOCIAL_country_Vietnam_VN_response                                                                                            | 200        |
  #      #need to check | PHONE_SOCIAL_country_Vietnam_VN_response_lastActivity_latest_lastSeen                                                               | 200        |
  #      | PHONE_SOCIAL_country_Vietnam_VN_response_zalo_respondent                                                                            | 200        |
  #      #need data | PHONE_SOCIAL_country_Vietnam_VN_response_viber_respondent                                                                           | 200        |
  #      | PHONE_SOCIAL_country_UnitedKingdom_GB_response                                                                                      | 200        |
  #      | PHONE_SOCIAL_country_Italy_IT_response_google_flipkart_bukalapak_facebook_twitter_instagram_microsoft_telegram_whatsapp_viber_false | 200        |
  #
  #  @Schema_validation_1
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for SEON - Schema_validation_1 - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL/<Scenario>.json")
  #    And headers headers
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
  #
  #    And match $.data.phone.social == '#notnull'
  #    And match $.data.phone.basic == '#null'
  #    And match $.data.phone.social.summary contains deep {"registeredProfiles":"#present","registeredEmailProviderProfiles":"#present","registeredEcommerceProfiles":"#present","registeredSocialMediaProfiles":"#present","registeredProfessionalProfiles":"#present","registeredMessagingProfiles":"#present","lastActivity":"#present","numberOfNamesReturned":"#present","numberOfPhotosReturned":"#present"}
  #    And match $.data.phone.social.profiles.emailProvider contains deep{"google":{"registered":"#present","accountId":"#present","name":"#present"},"yahoo":{"registered":"#present"}}
  #    And match $.data.phone.social.profiles.ecommerce contains deep {"flipkart":{"registered":"#present"},"bukalapak":{"registered":"#present"},"jdid":{"registered":"#present"}}
  #    And match $.data.phone.social.profiles.socialMedia contains deep {"facebook":{"registered":"#present"},"twitter":{"registered":"#present"},"instagram":{"registered":"#present"}}
  #    And match $.data.phone.social.profiles.professional contains deep {"microsoft":{"registered":"#present"}}
  #    And match $.data.phone.social.profiles.messaging contains deep {"telegram":{"registered":"#present","photo":"#present","privacyStatus":"#present","lastSeen":"#present"},"whatsapp":{"registered":"#present","photo":"#present","privacyStatus":"#present","lastSeen":"#present","about":"#present"},"viber":{"registered":"#present","photo":"#present","lastSeen":"#present","name":"#present"},"kakao":{"registered":"#present"},"skype":{"registered":"#present","language":"#present","id":"#present","handle":"#present","bio":"#present","name":"#present","age":"#present","gender":"#present","photo":"#present","city":"#present","state":"#present","country":"#present"},"ok":{"registered":"#present","age":"#present"},"zalo":{"registered":"#present","uid":"#present","name":"#present","dateOfBirth":"#present"},"line":{"registered":"#present","name":"#present","photo":"#present"},"snapchat":{"registered":"#present"}}
  #
  #    And match $.data contains{"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
  #    And match $.meta contains deep {"inputPhoneNumber":"#present","cleansedPhoneNumber":"#present","referenceId":"#present","requestedPackages":["PHONE_SOCIAL"]}
  #    And match $.errors == []
  #
  #    Examples:
  #      | Scenario                             | statusCode |
  #      | PHONE_SOCIAL_country_Brazil_response | 200        |
  #
  #
  #  @Schema_validation_2
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for SEON - Schema_validation_2 - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL/<Scenario>.json")
  #    And headers headers
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
  #    Then match $ contains deep
  #      """
  #      {
  #        "data": {
  #          "phone": {
  #            "basic": null,
  #            "social": {
  #              "summary": {
  #                "registeredProfiles": "#present",
  #                "registeredEmailProviderProfiles": "#present",
  #                "registeredEcommerceProfiles": "#present",
  #                "registeredSocialMediaProfiles": "#present",
  #                "registeredProfessionalProfiles": "#present",
  #                "registeredMessagingProfiles": "#present",
  #                "lastActivity": "#present",
  #                "numberOfNamesReturned": "#present",
  #                "numberOfPhotosReturned": "#present"
  #              },
  #              "profiles": {
  #                "emailProvider": {
  #                  "google": {
  #                    "registered": "#present",
  #                    "accountId": "#present",
  #                    "name": "#present"
  #                  },
  #                  "yahoo": {
  #                    "registered":"#present"
  #                  }
  #                },
  #                "ecommerce": {
  #                  "flipkart": {
  #                    "registered": "#present"
  #                  },
  #                  "bukalapak": {
  #                    "registered": "#present"
  #                  },
  #                  "jdid": {
  #                    "registered": "#present"
  #                  }
  #                },
  #                "socialMedia": {
  #                  "facebook": {
  #                    "registered": "#present"
  #                  },
  #                  "twitter": {
  #                    "registered": "#present"
  #                  },
  #                  "instagram": {
  #                    "registered": "#present"
  #                  }
  #                },
  #                "professional": {
  #                  "microsoft": {
  #                    "registered": "#present"
  #                  }
  #                },
  #                "messaging": {
  #                  "telegram": {
  #                    "registered": "#present",
  #                    "photo": "#present",
  #                    "privacyStatus": "#present",
  #                    "lastSeen": "#present"
  #                  },
  #                  "whatsapp": {
  #                    "registered": "#present",
  #                    "photo": "#present",
  #                    "privacyStatus": "#present",
  #                    "lastSeen":"#present",
  #                    "about": "#present"
  #                  },
  #                  "viber": {
  #                    "registered": "#present",
  #                    "photo": "#present",
  #                    "lastSeen": "#present",
  #                    "name":"#present"
  #                  },
  #                  "kakao": {
  #                    "registered": "#present"
  #                  },
  #                  "skype": {
  #                    "registered": "#present",
  #                    "language": "#present",
  #                    "id": "#present",
  #                    "handle": "#present",
  #                    "bio": "#present",
  #                    "name": "#present",
  #                    "age":"#present",
  #                    "gender":"#present",
  #                    "photo":"#present",
  #                    "city":"#present",
  #                    "state": "#present",
  #                    "country": "#present"
  #                  },
  #                  "ok": {
  #                    "registered": "#present",
  #                    "age": "#present"
  #                  },
  #                  "zalo": {
  #                    "registered": "#present",
  #                    "uid": "#present",
  #                    "name": "#present",
  #                    "dateOfBirth": "#present"
  #                  },
  #                  "line": {
  #                    "registered":"#present",
  #                    "name":"#present",
  #                    "photo":"#present"
  #                  },
  #                  "snapchat": {
  #                    "registered": "#present"
  #                  }
  #                }
  #              }
  #            },
  #            "identity":"#null"
  #          },
  #          "email": "#null",
  #          "address": "#null",
  #          "name": "#null",
  #          "ip": "#null",
  #          "identity":"#null",
  #          "upi": "#null",
  #          "device":"#null",
  #          "employment": "#null",
  #          "income": "#null",
  #          "blacklist": "#null",
  #          "bre": "#null"
  #        },
  #        "meta": {
  #          "inputPhoneNumber": "#present",
  #          "cleansedPhoneNumber": "#present",
  #          "referenceId": "#ignore",
  #          "requestedPackages": [
  #            "PHONE_SOCIAL"
  #          ]
  #        },
  #        "errors": [
  #        ]
  #      }
  #      """
  #    #    * match  $ contains deep schema_validation
  #    Examples:
  #      | Scenario                               | statusCode |
  #      | PHONE_SOCIAL_country_Malaysia_response | 200        |
  #  #      | PHONE_SOCIAL_country_Indonesia_response   | 200        |
  #  #      | PHONE_SOCIAL_country_Philippines_response | 200        |
  #  #      | PHONE_SOCIAL_country_Vietnam_VN_response  | 200        |
  #
  #