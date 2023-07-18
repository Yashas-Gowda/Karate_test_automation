Feature: Testing of DPI  - PHONE_SOCIAL scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @PHONE_SOCIAL @seon
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match  $.data.phone.social contains  payload.response.data.phone.social
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Examples:
      | Scenario                | statusCode |
      | PHONE_SOCIAL_Happy_flow | 200        |

  @PHONE_SOCIAL @seon
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match  $.data.phone.social contains  payload.response.data.phone.social
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Examples:
      | Scenario                                                                                              | statusCode |
      | PHONE_SOCIAL_Seon_Summary_numberOfNamesReturned_1                                                     | 200        |
      | PHONE_SOCIAL_Seon_profiles_messaging_skype                                                            | 200        |
      | PHONE_SOCIAL_Seon_profiles_google_flipkart_facebook_instagram_twitter_snapchat_whatsapp_telegram_true | 200        |

  @PHONE_SOCIAL @seon
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match $.data.phone.social.summary.registeredEmailProviderProfiles == 1
    * match $.data.phone.social.summary.registeredEcommerceProfiles == 1
    * match $.data.phone.social.summary.registeredSocialMediaProfiles == 3
    * match $.data.phone.social.summary.registeredProfessionalProfiles == 1
    * match $.data.phone.social.summary.registeredMessagingProfiles == 4
    * match $.data.phone.social.summary.lastActivity == "#null"
    * match $.data.phone.social.summary.numberOfNamesReturned == 1
    * match $.data.phone.social.summary.numberOfPhotosReturned == 1

    * match  $.data.phone.social contains  payload.response.data.phone.social
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]


    Examples:
      | Scenario                                                                                              | statusCode |
      | PHONE_SOCIAL_Seon_profiles_google_flipkart_facebook_instagram_twitter_snapchat_whatsapp_telegram_true | 200        |

  @PHONE_SOCIAL @seon
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match $.data.phone.social.summary.lastActivity == 0

    * match  $.data.phone.social contains  payload.response.data.phone.social
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    Examples:
      | Scenario                            | statusCode |
      | PHONE_SOCIAL_summary_lastActivity_0 | 200        |


  @PHONE_SOCIAL @seon
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match $.data.phone.social.summary.lastActivity == 16
    * match $.data.phone.social.summary.numberOfNamesReturned == 1
    * match $.data.phone.social.summary.numberOfPhotosReturned == 2

    * match $.data.phone.social.profiles.messaging.line.registered == true
    * match $.data.phone.social.profiles.messaging.line.name == "#notnull"
    * match $.data.phone.social.profiles.messaging.line.lastSeen == null
    * match $.data.phone.social.profiles.messaging.line.about == "#notnull"

    * match $.data.phone.social.profiles.messaging.whatsapp.registered == true
    * match $.data.phone.social.profiles.messaging.whatsapp.photo == "#notnull"
    * match $.data.phone.social.profiles.messaging.whatsapp.registered == "#notnull"

    * match  $.data.phone.social contains  payload.response.data.phone.social
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    Examples:
      | Scenario                                                                           | statusCode |
      | PHONE_SOCIAL_summary_lastActivity_same_as_lastSeen_of_telegram_AND_line_registered | 200        |

  @PHONE_SOCIAL @seon
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match $.data.phone.social.summary.registeredEmailProviderProfiles == 0
    * match $.data.phone.social.summary.registeredEcommerceProfiles == 0
    * match $.data.phone.social.summary.registeredSocialMediaProfiles == 0
    * match $.data.phone.social.summary.registeredProfessionalProfiles == 0
    * match $.data.phone.social.summary.registeredMessagingProfiles == 0
    * match $.data.phone.social.summary.lastActivity == null
    * match $.data.phone.social.summary.numberOfNamesReturned == 0
    * match $.data.phone.social.summary.numberOfPhotosReturned == 0

    * match $.data.phone.social.profiles !contains {"registered": true}
    * match  $.data.phone.social contains  payload.response.data.phone.social
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Examples:
      | Scenario                          | statusCode |
      | PHONE_SOCIAL_FIXED_line_summary_0 | 200        |


  @PHONE_SOCIAL @seon
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Indian region with validation of all fields - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match  $.data.phone.social contains  payload.response.data.phone.social
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    Examples:
      | Scenario                                                                                                                            | statusCode |
      | PHONE_SOCIAL_country_Brazil_response                                                                                                | 200        |
      | PHONE_SOCIAL_country_Malaysia_response                                                                                              | 200        |
      | PHONE_SOCIAL_country_Indonesia_response                                                                                             | 200        |
      | PHONE_SOCIAL_country_Philippines_response                                                                                           | 200        |
      | PHONE_SOCIAL_country_Vietnam_VN_response                                                                                            | 200        |
      | PHONE_SOCIAL_country_Vietnam_VN_response_lastActivity_latest_lastSeen                                                               | 200        |
      | PHONE_SOCIAL_country_Vietnam_VN_response_zalo_respondent                                                                            | 200        |
      | PHONE_SOCIAL_country_Vietnam_VN_response_viber_respondent                                                                           | 200        |
      | PHONE_SOCIAL_country_UnitedKingdom_GB_response                                                                                      | 200        |
      | PHONE_SOCIAL_country_Italy_IT_response_google_flipkart_bukalapak_facebook_twitter_instagram_microsoft_telegram_whatsapp_viber_false | 200        |


