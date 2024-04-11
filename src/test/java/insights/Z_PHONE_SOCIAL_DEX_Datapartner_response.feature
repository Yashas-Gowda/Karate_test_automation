@ignore @data_partner_res_phone_social
Feature: PHONE_SOCIAL FIDO_phone_socail Data Partner automation via DPI DEX call

  Background:
    * configure charset = null
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline: PHONE_SOCIAL FIDO_phone_socail Data Partner automation via DPI DEX call - <Scenario>
    * def dexUrl = requestUrl + '/api/exchange/01H72XCMJ3A08W8MREYD8T1EBS'
    Given url dexUrl
    And def payload = read("data/" + source + "/PHONE_SOCIAL_FIDO_V2/<Scenario>.json")
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
      | PHONE_SOCIAL_Happy_flow | 200        |

      | PHONE_SOCIAL_country_Brazil_response           | 200        |
      | PHONE_SOCIAL_country_Indonesia_response        | 200        |
      | PHONE_SOCIAL_country_Italy_IT_response         | 200        |
      | PHONE_SOCIAL_country_Malaysia_response         | 200        |
      | PHONE_SOCIAL_country_UnitedKingdom_GB_response | 200        |
      | PHONE_SOCIAL_country_Vietnam_VN_response       | 200        |

      | PHONE_SOCIAL_country_Philippines_response     | 200        |
      | PHONE_SOCIAL_country_UnitedStates_US_response | 200        |

      | PHONE_SOCIAL_FIDO_profiles_emailProvider_google_registered_true  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_emailProvider_google_registered_false | 200        |

      | PHONE_SOCIAL_FIDO_profiles_ecommerce_amazon_registered_true   | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_amazon_registered_false  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_amazon_registered_null   | 200        |

      | PHONE_SOCIAL_FIDO_profiles_ecommerce_flipkart_registered_true | 200        |
      #  data not found    | PHONE_SOCIAL_FIDO_profiles_ecommerce_flipkart_registered_false      | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_flipkart_registered_null | 200        |

      | PHONE_SOCIAL_FIDO_profiles_ecommerce_bukalapak_registered_true | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_bukalapak_registered_false   | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_bukalapak_registered_null   | 200        |

      | PHONE_SOCIAL_FIDO_profiles_socialMedia_facebook_twitter_instagram_registered_true  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_socialMedia_facebook_twitter_instagram_registered_null  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_socialMedia_facebook_twitter_instagram_registered_false | 200        |

      | PHONE_SOCIAL_FIDO_profiles_professional_microsoft_registered_true          | 200        |
      | PHONE_SOCIAL_FIDO_profiles_professional_microsoft_registered_false         | 200        |
      | PHONE_SOCIAL_FIDO_profiles_professional_microsoft_linkedin_registered_null | 200        |

      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true                                           | 200        |
      #      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_registered_photo_privacyStatus_lastSeen_null                       | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true_with_photo_privacyStatus_PUBLIC           | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true_without_photo_with_privacyStatus_PRIVATE  | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_false_whatsapp_registered_true_with_photo_privacyStatus_PUBLIC     | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_false_whatsapp_registered_true_with_photo_privacyStatus_PRIVATE    | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_whatsapp_false_telegram_registered_true_with_photo_privacyStatus_PUBLIC     | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_whatsapp_false_telegram_registered_true_without_photo_privacyStatus_PRIVATE | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_viber_skype_false                                                           | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_viber_registered_photo_lastSeen_name_null                                   | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_viber_registered_true_with_name                                             | 200        |

      | PHONE_SOCIAL_FIDO_profiles_messaging_viber_registered_true_with_lastSeen_name | 200        |

      | PHONE_SOCIAL_FIDO_V2_all_data_points_Schema_Validation | 200        |








