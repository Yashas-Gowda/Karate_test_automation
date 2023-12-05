
Feature: Testing of DPI  - EMAIL_SOCIAL feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

    # "Monnai to datapartner mapping is not tested/validated while automating, after discussion roopa suggested to take sameena tested DPI test as source of truth
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/<Scenario>.json")
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
    And match $.data.email.social == '#notnull'
    And match $.data.email.social.summary == '#notnull'
    And match $.data.email.social.profiles == '#notnull'

#    * match $.data.email.social.profiles.professional.linkedin.photo == "##string"
#    * match $.data.email.social.profiles.emailProvider.google.photo == "##string"
#    * set payload.response.data.email.social.profiles.professional.linkedin.photo = "#ignore"
#    * set payload.response.data.email.social.profiles.emailProvider.google.photo = "#notnull"
#    * print payload.response
    Then status <statusCode>
#    Then match $ contains payload.response
    * match payload.response.data.email.social.summary == $.data.email.social.summary
    * match payload.response.data.email.social.profiles.consumerElectronics == $.data.email.social.profiles.consumerElectronics
    * match payload.response.data.email.social.profiles.emailProvider == $.data.email.social.profiles.emailProvider
    * match payload.response.data.email.social.profiles.ecommerce == $.data.email.social.profiles.ecommerce
    * match payload.response.data.email.social.profiles.socialMedia == $.data.email.social.profiles.socialMedia
    * match payload.response.data.email.social.profiles.messaging == $.data.email.social.profiles.messaging
    * match payload.response.data.email.social.profiles.professional == $.data.email.social.profiles.professional
    * match payload.response.data.email.social.profiles.entertainment == $.data.email.social.profiles.entertainment
    * match payload.response.data.email.social.profiles.travel == $.data.email.social.profiles.travel
    * match payload.response.data.email.social.profiles.financial == $.data.email.social.profiles.financial

    * match $.data contains {"phone":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}

    Examples:
      | Scenario            | statusCode |
      | Email_Social_sanity | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = consumerElectronics   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/consumerElectronics/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredConsumerElectronicsProfiles == $.data.email.social.summary.registeredConsumerElectronicsProfiles
    * match payload.response.data.email.social.profiles.consumerElectronics == $.data.email.social.profiles.consumerElectronics

    Examples:
      | Scenario                                                   | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_apple_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_apple_false | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_apple_null  | 200        |

      # fido doen't give {mailru,rambler} gives only {google,yahoo}
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = emailProvider   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/emailProvider/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredEmailProviderProfiles == $.data.email.social.summary.registeredEmailProviderProfiles
    * match payload.response.data.email.social.profiles.emailProvider == $.data.email.social.profiles.emailProvider

    Examples:
      | Scenario                                                         | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_yahoo_true       | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_yahoo_false      | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_true_yahoo_false | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_false_yahoo_true | 200        |


  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = ecommerce   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/ecommerce/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredEcommerceProfiles == $.data.email.social.summary.registeredEcommerceProfiles
    * match payload.response.data.email.social.profiles.ecommerce == $.data.email.social.profiles.ecommerce

    Examples:
      | Scenario                                                    | statusCode |
#NO data found      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_ebay_true       | 200        |
      # NO data found      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_ebay_false      | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_true_ebay_false | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_false_ebay_null | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_true_ebay_null  | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = ecommerce   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/ecommerce/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredEcommerceProfiles == $.data.email.social.summary.registeredEcommerceProfiles
    * match payload.response.data.email.social.profiles.ecommerce == $.data.email.social.profiles.ecommerce

    Examples:
      | Scenario                                                    | statusCode |
#NO data found      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_ebay_true       | 200        |
      # NO data found  | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_ebay_false      | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_true_ebay_false | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_false_ebay_null | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_true_ebay_null  | 200        |

    #fido gives socialMedia profiles{facebook,instagram,pinterest,twitter}
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = socialMedia   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/socialMedia/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredSocialMediaProfiles == $.data.email.social.summary.registeredSocialMediaProfiles
    * match payload.response.data.email.social.profiles.socialMedia == $.data.email.social.profiles.socialMedia

    Examples:
      | Scenario                                                                                                   | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_twitter_true                           | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_twitter_false                          | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_true_twitter_false                     | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_twitter_true_instagram_pinterest_false | 200        |

    #fido gives no messaging profiles- always null | registeredMessagingProfiles = 0
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = messaging   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/messaging/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredMessagingProfiles == $.data.email.social.summary.registeredMessagingProfiles
    * match payload.response.data.email.social.profiles.messaging == $.data.email.social.profiles.messaging

    Examples:
      | Scenario                                  | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_messaging_null | 200        |

     #fido gives  professional profiles {linkedin,microsoft,hubspot}
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = professional - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/professional/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredProfessionalProfiles == $.data.email.social.summary.registeredProfessionalProfiles
    * match payload.response.data.email.social.profiles.professional == $.data.email.social.profiles.professional

    Examples:
      | Scenario                                                                                | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_microsoft_hubspot_true                 | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_microsoft_hubspot_true_wordpress_false | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_microsoft_hubspot_false                | 200        |

      #fido gives  professional profiles {spotify,disneyplus}
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = entertainment - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/entertainment/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredEntertainmentProfiles == $.data.email.social.summary.registeredEntertainmentProfiles
    * match payload.response.data.email.social.profiles.entertainment == $.data.email.social.profiles.entertainment

    Examples:
      | Scenario                                                               | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_disneyplus_true       | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_disneyplus_false      | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_true_disneyplus_false | 200        |
# no data      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_false_disneyplus_true | 200        |

 #fido gives no financial profiles- always null | registeredTravelProfiles = 0
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = travel   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/travel/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredTravelProfiles == $.data.email.social.summary.registeredTravelProfiles
    * match payload.response.data.email.social.profiles.travel == $.data.email.social.profiles.travel

    Examples:
      | Scenario                                  | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_travel_null | 200        |

     #fido gives no financial profiles-{paypal}
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios for validating profile = financial   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO/financial/<Scenario>.json")
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
    * match payload.response.data.email.social.summary.registeredFinancialProfiles == $.data.email.social.summary.registeredFinancialProfiles
    * match payload.response.data.email.social.profiles.financial == $.data.email.social.profiles.financial

    Examples:
      | Scenario                                   | statusCode |
      | EMAIL_SOCIAL_FIDO_profiles_financial_true  | 200        |
      | EMAIL_SOCIAL_FIDO_profiles_financial_false | 200        |

  Scenario Outline:  DPI EMAIL_BASIC Negative scenario with invalid input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL/<Scenario>.json")
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

    Examples:
      | Scenario                                                        | statusCode |
      | Email_Social_Negative_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
      | Email_Social_Negative_Onlyprefix_without@_NoDomainName(abc)     | 400        |
      | Email_Social_Negative_withPrefix_with@_NoDomainName(abc@)       | 400        |

  Scenario Outline:  DPI EMAIL_BASIC Negative scenario with null/empty input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL/<Scenario>.json")
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

    Examples:
      | Scenario                             | statusCode |
      | Email_Social_Negative_Emptyinput('') | 400        |
      | Email_Social_Negative_NullInput(' ') | 400        |

  @Schema_validation_1
  Scenario Outline:  DPI EMAIL_BASIC Negative scenario for Schema_validation_1 - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL/<Scenario>.json")
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
      | Scenario                                                        | statusCode |
      | Email_Social_consumerElectronics_Registered_ageOnSocial_is_null | 200        |

  @Schema_validation_2
  Scenario Outline:  DPI EMAIL_BASIC Negative scenario for Schema_validation_2 - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL/<Scenario>.json")
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
							"photo": '#present'
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
      | Scenario                                                        | statusCode |
      | Email_Social_SocialMedia_Instagram&Pinterest&Twitter_Registered | 200        |