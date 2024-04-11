@ignore @data_partner_res_email_basic
Feature: EMAIL_BASIC FIDO_email_basic Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline: EMAIL_BASIC FIDO_email_basic Data Partner automation via DPI DEX call
    * def dexUrl = requestUrl + '/api/exchange/01H785HGK5PSKMST8QZSEDCAQY'
    Given url dexUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
    And headers headers
    And header Content-Type = "application/json"
    And header Authorization = BearerToken
    And request payload.request
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
    * print 'Monnai DPI Response---->',payload.response
    # Data partner-response
    * print 'DATA PARTNER Response---->',karate.pretty(response)


    Examples:
      | Scenario                              | statusCode |
      | Email_Basic_Possitive_withTLDGmail(abc@gmail.com)_disposable_false_emailTenure_notnull                          | 200        |
      | Email_Basic_Positive_disposable_false_deliverable_true_noOfBreaches_14_EmailTenure_Present_in_double_digit      | 200        |
      | Email_Basic_deliverable_true_disposable_false_noOfBreaches_1_emailTenure_in_decimal_value                       | 200        |
      | Email_Basic_deliverable_true_registered_true_freeProvider_true_noOfBreaches_7_emailTenure_in_single_digit_value | 200        |
      | Email_Basic_isBreached_false_emailTenure_null | 200        |
      | Email_Basic_freeProvider_false                 | 200        |
      | Email_Basic_deliverable_false                 | 200        |
      | Email_Basic_creationTime_updateTime_expiryTime_companyName_dmarcCompliance_spfStrict_suspiciousTld_custom_null_deliverable_registered_disposable_websiteExists_acceptAll_isBreached_freeProvider_false_emailTenure_null | 200        |
      | Email_Basic_Possitive_withDomainNet(abc@you.me.net)_deliverable_false_disposable_false_noOfBreaches_1_emailTenure_notnull                                                                                               | 200        |
      | Email_Basic_Possitive_withTLD&DomainOurearch(abc@ourearth.com)_creationTime_null_disposable_false_acceptAll_false_noOfBreaches_1_emailTenure_notnull                                                                    | 200        |
      | Email_Basic_EmailTenure_Is_NULL                             | 200        |
      | Email_Basic_Positive_isBreached_false_noOfBreaches_0       | 200        |
      | Email_Basic_FIDO_V2_Schema_validation | 200        |
      | Email_Basic_Negitive_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
      | Email_Basic_Negitive_withPrefix_with@_NoDomainName(abc@)       | 400        |
      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     | 400        |
      | Email_Basic_Negitive_with_2_different_multiple_email_input     | 400        |
      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     | 400        |
      | Email_Basic_Negitive_Emptyinput('')     | 400        |
      | Email_Basic_Negitive_Nullinput(' ')     | 400        |
      | Email_Basic_Negitive_Nullinput(null)    | 400        |
      | Email_Basic_Negitive_No_input_Email_key | 400        |

  #  Scenario Outline: EMAIL_SOCIAL FIDO_email_social Data Partner automation via DPI DEX call
  #    * def dexUrl = requestUrl + '/api/exchange/01H72X88KKK3R5013F54H5P09T'
  #    Given url dexUrl
  #    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO_V2/<Scenario>.json")
  #    And headers headers
  #    And header Content-Type = "application/json"
  #    And header Authorization = BearerToken
  #    And request payload.request
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
  #    * print 'Monnai DPI Response---->',payload.response
  #    # Data partner-response
  #    * print 'DATA PARTNER Response---->',karate.pretty(response)
  #
  #
  #    Examples:
  #      | Scenario                              | statusCode |
  #      #      | Email_Social_sanity_V2 | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_apple_true  | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_consumerElectronics_apple_false | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_yahoo_true       | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_yahoo_false      | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_true_yahoo_false | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_false_yahoo_true | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_with_name_photo             |200 |
  #      | EMAIL_SOCIAL_FIDO_profiles_emailProvider_google_with_name_photo_gender             |200 |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_true      | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_amazon_false      | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_ebay_true      | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_ebay_false      | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_deliveroo_true      | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_ecommerce_deliveroo_false      | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_twitter_true                           | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_twitter_false                          | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_facebook_instagram_pinterest_true_twitter_false                     | 200        |
  #      #  Data not found   | EMAIL_SOCIAL_FIDO_profiles_socialMedia_gravatar_true_without_photo                     | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_gravatar_true_with_photo                     | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_socialMedia_gravatar_false                     | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_true_with_other_data_points_name_id_city_state_country   | 200        |
  #      | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_true_with_other_data_points_name_id | 200        |
  #      #  https://monnai.atlassian.net/browse/MB-3818 | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_true_with_other_data_points_photo | 200        |
  #      | EMAIL_SOCIAL_FIDO_V1_profiles_messaging_skype_false                                     | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_wordpress_true                 | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_wordpress_false | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_wordpress_null                | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_linkedin_null                | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_microsoft_true                 | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_microsoft_false | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_hubspot_true                 | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_professional_hubspot_false | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_disneyplus_true       | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_disneyplus_false      | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_entertainment_spotify_true_disneyplus_false | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_travel_booking_true_airbnb_null | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_travel_booking_false_airbnb_null | 200        |
  #
  #      | EMAIL_SOCIAL_FIDO_profiles_financial_true  | 200        |
  #      | EMAIL_SOCIAL_FIDO_profiles_financial_false | 200        |
  #
  #      | Email_Social_Negative_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
  #      | Email_Social_Negative_Onlyprefix_without@_NoDomainName(abc)     | 400        |
  #      | Email_Social_Negative_withPrefix_with@_NoDomainName(abc@)       | 400        |
  #
  #      | Email_Social_Negative_Emptyinput('') | 400        |
  #      | Email_Social_Negative_NullInput(' ') | 400        |
  #
  #      |Email_Basic_FIDO_V2_Schema_validation  | 200        |

  #  Scenario Outline: PHONE_SOCIAL FIDO_phone_social Data Partner automation via DPI DEX call
  #    * def dexUrl = requestUrl + '/api/exchange/01H72XCMJ3A08W8MREYD8T1EBS'
  #    Given url dexUrl
  #    And def payload = read("data/" + source + "/EMAIL_SOCIAL_FIDO_V2/<Scenario>.json")
  #    And headers headers
  #    And header Content-Type = "application/json"
  #    And header Authorization = BearerToken
  #    And request payload.request
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
  #    * print 'Monnai DPI Response---->',payload.response
  #    # Data partner-response
  #    * print 'DATA PARTNER Response---->',karate.pretty(response)
  #
  #
  #    Examples:
  #      | Scenario                              | statusCode |

