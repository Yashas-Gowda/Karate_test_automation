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

  @Schema_validation_1
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Schema_validation_1 - <Scenario>
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
      | Scenario                             | statusCode |
      | PHONE_SOCIAL_country_Brazil_response | 200        |


  @Schema_validation_2
  Scenario Outline:  DPI PHONE_SOCIAL positive scenario for Schema_validation_2 - <Scenario>
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
    Then match $ contains deep
    """
    {
	"data": {
		"phone": {
			"basic": '#null',
			"social": {
				"summary": {
	 				"registeredProfiles": '#present',
					"registeredEmailProviderProfiles": '#present',
					"registeredEcommerceProfiles": '#present',
					"registeredSocialMediaProfiles": '#present',
					"registeredProfessionalProfiles": '#present',
					"registeredMessagingProfiles": '#present',
					"lastActivity": '#present',
					"numberOfNamesReturned": '#present',
					"numberOfPhotosReturned": '#present'
				},
				"profiles": {
					"emailProvider": {
						"google": {
							"registered": '#present',
							"accountId": '#present',
							"name": '#present'
						},
						"yahoo": {
							"registered":'#present',
						}
					},
					"ecommerce": {
						"flipkart": {
							"registered": '#present'
						},
						"bukalapak": {
							"registered": '#present'
						},
						"jdid": {
							"registered": '#present'
						},
						"amazon": {
							"registered": '#present'
						}
					},
					"socialMedia": {
						"facebook": {
							"registered": '#present'
						},
						"twitter": {
							"registered": '#present'
						},
						"instagram": {
							"registered": '#present'
						}
					},
					"professional": {
						"microsoft": {
							"registered": '#present'
						},
						"linkedin": {
							"registered": '#present'
						}
					},
					"messaging": {
						"telegram": {
							"registered": '#present',
							"photo": '#present',
							"privacyStatus": '#present',
							"lastSeen": '#present'
						},
						"whatsapp": {
							"registered": '#present',
							"photo": '#present',
							"privacyStatus": '#present',
							"lastSeen": '#present',
							"about": '#present'
						},
						"viber": {
							"registered": '#present',
							"photo": '#present',
							"lastSeen": '#present',
							"name": '#present'
						},
						"kakao": {
							"registered": '#present'
						},
						"skype": {
							"registered": '#present',
							"language": '#present',
							"id": '#present',
							"handle": '#present',
							"bio": '#present',
							"name": '#present',
							"age": '#present',
							"gender": '#present',
							"photo": '#present',
							"city": '#present',
							"state": '#present',
							"country": '#present'
						},
						"ok": {
							"registered": '#present',
							"age": '#present'
						},
						"zalo": {
							"registered": '#present',
							"uid": '#present',
							"name": '#present',
							"dateOfBirth": '#present'
						},
						"line": {
							"registered": '#present',
							"name": '#present',
							"photo": '#present'
						},
						"snapchat": {
							"registered": '#present'
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



# include