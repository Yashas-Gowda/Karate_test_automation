@PHONE_SOCIAL_FidoV1 @PHONE_PACKAGES @regTest_1
  #@ignore
Feature: Testing of DPI  - PHONE_SOCIAL scenarios configured for FIDO V1 DP.
  #  @FIDO_V1 @ignore
  Background:
    * configure charset = null
    * path '/api/insights/'
    #    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    #    * def BearerToken = authFeature.authToken
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation_fidoV1_social_parallel.feature')
    * def BearerToken = authFeature.authToken
    * def Custom_env_authFeature_tenant_config = authFeature.Auth_custom_tenant_config
    * print Custom_env_authFeature_tenant_config


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of all fields- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.phone.social.profiles.messaging.viber.lastSeen = "#ignore"
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

    * def registeredProfiles = $.data.phone.social.summary.registeredProfiles
    * print registeredProfiles
    * def all_registered_array = $.data.phone.social.profiles..registered
    * print all_registered_array
    * def count_all_registered_profiles = all_registered_array.filter(x => x == true).length
    * print count_all_registered_profiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
    #    * match $.data.phone.social.profiles.messaging.viber.lastSeen == "#regex\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z";
    * set response.data.phone.social.profiles.messaging.viber.lastSeen = "#ignore"

    * set payload.response.data.phone.social.profiles.messaging.telegram.photo = "#ignore"
    * set  payload.response.data.phone.social.profiles.messaging.viber = "#ignore"
    * match $.data.phone.social.profiles.messaging == payload.response.data.phone.social.profiles.messaging
    * match $.data.phone.social.profiles.messaging.telegram.photo == "##regex ^.*(https://).*"
    # Vibor major outrage so commented the below line, please uncomment when it is fixed from fido
    #    * match $.data.phone.social.profiles.messaging.viber contains  {"registered":"##bollean","photo":"##regex ^.*(https://).*","lastSeen":"##regex\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z","name":"##string"}


    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    Examples:
      | Scenario                | statusCode |
      | PHONE_SOCIAL_Happy_flow | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of all fields for regions specific country where messaging.viber.lastSeen is null- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
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
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def registeredProfiles = $.data.phone.social.summary.registeredProfiles
    * print registeredProfiles
    * def all_registered_array = $.data.phone.social.profiles..registered
    * print all_registered_array
    * def count_all_registered_profiles = all_registered_array.filter(x => x == true).length
    * print count_all_registered_profiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
    * match payload.response.data.phone.social.profiles.messaging contains $.data.phone.social.profiles.messaging
    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    Examples:
      | Scenario                                       | statusCode |
      | PHONE_SOCIAL_country_Indonesia_response        | 200        |
      | PHONE_SOCIAL_country_Italy_IT_response         | 200        |
      | PHONE_SOCIAL_country_UnitedKingdom_GB_response | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of all fields for regions specific country where messaging.viber.lastSeen is null- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
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
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def registeredProfiles = $.data.phone.social.summary.registeredProfiles
    * print registeredProfiles
    * def all_registered_array = $.data.phone.social.profiles..registered
    * print all_registered_array
    * def count_all_registered_profiles = all_registered_array.filter(x => x == true).length
    * print count_all_registered_profiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
    * set payload.response.data.phone.social.profiles.messaging.whatsapp.photo = "#ignore"
    # Vibor major outrage so commented the below line, please remove below line when it is fixed from fido
    * set  payload.response.data.phone.social.profiles.messaging.viber = "#ignore"
    * match $.data.phone.social.profiles.messaging == payload.response.data.phone.social.profiles.messaging
    # Vibor major outrage so commented the below line, please remove below line when it is fixed from fido
    #    * match $.data.phone.social.profiles.messaging.viber contains  {"registered":"##bollean","photo":"##regex ^.*(https://).*","lastSeen":"##regex\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z","name":"##string"}
    * match $.data.phone.social.profiles.messaging.whatsapp.photo == "##regex ^.*(https://).*"
    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    Examples:
      | Scenario                                      | statusCode |
      | PHONE_SOCIAL_country_Malaysia_response        | 200        |
      | PHONE_SOCIAL_country_UnitedStates_US_response | 200        |
      | PHONE_SOCIAL_country_Vietnam_VN_response      | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of all fields for regions of specific country where messaging.viber.lastSeen is notnull - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.phone.social.profiles.messaging.viber.lastSeen = "#ignore"
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

    * def registeredProfiles = $.data.phone.social.summary.registeredProfiles
    * print registeredProfiles
    * def all_registered_array = $.data.phone.social.profiles..registered
    * print all_registered_array
    * def count_all_registered_profiles = all_registered_array.filter(x => x == true).length
    * print count_all_registered_profiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.emailProvider contains $.data.phone.social.profiles.emailProvider
    * match payload.response.data.phone.social.profiles.ecommerce contains $.data.phone.social.profiles.ecommerce
    * match payload.response.data.phone.social.profiles.socialMedia contains $.data.phone.social.profiles.socialMedia
    * match payload.response.data.phone.social.profiles.professional contains $.data.phone.social.profiles.professional
    * set  payload.response.data.phone.social.profiles.messaging.viber = "#ignore"
    * match $.data.phone.social.profiles.messaging == payload.response.data.phone.social.profiles.messaging
    # Vibor major outrage so commented the below line, please uncomment when it is fixed from fido
    #    * match $.data.phone.social.profiles.messaging.viber contains  {"registered":"##bollean","photo":"##regex ^.*(https://).*","lastSeen":"##regex\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z","name":"##string"}
    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    Examples:
      | Scenario                                  | statusCode |
      | PHONE_SOCIAL_country_Brazil_response      | 200        |
      | PHONE_SOCIAL_country_Philippines_response | 200        |



  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of emailProvider -fido gives only {google} [google,yahoo] - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.viber.lastSeen = "#ignore"
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
    * def payload_part = payload.response.data.phone.social.profiles.emailProvider
    * print payload_part
    * def response_part = $.data.phone.social.profiles.emailProvider
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def emailProvider = $.data.phone.social.profiles.emailProvider
    * print emailProvider
    * def emailProvider_registered_array = $.data.phone.social.profiles.emailProvider..registered
    * print emailProvider_registered_array
    * def count_emailProvider_registered_profiles = emailProvider_registered_array.filter(x => x == true).length
    * print count_emailProvider_registered_profiles
    * match count_emailProvider_registered_profiles == $.data.phone.social.summary.registeredEmailProviderProfiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.emailProvider == $.data.phone.social.profiles.emailProvider
    * match  $.data.phone.social.summary.lastActivity == "#null"
    #    * match $.data.phone.social.profiles.emailProvider.google.accountId == "#null"
    #    * match $.data.phone.social.profiles.emailProvider.google.name == "#null"

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 916354392816,919908863096,919701520928,919892838083,919502134325,916354286346,919148092890
    # Test data for for google false - 919347822419,919705276664,919347743437, 919980819590,919660222156
    Examples:
      | Scenario                                                         | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_emailProvider_google_registered_true  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_emailProvider_google_registered_false | 200        |

  #    fido gives only {Flipkart,Amazon,bukalapak} out off [flipkart,bukalapak,jdid,amazon]
  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of ecommerce -amazon- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.viber.lastSeen = "#ignore"
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
    * def payload_part = payload.response.data.phone.social.profiles.ecommerce
    * print payload_part
    * def response_part = $.data.phone.social.profiles.ecommerce
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def ecommerce = $.data.phone.social.profiles.ecommerce
    * print ecommerce
    * def ecommerce_registered_array = $.data.phone.social.profiles.ecommerce..registered
    * print ecommerce_registered_array
    * def count_ecommerce_registered_profiles = ecommerce_registered_array.filter(x => x == true).length
    * print count_ecommerce_registered_profiles
    * match count_ecommerce_registered_profiles == $.data.phone.social.summary.registeredEcommerceProfiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.ecommerce.amazon == $.data.phone.social.profiles.ecommerce.amazon
    * match  $.data.phone.social.summary.lastActivity == "#null"

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 916354392816,919908863096,919701520928,919892838083,919502134325,916354286346,919148092890
    # Test data for for amazon false - 919723596143,919439387913,919834538317,919830908019,919493590625

    Examples:
      | Scenario                                                     | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_amazon_registered_true  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_amazon_registered_false | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_amazon_registered_null  | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of ecommerce - flipkart - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.viber.lastSeen = "#ignore"
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
    * def payload_part = payload.response.data.phone.social.profiles.ecommerce
    * print payload_part
    * def response_part = $.data.phone.social.profiles.ecommerce
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def ecommerce = $.data.phone.social.profiles.ecommerce
    * print ecommerce
    * def ecommerce_registered_array = $.data.phone.social.profiles.ecommerce..registered
    * print ecommerce_registered_array
    * def count_ecommerce_registered_profiles = ecommerce_registered_array.filter(x => x == true).length
    * print count_ecommerce_registered_profiles
    * match count_ecommerce_registered_profiles == $.data.phone.social.summary.registeredEcommerceProfiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.ecommerce.flipkart == $.data.phone.social.profiles.ecommerce.flipkart
    * match  $.data.phone.social.summary.lastActivity == "#null"

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 916354392816,919908863096,919701520928,919892838083,919502134325,916354286346,919148092890
    # Test data for for amazon false - 919723596143,919439387913,919834538317,919830908019,919493590625

    Examples:
      | Scenario                                                            | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_flipkart_registered_true       | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_flipkart_registered_false      | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_flipkart_Datapoint_not_present | 200        |

  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of ecommerce - bukalapak - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.viber.lastSeen = "#ignore"
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
    * def payload_part = payload.response.data.phone.social.profiles.ecommerce
    * print payload_part
    * def response_part = $.data.phone.social.profiles.ecommerce
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def ecommerce = $.data.phone.social.profiles.ecommerce
    * print ecommerce
    * def ecommerce_registered_array = $.data.phone.social.profiles.ecommerce..registered
    * print ecommerce_registered_array
    * def count_ecommerce_registered_profiles = ecommerce_registered_array.filter(x => x == true).length
    * print count_ecommerce_registered_profiles
    * match count_ecommerce_registered_profiles == $.data.phone.social.summary.registeredEcommerceProfiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.ecommerce.bukalapak == $.data.phone.social.profiles.ecommerce.bukalapak
    * match  $.data.phone.social.summary.lastActivity == "#null"

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 916354392816,919908863096,919701520928,919892838083,919502134325,916354286346,919148092890
    # Test data for for amazon false - 919723596143,919439387913,919834538317,919830908019,919493590625

    Examples:
      | Scenario                                                                           | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_bukalapak_registered_true_hasWhatsappOtp_true | 200        |
      #  data not found       | PHONE_SOCIAL_FIDO_profiles_ecommerce_bukalapak_registered_true_hasWhatsappOtp_false | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_bukalapak_registered_false                    | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_bukalapak_registered_null                     | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of socialMedia - [facebook,twitter,instagram] - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.viber.lastSeen = "#ignore"
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
    * def payload_part = payload.response.data.phone.social.profiles.socialMedia
    * print payload_part
    * def response_part = $.data.phone.social.profiles.socialMedia
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def socialMedia = $.data.phone.social.profiles.socialMedia
    * print socialMedia
    * def socialMedia_registered_array = $.data.phone.social.profiles.socialMedia..registered
    * print socialMedia_registered_array
    * def count_socialMedia_registered_profiles = socialMedia_registered_array.filter(x => x == true).length
    * print count_socialMedia_registered_profiles
    * match count_socialMedia_registered_profiles == $.data.phone.social.summary.registeredSocialMediaProfiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.socialMedia == $.data.phone.social.profiles.socialMedia
    * match  $.data.phone.social.summary.lastActivity == "#null"

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 918051757413,919948330296,918830113399,919729516100,917988730112
    # Test data for for amazon false - 919723596143,919439387913,919834538317,919830908019,919493590625
    # twitter-false - 916354392816,919908863096,919788281684,919723596143,919493590625
    #instagram false -919360318371,917652090980,918826504916,918910612831,916350312482
    #facebook false - 919096092966,918122182732,919867131673,919916580826,918638281778

    Examples:
      | Scenario                                                                           | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_socialMedia_facebook_twitter_instagram_registered_true  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_socialMedia_facebook_twitter_instagram_registered_null  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_socialMedia_facebook_twitter_instagram_registered_false | 200        |

  #      | PHONE_SOCIAL_FIDO_profiles_socialMedia_twitter_registered_false                   | 200        |
  #      | PHONE_SOCIAL_FIDO_profiles_socialMedia_instagram_registered_false                 | 200        |
  #      | PHONE_SOCIAL_FIDO_profiles_socialMedia_facebook_registered_false                  | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of professional - [microsoft,linkedin] - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.viber.lastSeen = "#ignore"
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
    * def payload_part = payload.response.data.phone.social.profiles.socialMedia
    * print payload_part
    * def response_part = $.data.phone.social.profiles.socialMedia
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def professional = $.data.phone.social.profiles.professional
    * print professional
    * def professional_registered_array = $.data.phone.social.profiles.professional..registered
    * print professional_registered_array
    * def count_professional_registered_profiles = professional_registered_array.filter(x => x == true).length
    * print count_professional_registered_profiles
    * match count_professional_registered_profiles == $.data.phone.social.summary.registeredProfessionalProfiles

    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.professional == $.data.phone.social.profiles.professional
    * match  $.data.phone.social.summary.lastActivity == "#null"

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]


    Examples:
      | Scenario                                                                   | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_professional_microsoft_registered_true          | 200        |
      | PHONE_SOCIAL_FIDO_profiles_professional_microsoft_registered_false         | 200        |
      | PHONE_SOCIAL_FIDO_profiles_professional_microsoft_linkedin_registered_null | 200        |


  # linked is having status of major outrage so please uncomment the below code when it is fixed
  #   data not found due to outrage  | PHONE_SOCIAL_FIDO_profiles_professional_linkedin_registered_true            | 200        |
  #   data not found due to outrage  | PHONE_SOCIAL_FIDO_profiles_professional_linkedin_registered_false           | 200        |



  #  In  Messaging, fido gives only [telegram,whatsapp,viber,skype] out of [telegram,whatsapp,viber,kakao,skype,ok,zalo,line,snapchat]
  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of messaging with photo assertion  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
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
    * def payload_part = payload.response.data.phone.social.profiles.messaging
    * print payload_part
    * def response_part = $.data.phone.social.profiles.messaging
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def messaging = $.data.phone.social.profiles.messaging
    * print messaging
    * def messaging_registered_array = $.data.phone.social.profiles.messaging..registered
    * print messaging_registered_array
    * def count_messaging_registered_profiles = messaging_registered_array.filter(x => x == true).length
    * print count_messaging_registered_profiles
    * match count_messaging_registered_profiles == $.data.phone.social.summary.registeredMessagingProfiles


    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * set payload.response.data.phone.social.profiles.messaging.telegram.photo = "#ignore"
    * set payload.response.data.phone.social.profiles.messaging.whatsapp.photo = "#ignore"
    * set  payload.response.data.phone.social.profiles.messaging.viber = "#ignore"
    * match $.data.phone.social.profiles.messaging == payload.response.data.phone.social.profiles.messaging
    * match $.data.phone.social.profiles.messaging.telegram.photo == "#regex ^.*(https://).*"
    * match $.data.phone.social.profiles.messaging.whatsapp.photo == "#regex ^.*(https://).*"
    # Vibor major outrage so commented the below line, please uncomment when it is fixed from fido
    #    * match $.data.phone.social.profiles.messaging.viber contains  {"registered":"##bollean","photo":"##regex ^.*(https://).*","lastSeen":"##regex\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z","name":"##string"}

    * match  $.data.phone.social.summary.lastActivity == '#null'

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 916383761273,'916354392816,918919307951,917276417276,918418077188,918886565536
    # telegram false -


    # telegram-false - 919705300142,919610062000,919971513080,918985999905,91974239606,9919889868205,919406099650
    #whatsapp false -917980925895,918669070751,918953417418,919964484685,919079632630,919000883907,918790368717

    Examples:
      | Scenario                                                                                               | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true                                 | 200        |
      #      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_registered_photo_privacyStatus_lastSeen_null                       | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true_with_photo_privacyStatus_PUBLIC | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of messaging with photo assertion  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
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
    * def payload_part = payload.response.data.phone.social.profiles.messaging
    * print payload_part
    * def response_part = $.data.phone.social.profiles.messaging
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def messaging = $.data.phone.social.profiles.messaging
    * print messaging
    * def messaging_registered_array = $.data.phone.social.profiles.messaging..registered
    * print messaging_registered_array
    * def count_messaging_registered_profiles = messaging_registered_array.filter(x => x == true).length
    * print count_messaging_registered_profiles
    * match count_messaging_registered_profiles == $.data.phone.social.summary.registeredMessagingProfiles


    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * set payload.response.data.phone.social.profiles.messaging.telegram.photo = "#ignore"
    * set payload.response.data.phone.social.profiles.messaging.whatsapp.photo = "#ignore"
    * set  payload.response.data.phone.social.profiles.messaging.viber = "#ignore"
    * match $.data.phone.social.profiles.messaging == payload.response.data.phone.social.profiles.messaging
    #    * match $.data.phone.social.profiles.messaging.telegram.photo == "#regex ^.*(https://).*"
    #    * match $.data.phone.social.profiles.messaging.whatsapp.photo == "#regex ^.*(https://).*"
    # Vibor major outrage so commented the below line, please uncomment when it is fixed from fido
    #    * match $.data.phone.social.profiles.messaging.viber contains  {"registered":"##bollean","photo":"##regex ^.*(https://).*","lastSeen":"##regex\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z","name":"##string"}

    * match  $.data.phone.social.summary.lastActivity == '#null'

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 916383761273,'916354392816,918919307951,917276417276,918418077188,918886565536
    # telegram false -


    # telegram-false - 919705300142,919610062000,919971513080,918985999905,91974239606,9919889868205,919406099650
    #whatsapp false -917980925895,918669070751,918953417418,919964484685,919079632630,919000883907,918790368717

    Examples:
      | Scenario                                                                                                         | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_messaging_whatsapp_false_telegram_registered_true_without_photo_privacyStatus_PRIVATE | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true_without_photo_with_privacyStatus_PRIVATE  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_false_whatsapp_registered_true_with_photo_privacyStatus_PUBLIC     | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_false_whatsapp_registered_true_with_photo_privacyStatus_PRIVATE    | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of messaging with photo assertion  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
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
    * def payload_part = payload.response.data.phone.social.profiles.messaging
    * print payload_part
    * def response_part = $.data.phone.social.profiles.messaging
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def messaging = $.data.phone.social.profiles.messaging
    * print messaging
    * def messaging_registered_array = $.data.phone.social.profiles.messaging..registered
    * print messaging_registered_array
    * def count_messaging_registered_profiles = messaging_registered_array.filter(x => x == true).length
    * print count_messaging_registered_profiles
    * match count_messaging_registered_profiles == $.data.phone.social.summary.registeredMessagingProfiles


    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * set payload.response.data.phone.social.profiles.messaging.telegram.photo = "#ignore"
    * set payload.response.data.phone.social.profiles.messaging.whatsapp.photo = "#ignore"
    * set  payload.response.data.phone.social.profiles.messaging.viber = "#ignore"
    * match $.data.phone.social.profiles.messaging == payload.response.data.phone.social.profiles.messaging
    * match $.data.phone.social.profiles.messaging.telegram.photo == "#regex ^.*(https://).*"
    #    * match $.data.phone.social.profiles.messaging.whatsapp.photo == "#regex ^.*(https://).*"
    # Vibor major outrage so commented the below line, please uncomment when it is fixed from fido
    #    * match $.data.phone.social.profiles.messaging.viber contains  {"registered":"##bollean","photo":"##regex ^.*(https://).*","lastSeen":"##regex\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z","name":"##string"}

    * match  $.data.phone.social.summary.lastActivity == '#null'

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 916383761273,'916354392816,918919307951,917276417276,918418077188,918886565536
    # telegram false -

    # telegram-false - 919705300142,919610062000,919971513080,918985999905,91974239606,9919889868205,919406099650
    #whatsapp false -917980925895,918669070751,918953417418,919964484685,919079632630,919000883907,918790368717

    Examples:
      | Scenario                                                                                                     | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_messaging_whatsapp_false_telegram_registered_true_with_photo_privacyStatus_PUBLIC | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of messaging - [telegram,whatsapp,viber,kakao,skype,ok,zalo,line,snapchat],But fido gives only [telegram,whatsapp]  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V2/<Scenario>.json")
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
    * def payload_part = payload.response.data.phone.social.profiles.messaging
    * print payload_part
    * def response_part = $.data.phone.social.profiles.messaging
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def messaging = $.data.phone.social.profiles.messaging
    * print messaging
    * def messaging_registered_array = $.data.phone.social.profiles.messaging..registered
    * print messaging_registered_array
    * def count_messaging_registered_profiles = messaging_registered_array.filter(x => x == true).length
    * print count_messaging_registered_profiles
    * match count_messaging_registered_profiles == $.data.phone.social.summary.registeredMessagingProfiles


    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match $.data.phone.social.profiles.messaging == payload.response.data.phone.social.profiles.messaging
    * match  $.data.phone.social.summary.lastActivity == '#null'

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]


    Examples:
      | Scenario                                                                       | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_messaging_viber_skype_false                         | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_viber_registered_photo_lastSeen_name_null | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_viber_registered_true_with_name           | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_viber_registered_true_with_lastSeen_name  | 200        |


  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of messaging when where messaging.viber.lastSeen is notnull - [telegram,whatsapp,viber,kakao,skype,ok,zalo,line,snapchat],But fido gives only [telegram,whatsapp]  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
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
    * def payload_part = payload.response.data.phone.social.profiles.messaging
    * print payload_part
    * def response_part = $.data.phone.social.profiles.messaging
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * def messaging = $.data.phone.social.profiles.messaging
    * print messaging
    * def messaging_registered_array = $.data.phone.social.profiles.messaging..registered
    * print messaging_registered_array
    * def count_messaging_registered_profiles = messaging_registered_array.filter(x => x == true).length
    * print count_messaging_registered_profiles
    * match count_messaging_registered_profiles == $.data.phone.social.summary.registeredMessagingProfiles


    * def numberOfNamesReturned = $.data.phone.social.profiles..name
    * print numberOfNamesReturned
    * def count_numberOfNamesReturned = numberOfNamesReturned.filter(x => x != null).length
    * print count_numberOfNamesReturned
    * match count_numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned

    * def numberOfPhotosReturned = $.data.phone.social.profiles..photo
    * print numberOfPhotosReturned
    * def count_numberOfPhotosReturned = numberOfPhotosReturned.filter(x => x != null).length
    * print count_numberOfPhotosReturned
    * match count_numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned

    * match payload.response.data.phone.social.profiles.messaging == $.data.phone.social.profiles.messaging
    * match  $.data.phone.social.summary.lastActivity == '#null'
    * set  payload.response.data.phone.social.profiles.messaging.viber = "#ignore"
    # Vibor major outrage so commented the below line, please uncomment when it is fixed from fido
    #    * match $.data.phone.social.profiles.messaging.viber contains  {"registered":"##bollean","photo":"##regex ^.*(https://).*","lastSeen":"##regex\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z","name":"##string"}

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    Examples:
      | Scenario                                                                                         | statusCode |
      #  https://monnai.atlassian.net/browse/MB-3809
      | PHONE_SOCIAL_FIDO_profiles_messaging_skype_registered_false_with_all_null                        | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_skype_registered_true_with_id_name_photo_city_state_country | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_skype_registered_true_with_id_name_city_state_country       | 200        |

  #  @Schema_validation_1
  #  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Schema_validation_1 - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    * set payload.response.viber.lastSeen = "#ignore"
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
  #    And match $.data.phone.social.profiles.emailProvider contains deep {"google":{"registered":"#present","accountId":"#present","name":"#present"},"yahoo":{"registered":"#present"}}
  #    And match $.data.phone.social.profiles.ecommerce contains deep {"flipkart":{"registered":"#present"},"bukalapak":{"registered":"#present"},"jdid":{"registered":"#present"},"amazon":{"registered":"#present"}}x`
  #    And match $.data.phone.social.profiles.socialMedia contains deep {"facebook":{"registered":"#present"},"twitter":{"registered":"#present"},"instagram":{"registered":"#present"}}
  #    And match $.data.phone.social.profiles.professional contains deep {"microsoft":{"registered":"#present"},"linkedin":{"registered":"#present"}}
  #    And match $.data.phone.social.profiles.messaging contains deep {"telegram":{"registered":"#present","photo":"#present","privacyStatus":"#present","lastSeen":"#present"},"whatsapp":{"registered":"#present","photo":"#present","privacyStatus":"#present","lastSeen":"#present","about":"#present"},"viber":{"registered":"#present","photo":"#present","lastSeen":"#present","name":"#present"},"kakao":{"registered":"#present"},"skype":{"registered":"#present","language":"#present","id":"#present","handle":"#present","bio":"#present","name":"#present","age":"#present","gender":"#present","photo":"#present","city":"#present","state":"#present","country":"#present"},"ok":{"registered":"#present","age":"#present"},"zalo":{"registered":"#present","uid":"#present","name":"#present","dateOfBirth":"#present"},"line":{"registered":"#present","name":"#present","photo":"#present"},"snapchat":{"registered":"#present"}}
  #
  #    And match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
  #    And match $.meta contains deep {"inputPhoneNumber":"#present","cleansedPhoneNumber":"#present","referenceId":"#present","requestedPackages":["PHONE_SOCIAL"]}
  #    And match $.errors == []
  #
  #    Examples:
  #      | Scenario | statusCode |
  ##      | PHONE_SOCIAL_country_Malaysia_response | 200        |


  @Schema_validation_1
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Schema_validation_1 - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/PHONE_SOCIAL_FIDO_V1/<Scenario>.json")
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

    * def Schema =
      """
      {
        "data": {
          "phone": {
            "basic": null,
            "social": {
              "summary": {
                "registeredProfiles": "#number",
                "registeredEmailProviderProfiles": "#number",
                "registeredEcommerceProfiles": "#number",
                "registeredSocialMediaProfiles": "#number",
                "registeredProfessionalProfiles": "#number",
                "registeredMessagingProfiles": "#number",
                "lastActivity": "#null",
                "numberOfNamesReturned": "#number",
                "numberOfPhotosReturned": "#number"
              },
              "profiles": {
                "emailProvider": {
                  "google": {
                    "registered": "#present",
                    "accountId": "#present",
                    "name": "#present"
                  }
                },
                "ecommerce": {
                  "flipkart": {
                    "registered": "#present"
                  },
                  "amazon": {
                    "registered": "#present"
                  }
                },
                "socialMedia": {
                  "facebook": {
                    "registered": "#present"
                  },
                  "twitter": {
                    "registered": "#present"
                  },
                  "instagram": {
                    "registered": "#present"
                  }
                },
                "professional": {
                  "microsoft": {
                    "registered": "#present"
                  },
                  "linkedin": {
                    "registered": "#present"
                  }
                },
                "messaging": {
                  "telegram": {
                    "registered": "#present",
                    "photo": "#present",
                    "privacyStatus": "#present",
                    "lastSeen": "#present"
                  },
                  "whatsapp": {
                    "registered": "#present",
                    "photo": "#present",
                    "privacyStatus": "#present",
                    "lastSeen": "#present",
                    "about": "#present",
                    "businessAccount": "#present"
                  },
                  "viber": {
                    "registered": "#present",
                    "photo": "#present",
                    "lastSeen": "#present",
                    "name": "#present"
                  },
                  "skype": {
                    "registered": "#present",
                    "language": "#present",
                    "id": "#present",
                    "handle": "#present",
                    "bio": "#present",
                    "name": "#present",
                    "age": "#present",
                    "gender": "#present",
                    "photo": "#present",
                    "city": "#present",
                    "state": "#present",
                    "country": "#present"
                  }
                }
              }
            },
            "identity": "#null"
          },
          "email": "#null",
          "address": "#null",
          "name": "#null",
          "ip": "#null",
          "identity": "#null",
          "upi": "#null",
          "device": "#null",
          "employment": "#null",
          "income": "#null",
          "blacklist": "#null",
          "domain": "#null",
          "kyc": "#null",
          "bank": "#null",
          "aadhaar": "#null",
          "bre": "#null"
        },
        "meta": {
          "inputPhoneNumber": "#present",
          "cleansedPhoneNumber": "#present",
          "referenceId": "#present",
          "requestedPackages": [
            "PHONE_SOCIAL"
          ]
        },
        "errors": []
      }
      """

    * match payload.response.data.phone.social.summary contains Schema.data.phone.social.summary

    * match payload.response.data.phone.social.profiles.emailProvider contains Schema.data.phone.social.profiles.emailProvider
    * match payload.response.data.phone.social.profiles.ecommerce contains Schema.data.phone.social.profiles.ecommerce
    * match payload.response.data.phone.social.profiles.socialMedia contains Schema.data.phone.social.profiles.socialMedia
    * match payload.response.data.phone.social.profiles.professional contains Schema.data.phone.social.profiles.professional
    * match payload.response.data.phone.social.profiles.messaging contains Schema.data.phone.social.profiles.messaging

    * match payload.response.meta contains Schema.meta
    * match payload.response.meta.requestedPackages[0] contains Schema.meta.requestedPackages[0]

    Examples:
      | Scenario                                               | statusCode |
      | PHONE_SOCIAL_FIDO_V1_all_data_points_Schema_Validation | 200        |

