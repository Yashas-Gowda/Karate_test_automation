Feature: Testing of DPI  - PHONE_SOCIAL scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'


  @PHONE_SOCIAL @FIDO @smokeTest
  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of all fields- <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL_FIDO/<Scenario>.json")
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

  @PHONE_SOCIAL @FIDO
  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of all fields for all regions specific country- <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL_FIDO/<Scenario>.json")
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
      | Scenario                                       | statusCode |
            # dataponts are null | PHONE_SOCIAL_country_Brazil_response           | 200        |
      | PHONE_SOCIAL_country_Indonesia_response        | 200        |
      | PHONE_SOCIAL_country_Italy_IT_response         | 200        |
      | PHONE_SOCIAL_country_Malaysia_response         | 200        |
      | PHONE_SOCIAL_country_Philippines_response      | 200        |
      | PHONE_SOCIAL_country_UnitedKingdom_GB_response | 200        |
      | PHONE_SOCIAL_country_UnitedStates_US_response  | 200        |
      | PHONE_SOCIAL_country_Vietnam_VN_response       | 200        |

  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of emailProvider - [google,yahoo] - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL_FIDO/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    * def payload_part = payload.response.data.phone.social.profiles.emailProvider
    * print payload_part
    * def response_part = $.data.phone.social.profiles.emailProvider
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match payload.response.data.phone.social.profiles.emailProvider == $.data.phone.social.profiles.emailProvider
    * match payload.response.data.phone.social.summary.registeredEmailProviderProfiles == $.data.phone.social.summary.registeredEmailProviderProfiles
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

  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of ecommerce - [flipkart,bukalapak,jdid,amazon] - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL_FIDO/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    * def payload_part = payload.response.data.phone.social.profiles.ecommerce
    * print payload_part
    * def response_part = $.data.phone.social.profiles.ecommerce
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match payload.response.data.phone.social.profiles.ecommerce == $.data.phone.social.profiles.ecommerce
    * match payload.response.data.phone.social.summary.registeredEcommerceProfiles == $.data.phone.social.summary.registeredEcommerceProfiles
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

  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of socialMedia - [facebook,twitter,instagram] - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL_FIDO/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    * def payload_part = payload.response.data.phone.social.profiles.socialMedia
    * print payload_part
    * def response_part = $.data.phone.social.profiles.socialMedia
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match payload.response.data.phone.social.profiles.socialMedia == $.data.phone.social.profiles.socialMedia
    * match payload.response.data.phone.social.summary.registeredSocialMediaProfiles == $.data.phone.social.summary.registeredSocialMediaProfiles
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
      | Scenario                                                                        | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_facebook_twitter_instagram_registered_true | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_twitter_registered_false                   | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_instagram_registered_false                 | 200        |
      | PHONE_SOCIAL_FIDO_profiles_ecommerce_facebook_registered_false                  | 200        |

  Scenario Outline:  DPI PHONE_SOCIAL_FIDO Data Partner for Positive scenarios for validation of messaging - [telegram,whatsapp,viber,kakao,skype,ok,zalo,line,snapchat],But fido gives only [telegram,whatsapp]  - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL_FIDO/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    * def payload_part = payload.response.data.phone.social.profiles.messaging
    * print payload_part
    * def response_part = $.data.phone.social.profiles.messaging
    * print response_part
    Then status <statusCode>
    And match $.data.phone.social == '#notnull'
    And match $.data.phone.social.summary == '#notnull'
    And match $.data.phone.social.profiles == '#notnull'

    * match payload.response.data.phone.social.profiles.messaging == $.data.phone.social.profiles.messaging
    * match payload.response.data.phone.social.summary.numberOfNamesReturned == $.data.phone.social.summary.numberOfNamesReturned
    * match payload.response.data.phone.social.summary.numberOfPhotosReturned == $.data.phone.social.summary.numberOfPhotosReturned
    * match  $.data.phone.social.summary.lastActivity == '#null'

    * match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]

    # Test data for all fields true - 916383761273,'916354392816,918919307951,917276417276,918418077188,918886565536
    # telegram false -


    # telegram-false - 919705300142,919610062000,919971513080,918985999905,91974239606,9919889868205,919406099650
    #whatsapp false -917980925895,918669070751,918953417418,919964484685,919079632630,919000883907,918790368717
    Examples:
      | Scenario                                                                                                        | statusCode |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true                                          | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true_with_photo_privacyStatus_PUBLIC          | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_whatsapp_registered_true_without_photo_with_privacyStatus_PRIVATE | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_false_whatsapp_registered_true_with_photo_privacyStatus_PUBLIC    | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_telegram_false_whatsapp_registered_true_with_photo_privacyStatus_PRIVATE   | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_whatsapp_false_telegram_registered_true_with_photo_privacyStatus_PUBLIC    | 200        |
      | PHONE_SOCIAL_FIDO_profiles_messaging_whatsapp_false_telegram_registered_true_with_photo_privacyStatus_PRIVATE   | 200        |


  @Schema_validation_1
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Schema_validation_1 - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL_FIDO/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>

    And match $.data.phone.social == '#notnull'
    And match $.data.phone.basic == '#null'
    And match $.data.phone.social.summary contains deep {"registeredProfiles":"#present","registeredEmailProviderProfiles":"#present","registeredEcommerceProfiles":"#present","registeredSocialMediaProfiles":"#present","registeredProfessionalProfiles":"#present","registeredMessagingProfiles":"#present","lastActivity":"#present","numberOfNamesReturned":"#present","numberOfPhotosReturned":"#present"}
    And match $.data.phone.social.profiles.emailProvider contains deep {"google":{"registered":"#present","accountId":"#present","name":"#present"},"yahoo":{"registered":"#present"}}
    And match $.data.phone.social.profiles.ecommerce contains deep {"flipkart":{"registered":"#present"},"bukalapak":{"registered":"#present"},"jdid":{"registered":"#present"},"amazon":{"registered":"#present"}}x`
    And match $.data.phone.social.profiles.socialMedia contains deep {"facebook":{"registered":"#present"},"twitter":{"registered":"#present"},"instagram":{"registered":"#present"}}
    And match $.data.phone.social.profiles.professional contains deep {"microsoft":{"registered":"#present"},"linkedin":{"registered":"#present"}}
    And match $.data.phone.social.profiles.messaging contains deep {"telegram":{"registered":"#present","photo":"#present","privacyStatus":"#present","lastSeen":"#present"},"whatsapp":{"registered":"#present","photo":"#present","privacyStatus":"#present","lastSeen":"#present","about":"#present"},"viber":{"registered":"#present","photo":"#present","lastSeen":"#present","name":"#present"},"kakao":{"registered":"#present"},"skype":{"registered":"#present","language":"#present","id":"#present","handle":"#present","bio":"#present","name":"#present","age":"#present","gender":"#present","photo":"#present","city":"#present","state":"#present","country":"#present"},"ok":{"registered":"#present","age":"#present"},"zalo":{"registered":"#present","uid":"#present","name":"#present","dateOfBirth":"#present"},"line":{"registered":"#present","name":"#present","photo":"#present"},"snapchat":{"registered":"#present"}}

    And match $.data contains {"email":"#null","address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    And match $.meta contains deep {"inputPhoneNumber":"#present","cleansedPhoneNumber":"#present","referenceId":"#present","requestedPackages":["PHONE_SOCIAL"]}
    And match $.errors == []

    Examples:
      | Scenario                               | statusCode |
      | PHONE_SOCIAL_country_Malaysia_response | 200        |


  @Schema_validation_2
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Schema_validation_2 - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_SOCIAL_FIDO/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains deep
    """
    {
  "data": {
    "phone": {
      "basic": null,
      "social": {
        "summary": {
          "registeredProfiles": "#present",
          "registeredEmailProviderProfiles": "#present",
          "registeredEcommerceProfiles": "#present",
          "registeredSocialMediaProfiles": "#present",
          "registeredProfessionalProfiles": "#present",
          "registeredMessagingProfiles":"#present",
          "lastActivity": null,
          "numberOfNamesReturned": "#present",
          "numberOfPhotosReturned": "#present"
        },
        "profiles": {
          "emailProvider": {
            "google": {
              "registered": "#present",
              "accountId": "#present",
              "name": "#present"
            },
            "yahoo": {
              "registered": "#present"
            }
          },
          "ecommerce": {
            "flipkart": {
              "registered": "#present"
            },
            "bukalapak": {
              "registered": "#present"
            },
            "jdid": {
              "registered": "#present"
            },
            "amazon": {
              "registered": "#present"
            }
          },
          "socialMedia": {
            "facebook": {
              "registered":"#present"
            },
            "twitter": {
              "registered":"#present"
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
              "about": "#present"
            },
            "viber": {
              "registered": "#present",
              "photo": "#present",
              "lastSeen": "#present",
              "name": "#present"
            },
            "kakao": {
              "registered": "#present"
            },
            "skype": {
              "registered": "#present",
              "language":"#present",
              "id": "#present",
              "handle": "#present",
              "bio": "#present",
              "name":"#present",
              "age": "#present",
              "gender": "#present",
              "photo": "#present",
              "city": "#present",
              "state": "#present",
              "country": "#present"
            },
            "ok": {
              "registered": "#present",
              "age": "#present"
            },
            "zalo": {
              "registered": "#present",
              "uid": "#present",
              "name": "#present",
              "dateOfBirth":"#present"
            },
            "line": {
              "registered": "#present",
              "name": "#present",
              "photo": "#present"
            },
            "snapchat": {
              "registered": "#present"
            }
          }
        }
      },
			"identity": '#present'
		},
		"email": '#null',
		"address": '#null',
		"name": '#null',
		"ip": '#null',
		"identity": '#null',
		"upi": '#null',
		"device": '#null',
		"employment": '#null',
		"income": '#null',
		"blacklist": '#null',
		"bre": '#null'
	},
	"meta": {
		"inputPhoneNumber": '#present',
		"cleansedPhoneNumber": '#present',
		"referenceId": '#present',
		"requestedPackages": [
			"PHONE_SOCIAL"
		]
	},
	"errors": '#array'
}
    """
#    * match  $ contains deep schema_validation
    Examples:
      | Scenario                               | statusCode |
      | PHONE_SOCIAL_country_Malaysia_response | 200        |
#      | PHONE_SOCIAL_country_Indonesia_response   | 200        |
#      | PHONE_SOCIAL_country_Philippines_response | 200        |
#      | PHONE_SOCIAL_country_Vietnam_VN_response  | 200        |



