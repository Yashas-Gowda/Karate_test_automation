@EMAIL_SOCIAL_FIDOV2 @EMAIL_PACKAGES @regTest_2
Feature: Testing of DPI  - EMAIL_SOCIAL feature scenarios with FIDO V2
  #@FIDO @ignore
  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  # Monnai to datapartner mapping is not tested/validated while automating, after discussion roopa suggested to take sameena tested DPI test as source of truth

  # automation ticket - https://monnai.atlassian.net/browse/MB-3908
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.data.email.social.profiles.emailProvider.google.photo = "#ignore"
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
    And match $.data.email.social == '#notnull'
    And match $.data.email.social.summary == '#notnull'
    And match $.data.email.social.profiles == '#notnull'

    Then status <statusCode>
    #    Then match $ contains payload.response
    * def registeredProfiles = $.data.email.social.summary.registeredProfiles
    * print registeredProfiles
    * def all_registered_array = $.data.email.social.profiles..registered
    * print all_registered_array
    * def count_all_registered_profiles = all_registered_array.filter(x => x == true).length
    * print count_all_registered_profiles
    * match registeredProfiles == count_all_registered_profiles

    * match $.data.email.social.summary contains {registeredProfiles : '#? _>= 0'}
    * match $.data.email.social.summary contains {registeredEmailProviderProfiles : '#? _>= 0'}
    * match $.data.email.social.summary contains {registeredEcommerceProfiles : '#? _>= 0'}
    * match $.data.email.social.summary contains {registeredSocialMediaProfiles : '#? _>= 0'}
    * match $.data.email.social.summary contains {registeredProfessionalProfiles : '#? _>= 0'}
    * match $.data.email.social.summary contains {registeredMessagingProfiles : '#? _>= 0'}

    * match $.data.email.social.summary contains {numberOfNamesReturned : '#? _>= 0'}
    * match $.data.email.social.summary contains {numberOfPhotosReturned : '#? _>= 0'}

    * match $.data contains {"phone":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors

    Examples:
      | Scenario               | statusCode |
      | Email_Social_sanity_V2 | 200        |

  #      in consumerElectronics , fido gives only apple and not samsung
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = consumerElectronics - apple  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/consumerElectronics/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredConsumerElectronicsProfiles == $.data.email.social.summary.registeredConsumerElectronicsProfiles
    #    * match payload.response.data.email.social.profiles.consumerElectronics == $.data.email.social.profiles.consumerElectronics
    * def consumerElectronics = $.data.email.social.profiles.consumerElectronics
    * print consumerElectronics
    * def consumerElectronics_registered_array = $.data.email.social.profiles.consumerElectronics..registered
    * print consumerElectronics_registered_array
    * def count_consumerElectronics_registered_profiles = consumerElectronics_registered_array.filter(x => x == true).length
    * print count_consumerElectronics_registered_profiles
    * match count_consumerElectronics_registered_profiles == $.data.email.social.summary.registeredConsumerElectronicsProfiles
    * match payload.response.data.email.social.profiles.consumerElectronics.apple == $.data.email.social.profiles.consumerElectronics.apple
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                   | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_apple_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_apple_false | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_apple_null  | 200        |


  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = consumerElectronics -samsung  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/consumerElectronics/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredConsumerElectronicsProfiles == $.data.email.social.summary.registeredConsumerElectronicsProfiles
    #    * match payload.response.data.email.social.profiles.consumerElectronics == $.data.email.social.profiles.consumerElectronics
    * def consumerElectronics = $.data.email.social.profiles.consumerElectronics
    * print consumerElectronics
    * def consumerElectronics_registered_array = $.data.email.social.profiles.consumerElectronics..registered
    * print consumerElectronics_registered_array
    * def count_consumerElectronics_registered_profiles = consumerElectronics_registered_array.filter(x => x == true).length
    * print count_consumerElectronics_registered_profiles
    * match count_consumerElectronics_registered_profiles == $.data.email.social.summary.registeredConsumerElectronicsProfiles
    * match payload.response.data.email.social.profiles.consumerElectronics.samsung == $.data.email.social.profiles.consumerElectronics.samsung
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                     | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_samsung_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_samsung_false | 200        |

  # fido doen't give {mailru,rambler} gives only {google-(registered,name,photo), yahoo}
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = emailProvider  - google  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/emailProvider/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.data.email.social.profiles.emailProvider = "#ignore"
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
    #    * match payload.response.data.email.social.summary.registeredEmailProviderProfiles == $.data.email.social.summary.registeredEmailProviderProfiles
    * def emailProvider = $.data.email.social.profiles.emailProvider
    * print emailProvider
    * def emailProvider_registered_array = $.data.email.social.profiles.emailProvider..registered
    * print emailProvider_registered_array
    * def count_emailProvider_registered_profiles = emailProvider_registered_array.filter(x => x == true).length
    * print count_emailProvider_registered_profiles
    * match count_emailProvider_registered_profiles == $.data.email.social.summary.registeredEmailProviderProfiles
    * set payload.response.data.email.social.profiles.emailProvider.google.photo = "#ignore"
    * match $.data.email.social.profiles.emailProvider.google == payload.response.data.email.social.profiles.emailProvider.google
    * match $.data.email.social.profiles.emailProvider.google.photo == "##regex ^.*(https://).*"
    * match $.data.email.social.profiles.emailProvider.google contains {"gender":"##? _ == 'F' || _ == 'M'"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                  | statusCode |
      #    Depricated test cases
      #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_yahoo_true             | 200        |
      #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_yahoo_false            | 200        |
      #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_true_yahoo_false       | 200        |
      #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_false_yahoo_true       | 200        |
      #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_with_name_photo        | 200        |
      #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_with_name_photo_gender | 200        |

      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_true                      | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_false                     | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_with_name_photo           | 200        |
      # Data changed     | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_with_name_photo_gender | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_without_name_photo_gender | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_With_gender               | 200        |


  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = emailProvider - yahoo  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/emailProvider/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    #    * set payload.response.data.email.social.profiles.emailProvider = "#ignore"
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
    #    * match payload.response.data.email.social.summary.registeredEmailProviderProfiles == $.data.email.social.summary.registeredEmailProviderProfiles
    * def emailProvider = $.data.email.social.profiles.emailProvider
    * print emailProvider
    * def emailProvider_registered_array = $.data.email.social.profiles.emailProvider..registered
    * print emailProvider_registered_array
    * def count_emailProvider_registered_profiles = emailProvider_registered_array.filter(x => x == true).length
    * print count_emailProvider_registered_profiles
    * match count_emailProvider_registered_profiles == $.data.email.social.summary.registeredEmailProviderProfiles
    * set payload.response.data.email.social.profiles.emailProvider.google.photo = "#ignore"
    * match $.data.email.social.profiles.emailProvider.yahoo == payload.response.data.email.social.profiles.emailProvider.yahoo
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                             | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_yahoo_false | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_yahoo_true  | 200        |

  #fido ecommerce - fido gives { amazon, ebay , deliveroo}
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = ecommerce - amazon - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/ecommerce/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredEcommerceProfiles == $.data.email.social.summary.registeredEcommerceProfiles
    * def ecommerce = $.data.email.social.profiles.ecommerce
    * print ecommerce
    * def ecommerce_registered_array = $.data.email.social.profiles.ecommerce..registered
    * print ecommerce_registered_array
    * def count_ecommerce_registered_profiles = ecommerce_registered_array.filter(x => x == true).length
    * print count_ecommerce_registered_profiles
    * match count_ecommerce_registered_profiles == $.data.email.social.summary.registeredEcommerceProfiles
    * match payload.response.data.email.social.profiles.ecommerce.amazon == $.data.email.social.profiles.ecommerce.amazon
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                             | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_true     | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_false    | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = ecommerce - deliveroo -  <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/ecommerce/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredEcommerceProfiles == $.data.email.social.summary.registeredEcommerceProfiles
    * def ecommerce = $.data.email.social.profiles.ecommerce
    * print ecommerce
    * def ecommerce_registered_array = $.data.email.social.profiles.ecommerce..registered
    * print ecommerce_registered_array
    * def count_ecommerce_registered_profiles = ecommerce_registered_array.filter(x => x == true).length
    * print count_ecommerce_registered_profiles
    * match count_ecommerce_registered_profiles == $.data.email.social.summary.registeredEcommerceProfiles
    * match payload.response.data.email.social.profiles.ecommerce.deliveroo == $.data.email.social.profiles.ecommerce.deliveroo
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                             | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_deliveroo_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_deliveroo_false | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile  = ecommerce - ebay - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/ecommerce/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredEcommerceProfiles == $.data.email.social.summary.registeredEcommerceProfiles
    * def ecommerce = $.data.email.social.profiles.ecommerce
    * print ecommerce
    * def ecommerce_registered_array = $.data.email.social.profiles.ecommerce..registered
    * print ecommerce_registered_array
    * def count_ecommerce_registered_profiles = ecommerce_registered_array.filter(x => x == true).length
    * print count_ecommerce_registered_profiles
    * match count_ecommerce_registered_profiles == $.data.email.social.summary.registeredEcommerceProfiles
    * match payload.response.data.email.social.profiles.ecommerce.ebay == $.data.email.social.profiles.ecommerce.ebay
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                             | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_ebay_true       | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_ebay_false      | 200        |

  #      Below socialMedia realeted scanarios are covered in the above test cases, so commented the old test cases
  #  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = ecommerce   - <Scenario>
  #    Given url requestUrl
  #    And def payload = read( "../"  + source + "/EMAIL_SOCIAL_FIDO_V2/ecommerce/<Scenario>.json")
  #    And headers headers
  #    And header Authorization = BearerToken
  #    And request payload.request
  #    * set payload.response.meta.referenceId = "#ignore"
  #    When method POST
  #  # cloud watch traces -start
  #    * print karate.request.headers
  #    * print karate.response.headers
  #    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
  #    * def reference_id = karate.request.headers['x-reference-id']
  #    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
  #    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
  #  # ResponseTime
  #    * print 'responseTime----->',responseTime
  #  # Request-response
  #    * print 'API Request----->',payload.request
  #    * print 'Expected Response---->',payload.response
  #    * print 'Actual Response---->',karate.pretty(response)
  #    Then status <statusCode>
  #    * match payload.response.data.email.social.summary.registeredEcommerceProfiles == $.data.email.social.summary.registeredEcommerceProfiles
  #    * match payload.response.data.email.social.profiles.ecommerce == $.data.email.social.profiles.ecommerce
  #
  #    * match  $.meta contains  payload.response.meta
  #    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
  #
  #    Examples:
  #      | Scenario                                                    | statusCode |
  #    #NO data found      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_ebay_true       | 200        |
  #    # NO data found  | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_ebay_false      | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_true_ebay_false | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_false_ebay_null | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_true_ebay_null  | 200        |

  #fido gives socialMedia profiles{facebook,instagram,pinterest,twitter, gravatar with photo}
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = socialMedia   - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/socialMedia/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredSocialMediaProfiles == $.data.email.social.summary.registeredSocialMediaProfiles
    * def socialMedia = $.data.email.social.profiles.socialMedia
    * print socialMedia
    * def socialMedia_registered_array = $.data.email.social.profiles.socialMedia..registered
    * print socialMedia_registered_array
    * def count_socialMedia_registered_profiles = socialMedia_registered_array.filter(x => x == true).length
    * print count_socialMedia_registered_profiles
    * match count_socialMedia_registered_profiles == $.data.email.social.summary.registeredSocialMediaProfiles
    * set payload.response.data.email.social.profiles.socialMedia.gravatar.photo = "#ignore"
    * match $.data.email.social.profiles.socialMedia.gravatar.photo == "##regex ^.*(https://).*"
    * match  $.data.email.social.profiles.socialMedia == payload.response.data.email.social.profiles.socialMedia
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                               | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_twitter_true       | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_twitter_false      | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_true_twitter_false | 200        |
      #  Data not found   | EMAIL_SOCIAL_FIDO_profiles_socialMedia_gravatar_true_without_photo                     | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_gravatar_true_with_photo                        | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_gravatar_false                                  | 200        |

  #fido gives only {skype with name,id,city,country,state,photo}  messaging profiles | registeredMessagingProfiles <= 1
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = messaging   - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/messaging/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredMessagingProfiles == $.data.email.social.summary.registeredMessagingProfiles
    * def messaging = $.data.email.social.profiles.messaging
    * print messaging
    * def messaging_registered_array = $.data.email.social.profiles.messaging..registered
    * print messaging_registered_array
    * def count_messaging_registered_profiles = messaging_registered_array.filter(x => x == true).length
    * print count_messaging_registered_profiles
    * match count_messaging_registered_profiles == $.data.email.social.summary.registeredMessagingProfiles

    * match payload.response.data.email.social.profiles.messaging == $.data.email.social.profiles.messaging

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                          | statusCode |
      # data not found     | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_true_without_other_skype_data_points | 200        |
      | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_true_with_other_data_points_name_id | 200        |
      #      | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_true_with_other_data_points_name_id_city_state_country | 200        |
      #  https://monnai.atlassian.net/browse/MB-3818
      | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_false                               | 200        |

  #fido gives only {skype with name,id,city,country,state,photo}  messaging profiles | registeredMessagingProfiles <= 1
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = messaging - skype with photo  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/messaging/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredMessagingProfiles == $.data.email.social.summary.registeredMessagingProfiles
    * def messaging = $.data.email.social.profiles.messaging
    * print messaging
    * def messaging_registered_array = $.data.email.social.profiles.messaging..registered
    * print messaging_registered_array
    * def count_messaging_registered_profiles = messaging_registered_array.filter(x => x == true).length
    * print count_messaging_registered_profiles
    * match count_messaging_registered_profiles == $.data.email.social.summary.registeredMessagingProfiles
    * set payload.response.data.email.social.profiles.messaging.skype.photo = "#ignore"
    * match $.data.email.social.profiles.messaging == payload.response.data.email.social.profiles.messaging
    * match $.data.email.social.profiles.messaging.skype.photo == "#regex ^.*(https://).*"
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                             | statusCode |
      | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_true_with_other_data_points_name_id_city_state_country | 200        |
      | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_true_with_other_data_points_photo                      | 200        |


  #fido gives list for professional profiles {wordpress,linkedin,microsoft,hubspot}
  #  After discussion with roopa to avoid more failure due to dynamic data we have validated each profile separatly
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_microsoft_hubspot_true                 | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_microsoft_hubspot_true_wordpress_false | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_microsoft_hubspot_false                | 200        |


  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = professional - wordpress <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/professional/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredProfessionalProfiles == $.data.email.social.summary.registeredProfessionalProfiles
    * def professional = $.data.email.social.profiles.professional
    * print professional
    * def professional_registered_array = $.data.email.social.profiles.professional..registered
    * print professional_registered_array
    * def count_professional_registered_profiles = professional_registered_array.filter(x => x == true).length
    * print count_professional_registered_profiles
    * match count_professional_registered_profiles == $.data.email.social.summary.registeredProfessionalProfiles
    * match payload.response.data.email.social.profiles.professional.wordpress == $.data.email.social.profiles.professional.wordpress
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_professional_wordpress_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_professional_wordpress_false | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_professional_wordpress_null  | 200        |


  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = professional - atlassian <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/professional/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredProfessionalProfiles == $.data.email.social.summary.registeredProfessionalProfiles
    * def professional = $.data.email.social.profiles.professional
    * print professional
    * def professional_registered_array = $.data.email.social.profiles.professional..registered
    * print professional_registered_array
    * def count_professional_registered_profiles = professional_registered_array.filter(x => x == true).length
    * print count_professional_registered_profiles
    * match count_professional_registered_profiles == $.data.email.social.summary.registeredProfessionalProfiles

    * match payload.response.data.email.social.profiles.professional.atlassian == $.data.email.social.profiles.professional.atlassian

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_professional_atlassian_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_professional_atlassian_false | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_atlassian_null                 | 200        |


  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = professional - linkedin <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/professional/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredProfessionalProfiles == $.data.email.social.summary.registeredProfessionalProfiles
    * def professional = $.data.email.social.profiles.professional
    * print professional
    * def professional_registered_array = $.data.email.social.profiles.professional..registered
    * print professional_registered_array
    * def count_professional_registered_profiles = professional_registered_array.filter(x => x == true).length
    * print count_professional_registered_profiles
    * match count_professional_registered_profiles == $.data.email.social.summary.registeredProfessionalProfiles

    * match payload.response.data.email.social.profiles.professional.linkedin == $.data.email.social.profiles.professional.linkedin

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                               | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_false | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_null  | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = professional - microsoft <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/professional/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredProfessionalProfiles == $.data.email.social.summary.registeredProfessionalProfiles
    * def professional = $.data.email.social.profiles.professional
    * print professional
    * def professional_registered_array = $.data.email.social.profiles.professional..registered
    * print professional_registered_array
    * def count_professional_registered_profiles = professional_registered_array.filter(x => x == true).length
    * print count_professional_registered_profiles
    * match count_professional_registered_profiles == $.data.email.social.summary.registeredProfessionalProfiles

    * match payload.response.data.email.social.profiles.professional.microsoft == $.data.email.social.profiles.professional.microsoft

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_professional_microsoft_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_professional_microsoft_false | 200        |
  #  100% coverage - so not possible to get null    | EMAIL_SOCIAL_FIDO_profiles_professional_microsoft_null                | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = professional - hubspot <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/professional/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredProfessionalProfiles == $.data.email.social.summary.registeredProfessionalProfiles
    * def professional = $.data.email.social.profiles.professional
    * print professional
    * def professional_registered_array = $.data.email.social.profiles.professional..registered
    * print professional_registered_array
    * def count_professional_registered_profiles = professional_registered_array.filter(x => x == true).length
    * print count_professional_registered_profiles
    * match count_professional_registered_profiles == $.data.email.social.summary.registeredProfessionalProfiles

    * match payload.response.data.email.social.profiles.professional.hubspot == $.data.email.social.profiles.professional.hubspot

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                              | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_professional_hubspot_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_professional_hubspot_false | 200        |
  #  100% coverage - so not possible to get null     | EMAIL_SOCIAL_FIDO_profiles_professional_hubspot_null                | 200        |


  #fido gives  entertainment profiles {spotify,disneyplus} | "registeredEntertainmentProfiles" <= 2,
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = entertainment - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/entertainment/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredEntertainmentProfiles == $.data.email.social.summary.registeredEntertainmentProfiles
    * def entertainment = $.data.email.social.profiles.professional
    * print entertainment
    * def entertainment_registered_array = $.data.email.social.profiles.entertainment..registered
    * print entertainment_registered_array
    * def count_entertainment_registered_profiles = entertainment_registered_array.filter(x => x == true).length
    * print count_entertainment_registered_profiles
    * match count_entertainment_registered_profiles == $.data.email.social.summary.registeredEntertainmentProfiles


    * match payload.response.data.email.social.profiles.entertainment == $.data.email.social.profiles.entertainment

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                               | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_disneyplus_true       | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_disneyplus_false      | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_true_disneyplus_false | 200        |
  # no data      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_false_disneyplus_true | 200        |
  # no data     | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_disneyplus_null | 200        |


  #fido gives only { booking}  travel profiles | registeredTravelProfiles <= 1
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = travel (dynamic in both FIdo V1 and V2)  - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/travel/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredTravelProfiles ==  "#notpresent"
    * match payload.response.data.email.social.profiles.travel == "#notpresent"

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                   | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_travel_datapoint_dynamic_hidden | 200        |

  #fido gives only { booking}  travel profiles | registeredTravelProfiles <= 1
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = travel   - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/travel/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredTravelProfiles == $.data.email.social.summary.registeredTravelProfiles
    * def travel = $.data.email.social.profiles.travel
    * print travel
    * def travel_registered_array = $.data.email.social.profiles.travel..registered
    * print travel_registered_array
    * def count_travel_registered_profiles = travel_registered_array.filter(x => x == true).length
    * print count_travel_registered_profiles
    * match count_travel_registered_profiles == $.data.email.social.summary.registeredTravelProfiles

    * match payload.response.data.email.social.profiles.travel == $.data.email.social.profiles.travel

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                    | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_travel_booking_true_airbnb_null  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_travel_booking_false_airbnb_null | 200        |

  #fido gives only {paypal,binance} as financial profiles | registeredFinancialProfiles <= 2
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = financial - paypal - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/financial/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredFinancialProfiles == $.data.email.social.summary.registeredFinancialProfiles
    * def financial = $.data.email.social.profiles.financial
    * print financial
    * def financial_registered_array = $.data.email.social.profiles.financial..registered
    * print financial_registered_array
    * def count_financial_registered_profiles = financial_registered_array.filter(x => x == true).length
    * print count_financial_registered_profiles
    * match count_financial_registered_profiles == $.data.email.social.summary.registeredFinancialProfiles

    * match payload.response.data.email.social.profiles.financial.paypal == $.data.email.social.profiles.financial.paypal

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                           | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_financial_paypal_true   | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_financial_paypal_false  | 200        |
      # Data changed     | EMAIL_SOCIAL_FIDO_profiles_financial_paypal_null | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = financial - binance - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/financial/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredFinancialProfiles == $.data.email.social.summary.registeredFinancialProfiles
    * def financial = $.data.email.social.profiles.financial
    * print financial
    * def financial_registered_array = $.data.email.social.profiles.financial..registered
    * print financial_registered_array
    * def count_financial_registered_profiles = financial_registered_array.filter(x => x == true).length
    * print count_financial_registered_profiles
    * match count_financial_registered_profiles == $.data.email.social.summary.registeredFinancialProfiles

    * match payload.response.data.email.social.profiles.financial.binance == $.data.email.social.profiles.financial.binance

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                           | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_financial_binance_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_financial_binance_false | 200        |

  #fido gives only {duolingo} as education profiles | registeredEducationProfiles <= 1
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = education   - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/education/<Scenario>.json")
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
    #    * match payload.response.data.email.social.summary.registeredEducationProfiles == $.data.email.social.summary.registeredEducationProfiles
    * def education = $.data.email.social.profiles.education
    * print education
    * def education_registered_array = $.data.email.social.profiles.education..registered
    * print education_registered_array
    * def count_education_registered_profiles = education_registered_array.filter(x => x == true).length
    * print count_education_registered_profiles
    * match count_education_registered_profiles == $.data.email.social.summary.registeredEducationProfiles

    * match payload.response.data.email.social.profiles.education == $.data.email.social.profiles.education

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                            | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_education_duolingo_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_education_duolingo_false | 200        |
  #  Data not found    | EMAIL_SOCIAL_FIDO_profiles_financial_paypal_null | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Negative scenario with invalid input - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/<Scenario>.json")
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
    Then match $ contains payload.response
    #    And match $.errors[1].message == "Invalid email address"
    #    And match $.response.errors[1].message == "Invalid email address"

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                        | statusCode |
      #    Test cases depricated
      | Email_Social_Negative_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
      | Email_Social_Negative_Onlyprefix_without@_NoDomainName(abc)     | 400        |
      | Email_Social_Negative_withPrefix_with@_NoDomainName(abc@)       | 400        |
  #    Test cases craeted but changes not yet deployed depricated
  #      | Email_Social_Negative_NoPrefix_with@_withDomainName(@gmail.com)_domainType_invalid_email | 200        |
  #      | Email_Social_Negative_Onlyprefix_without@_NoDomainName(abc)_domainType_invalid_email     | 400        |
  #      | Email_Social_Negative_withPrefix_with@_NoDomainName(abc@)_domainType_invalid_domain       | 400        |

  Scenario Outline:  DPI EMAIL_SOCIAL Negative scenario with null/empty input - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/<Scenario>.json")
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
    Then match $ contains payload.response
    #    And match $.errors[1].message == "Email cannot be empty/null"
    #    And match $.response.errors[1].message == "Email cannot be empty/null"

    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                             | statusCode |
      | Email_Social_Negative_Emptyinput('') | 400        |
      | Email_Social_Negative_NullInput(' ') | 400        |


  Scenario Outline:  DPI EMAIL_SOCIAL Negative scenario for Schema_validation_1 - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/<Scenario>.json")
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

    And match $.data.email.social == '#notnull'
    And match $.data.email.basic == '#null'
    And match $.data.email.social.summary contains deep {"registeredProfiles":"#present","registeredConsumerElectronicsProfiles":"#present","registeredEmailProviderProfiles":"#present","registeredEcommerceProfiles":"#present","registeredSocialMediaProfiles":"#present","registeredMessagingProfiles":"#present","registeredProfessionalProfiles":"#present","registeredEntertainmentProfiles":"#present","registeredTravelProfiles":"#present","registeredFinancialProfiles":"#present","ageOnSocial":"#present","numberOfNamesReturned":"#present","numberOfPhotosReturned":"#present"}
    And match $.data.email.social.profiles.consumerElectronics contains deep {"apple":{"registered":"#present"},"samsung":{"registered":"#present"}}
    And match $.data.email.social.profiles.emailProvider contains deep {"google":{"registered":"#present","photo":"#present"},"yahoo":{"registered":"#present"},"mailru":{"registered":"#present"},"rambler":{"registered":"#present"}}
    And match $.data.email.social.profiles.ecommerce contains deep {"amazon":{"registered":"#present"},"ebay":{"registered":"#present"},"flipkart":{"registered":"#present"},"jdid":{"registered":"#present"},"bukalapak":{"registered":"#present"},"lazada":{"registered":"#present"},"tokopedia":{"registered":"#present"}}
    And match $.data.email.social.profiles.socialMedia contains deep {"facebook":{"registered":"#present","name":"#present","photo":"#present","url":"#present"},"instagram":{"registered":"#present"},"flickr":{"registered":"#present","username":"#present"},"pinterest":{"registered":"#present"},"twitter":{"registered":"#present"},"tumblr":{"registered":"#present"},"weibo":{"registered":"#present"},"ok":{"registered":"#present","age":"#present","city":"#present","dateJoined":"#present"},"imgur":{"registered":"#present"},"quora":{"registered":"#present"},"qzone":{"registered":"#present"},"gravatar":{"registered":"#present","location":"#present","name":"#present","profileUrl":"#present","username":"#present"},"foursquare":{"registered":"#present","bio":"#present","photo":"#present","profileUrl":"#present"},"myspace":{"registered":"#present"}}
    And match $.data.email.social.profiles.messaging contains deep {"skype":{"registered":"#present","language":"#present","gender":"#present","name":"#present","id":"#present","handle":"#present","bio":"#present","age":"#present","city":"#present","state":"#present","country":"#present","photo":"#present"},"discord":{"registered":"#present"},"kakao":{"registered":"#present"}}
    And match $.data.email.social.profiles.professional contains deep {"github":{"registered":"#present"},"wordpress":{"registered":"#present"},"atlassian":{"registered":"#present"},"linkedin":{"registered":"#present","url":"#present","name":"#present","company":"#present","title":"#present","location":"#present","website":"#present","twitter":"#present","photo":"#present","connectionCount":"#present"},"evernote":{"registered":"#present"},"microsoft":{"registered":"#present"},"zoho":{"registered":"#present"},"adobe":{"registered":"#present"},"hubspot":{"registered":"#present"}}
    And match $.data.email.social.profiles.entertainment contains deep {"spotify":{"registered":"#present"},"lastfm":{"registered":"#present"},"vimeo":{"registered":"#present"},"envato":{"registered":"#present"},"patreon":{"registered":"#present"},"disneyplus":{"registered":"#present"},"netflix":{"registered":"#present"},"archiveorg":{"registered":"#present"}}
    And match $.data.email.social.profiles.travel contains deep {"booking":{"registered":"#present"},"airbnb":{"registered":"#present","about":"#present","createdAt":"#present","name":"#present","identityVerified":"#present","location":"#present","photo":"#present","revieweeCount":"#present","trips":"#present","work":"#present"}}
    And match $.data.email.social.profiles.financial contains deep {"paypal":{"registered":"#present"}}

    And match $.data contains {"phone":null,"address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    And match $.meta contains deep {"referenceId":"#present","inputEmail":"#present","requestedPackages":["EMAIL_SOCIAL"]}
    And match $.errors == []


    Examples:
      | Scenario                              | statusCode |
      | Email_Basic_FIDO_V2_Schema_validation | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Negative scenario for Schema_validation_2 - <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_SOCIAL_FIDO_V2/<Scenario>.json")
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
    Then match $ contains deep
      """
      {
        "data": {
          "phone": null,
          "email": {
            "social": {
              "summary": {
                "registeredProfiles": '#present',
                "registeredConsumerElectronicsProfiles": '#present',
                "registeredEmailProviderProfiles": '#present',
                "registeredEcommerceProfiles": '#present',
                "registeredSocialMediaProfiles": '#present',
                "registeredMessagingProfiles": '#present',
                "registeredProfessionalProfiles": '#present',
                "registeredEntertainmentProfiles": '#present',
                "registeredTravelProfiles": '#present',
                "registeredFinancialProfiles": '#present',
                "registeredEducationProfiles":'#present',
                "ageOnSocial": '#present',
                "numberOfNamesReturned": '#present',
                "numberOfPhotosReturned": '#present'
              },
              "profiles": {
                "consumerElectronics": {
                  "apple": {
                    "registered": '#present'
                  },
                  "samsung": {
                    "registered": '#present'
                  }
                },
                "emailProvider": {
                  "google": {
                    "registered": '#present',
                    "name": '#present',
                    "photo": '##present',
                    "gender":  '#present'
                  },
                  "yahoo": {
                    "registered": '#present'
                  },
                  "mailru": {
                    "registered": '#present'
                  },
                  "rambler": {
                    "registered": '#present'
                  }
                },
                "ecommerce": {
                  "amazon": {
                    "registered": '#present'
                  },
                  "ebay": {
                    "registered": '#present'
                  },
                  "flipkart": {
                    "registered": '#present'
                  },
                  "jdid": {
                    "registered": '#present'
                  },
                  "bukalapak": {
                    "registered": '#present'
                  },
                  "lazada": {
                    "registered": '#present'
                  },
                  "tokopedia": {
                    "registered": '#present'
                  },
                  "deliveroo": {
                    "registered": '#present'
                  }
                },
                "socialMedia": {
                  "facebook": {
                    "registered": '#present',
                    "name": '#present',
                    "photo": '#present',
                    "url": '#present'
                  },
                  "instagram": {
                    "registered": '#present'
                  },
                  "flickr": {
                    "registered": '#present',
                    "username": '#present'
                  },
                  "pinterest": {
                    "registered": '#present'
                  },
                  "twitter": {
                    "registered": '#present'
                  },
                  "tumblr": {
                    "registered": '#present'
                  },
                  "weibo": {
                    "registered": '#present'
                  },
                  "ok": {
                    "registered": '#present',
                    "age": '#present',
                    "city": '#present',
                    "dateJoined": '#present'
                  },
                  "imgur": {
                    "registered": '#present'
                  },
                  "quora": {
                    "registered": '#present'
                  },
                  "qzone": {
                    "registered": '#present'
                  },
                  "gravatar": {
                    "registered": '#present',
                    "location": '#present',
                    "name": '#present',
                    "profileUrl": '#present',
                    "username": '#present'
                  },
                  "foursquare": {
                    "registered": '#present',
                    "bio": '#present',
                    "photo": '#present',
                    "profileUrl": '#present'
                  },
                  "myspace": {
                    "registered": '#present'
                  }
                },
                "messaging": {
                  "skype": {
                    "registered": '#present',
                    "language": '#present',
                    "gender": '#present',
                    "name": '#present',
                    "id": '#present',
                    "handle": '#present',
                    "bio": '#present',
                    "age": '#present',
                    "city": '#present',
                    "state": '#present',
                    "country": '#present',
                    "photo": '#present'
                  },
                  "discord": {
                    "registered": '#present'
                  },
                  "kakao": {
                    "registered": '#present'
                  }
                },
                "professional": {
                  "github": {
                    "registered": '#present'
                  },
                  "wordpress": {
                    "registered": '#present'
                  },
                  "atlassian": {
                    "registered": '#present'
                  },
                  "linkedin": {
                    "registered": '#present',
                    "url": '#present',
                    "name": '#present',
                    "company": '#present',
                    "title": '#present',
                    "location": '#present',
                    "website": '#present',
                    "twitter": '#present',
                    "photo": '#present',
                    "connectionCount": '#present'
                  },
                  "evernote": {
                    "registered": '#present'
                  },
                  "microsoft": {
                    "registered": '#present'
                  },
                  "zoho": {
                    "registered": '#present'
                  },
                  "adobe": {
                    "registered": '#present'
                  },
                  "hubspot": {
                    "registered": '#present'
                  }
                },
                "entertainment": {
                  "spotify": {
                    "registered": '#present'
                  },
                  "lastfm": {
                    "registered": '#present'
                  },
                  "vimeo": {
                    "registered": '#present'
                  },
                  "envato": {
                    "registered": '#present'
                  },
                  "patreon": {
                    "registered": '#present'
                  },
                  "disneyplus": {
                    "registered": '#present'
                  },
                  "netflix": {
                    "registered": '#present'
                  },
                  "archiveorg": {
                    "registered": '#present'
                  }
                },
                "travel": {
                  "booking": {
                    "registered": '#present'
                  },
                  "airbnb": {
                    "registered": '#present',
                    "about": '#present',
                    "createdAt": '#present',
                    "name": '#present',
                    "identityVerified": '#present',
                    "location": '#present',
                    "photo": '#present',
                    "revieweeCount": '#present',
                    "trips": '#present',
                    "work": '#present'
                  }
                },
                "financial": {
                  "paypal": {
                    "registered": '#present'
                  },
                  "binance": {
                    "registered": '##present'
                  }
                },
                "education": {
                  "duolingo": {
                    "registered":'#present'
                  }
                }
              }
            },
            "basic": '#null'
          },
          "address":  '#null',
          "name":  '#null',
          "ip":  '#null',
          "identity":  '#null',
          "upi":  '#null',
          "device":  '#null',
          "employment":  '#null',
          "income":  '#null',
          "blacklist":  '#null',
          "domain":'#null',
          "kyc": '#null',
          "bank":'#null',
          "aadhaar":'#null',
          "statement":'#null',
          "bre":  '#null'
        },
        "meta": {
          "referenceId": '#present',
          "inputEmail": '#present',
          "requestedPackages": [
            "EMAIL_SOCIAL"
          ]
        },
        "errors": '#array'
      }
      """
    Examples:
      | Scenario                              | statusCode |
      | Email_Basic_FIDO_V2_Schema_validation | 200        |