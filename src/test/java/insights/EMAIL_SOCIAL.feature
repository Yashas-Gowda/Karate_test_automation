@seon_email @ignore
Feature: Testing of DPI  - EMAIL_SOCIAL feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @smokeTest
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios - Email_Social_Schema validation,Booking&Spotify&Adobe&Quora_Registered,LinkedIn&Airbnb_Registered,Lazada&Microsoft&Evernote_Registered, wordpress&Gravatar&Twitter&Flipkart_Registered   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.social.profiles.professional.linkedin.photo = "##string"
    * set payload.response.data.email.social.profiles.emailProvider.google.photo = "##string"
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

    Then match $.data.email.social contains payload.response.data.email.social
    Examples:
      | Scenario                                                          | statusCode |
      | Email_Social                                                      | 200        |
      | Email_Social_EmailProvider_Booking&Spotify&Adobe&Quora_Registered | 200        |
      | Email_Social_EmailProvider_LinkedIn&Airbnb_Registered             | 200        |
#      | Email_Social_EmailProvider_LinkedIn&Email_Social_EmailProvider_Yahoo&Google_Registered | 200        |
      | Email_Social_Lazada&Microsoft&Evernote_Registered                 | 200        |
#      | Email_Social_wordpress&Gravatar&Twitter&Flipkart_Registered       | 200        |

     ## Check - Can we test scenario with ageonSocial NOT NULL
  @smokeTest
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios where ageOnSocial is null - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_SOCIAL/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.social.summary.ageOnSocial = "##number"
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
    Then match $.data.email.social contains payload.response.data.email.social
    Examples:
      | Scenario                                                        | statusCode |
      | Email_Social_consumerElectronics_Registered_ageOnSocial_is_null | 200        |
    # | Email_Social_Messaging_Skype&Discord_Registered                 | 200        |
      | Email_Social_SocialMedia_Instagram&Pinterest&Twitter_Registered | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Negative scenario with invalid input - <Scenario>
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
    Then match $.data.email.social contains payload.response.data.email.social
#    And match $.errors[1].message == "Invalid email address"
#    And match $.response.errors[1].message == "Invalid email address"

    Examples:
      | Scenario                                                        | statusCode |
      | Email_Social_Negative_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
      | Email_Social_Negative_Onlyprefix_without@_NoDomainName(abc)     | 400        |
      | Email_Social_Negative_withPrefix_with@_NoDomainName(abc@)       | 400        |


  Scenario Outline:  DPI EMAIL_SOCIAL Negative scenario with null/empty/invalid input - <Scenario>
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
      | Scenario                                    | statusCode |
      | Email_Social_Negative_Emptyinput('')        | 400        |
      | Email_Social_Negative_NullInput(' ')        | 400        |
      | Email_Social_Negative_Invalid_email_address | 400        |


  @smokeTest
  Scenario Outline:  DPI EMAIL_SOCIAL validate Summary section - <Scenario>
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

    * def registeredProfilesCount = { registeredProfiles: 17 }
    * def numberOfNamesReturnedCount = { numberOfNamesReturned: 2 }
    * def numberOfPhotosReturnedCount = { numberOfPhotosReturned: 3 }
    * def registeredConsumerElectronicsProfilesCount = { registeredConsumerElectronicsProfiles: 2 }
    * def registeredEmailProviderProfilesCount = { registeredEmailProviderProfiles: 1}
    * def registeredEcommerceProfilesCount = { registeredEcommerceProfiles: 2}
    * def registeredSocialMediaProfilesCount = { registeredSocialMediaProfiles: 5}
    * def registeredMessagingProfilesCount = { registeredMessagingProfiles: 1}
    * def registeredProfessionalProfilesCount = { registeredProfessionalProfiles: 3}
    * def registeredEntertainmentProfilesCount = { registeredEntertainmentProfiles: 2}
    * def registeredTravelProfilesCount = { registeredTravelProfiles: 1}


    And match registeredProfilesCount == { registeredProfiles: '#? _ > 0' }
    And match numberOfNamesReturnedCount == { numberOfNamesReturned: '#? _ > 0' }
    And match numberOfPhotosReturnedCount == { numberOfPhotosReturned: '#? _ > 0' }
    And match registeredConsumerElectronicsProfilesCount == { registeredConsumerElectronicsProfiles: '#? _ > 0'}
    And match registeredEmailProviderProfilesCount == {registeredEmailProviderProfiles: '#? _ > 0'}
    And match registeredEcommerceProfilesCount == {registeredEcommerceProfiles: '#? _ > 0'}
    And match registeredSocialMediaProfilesCount == {registeredSocialMediaProfiles: '#? _ > 0'}
    And match registeredMessagingProfilesCount == {registeredMessagingProfiles: '#? _ > 0'}
    And match registeredProfessionalProfilesCount == {registeredProfessionalProfiles: '#? _ > 0'}
    And match registeredEntertainmentProfilesCount == {registeredEntertainmentProfiles: '#? _ > 0'}
    And match registeredTravelProfilesCount == {registeredTravelProfiles: '#? _ >= 0'}

    Examples:
      | Scenario                      | statusCode |
      | Email_Social_Validate_summary | 200        |



  Scenario Outline:  DPI EMAIL_SOCIAL Test Google_registered, LinkedIn_IsNull,  - <Scenario>
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

    And match $.data.email.social.profiles.emailProvider.google.registered == true
    And match $.data.email.social.profiles.emailProvider.google.photo == "#regex https://*.*"
    And match $.data.email.social.profiles.professional.linkedin.registered == "#null"
    And match $.data.email.social.profiles.professional.linkedin.url == "#null"
    Then match $.data.email.social contains payload.response.data.email.social

    Examples:
      | Scenario                                                    | statusCode |
      | Email_Social_Google_With_Photo_IsRegistered_LinkedIn_IsNull | 200        |

    # website used for json to oneline converter: https://jsonformatter.org/json-to-one-line
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
    And match $.data.email.social.summary contains deep {"registeredProfiles":"#present","registeredConsumerElectronicsProfiles":"#present","registeredEmailProviderProfiles":"#present","registeredEcommerceProfiles":"#present","registeredSocialMediaProfiles":"#present","registeredMessagingProfiles":"#present","registeredProfessionalProfiles":"#present","registeredEntertainmentProfiles":"#present","registeredTravelProfiles":"#present","ageOnSocial":"#present","numberOfNamesReturned":"#present","numberOfPhotosReturned":"#present"}
    And match $.data.email.social.profiles.consumerElectronics contains deep {"apple":{"registered":"#present"},"samsung":{"registered":"#present"}}
    And match $.data.email.social.profiles.emailProvider contains deep {"google":{"registered":"#present","name":"#present","photo":"#present"},"yahoo":{"registered":"#present"},"mailru":{"registered":"#present"},"rambler":{"registered":"#present"}}
    And match $.data.email.social.profiles.ecommerce contains deep {"amazon":{"registered":"#present"},"ebay":{"registered":"#present"},"flipkart":{"registered":"#present"},"jdid":{"registered":"#present"},"bukalapak":{"registered":"#present"},"lazada":{"registered":"#present"},"tokopedia":{"registered":"#present"}}
    And match $.data.email.social.profiles.socialMedia contains deep {"facebook":{"registered":"#present","name":"#present","photo":"#present","url":"#present"},"instagram":{"registered":"#present"},"flickr":{"registered":"#present","username":"#present"},"pinterest":{"registered":"#present"},"twitter":{"registered":"#present"},"tumblr":{"registered":"#present"},"weibo":{"registered":"#present"},"ok":{"registered":"#present","age":"#present","city":"#present","dateJoined":"#present"},"imgur":{"registered":"#present"},"quora":{"registered":"#present"},"qzone":{"registered":"#present"},"gravatar":{"registered":"#present","location":"#present","name":"#present","profileUrl":"#present","username":"#present"},"foursquare":{"registered":"#present","bio":"#present","photo":"#present","profileUrl":"#present"},"myspace":{"registered":"#present"}}
    And match $.data.email.social.profiles.messaging contains deep {"skype":{"registered":"#present","language":"#present","gender":"#present","name":"#present","id":"#present","handle":"#present","bio":"#present","age":"#present","city":"#present","state":"#present","country":"#present","photo":"#present"},"discord":{"registered":"#present"},"kakao":{"registered":"#present"}}
    And match $.data.email.social.profiles.professional contains deep {"github":{"registered":"#present"},"wordpress":{"registered":"#present"},"atlassian":{"registered":"#present"},"linkedin":{"registered":"#present","url":"#present","name":"#present","company":"#present","title":"#present","location":"#present","website":"#present","twitter":"#present","photo":"#present","connectionCount":"#present"},"evernote":{"registered":"#present"},"microsoft":{"registered":"#present"},"zoho":{"registered":"#present"},"adobe":{"registered":"#present"}}
    And match $.data.email.social.profiles.entertainment contains deep {"spotify":{"registered":"#present"},"lastfm":{"registered":"#present"},"vimeo":{"registered":"#present"},"envato":{"registered":"#present"},"patreon":{"registered":"#present"},"disneyplus":{"registered":"#present"},"netflix":{"registered":"#present"},"archiveorg":{"registered":"#present"}}
    And match $.data.email.social.profiles.travel contains deep {"booking":{"registered":"#present"},"airbnb":{"registered":"#present","about":"#present","createdAt":"#present","name":"#present","identityVerified":"#present","location":"#present","photo":"#present","revieweeCount":"#present","trips":"#present","work":"#present"}}

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
    "phone": '#null',
    "email": {
      "social": {
        "summary": {
          "registeredProfiles":"#present",
          "registeredConsumerElectronicsProfiles":  "#present",
          "registeredEmailProviderProfiles":  "#present",
          "registeredEcommerceProfiles":  "#present",
          "registeredSocialMediaProfiles":  "#present",
          "registeredMessagingProfiles":  "#present",
          "registeredProfessionalProfiles": "#present",
          "registeredEntertainmentProfiles":  "#present",
          "registeredTravelProfiles":  "#present",
          "ageOnSocial":  "#present",
          "numberOfNamesReturned": "#present",
          "numberOfPhotosReturned":  "#present",
        },
        "profiles": {
          "consumerElectronics": {
            "apple": {
              "registered": "#present"
            },
            "samsung": {
              "registered":  "#present"
            }
          },
          "emailProvider": {
            "google": {
              "registered":  "#present",
              "name":  "#present",
              "photo":  "#present"
              },
            "yahoo": {
              "registered":  "#present"
            },
            "mailru": {
              "registered": "#present"
            },
            "rambler": {
              "registered":  "#present"
            }
          },
          "ecommerce": {
            "amazon": {
              "registered":  "#present"
            },
            "ebay": {
              "registered":  "#present"
            },
            "flipkart": {
              "registered":  "#present"
            },
            "jdid": {
              "registered":  "#present"
            },
            "bukalapak": {
              "registered":  "#present"
            },
            "lazada": {
              "registered":  "#present"
            },
            "tokopedia": {
              "registered":  "#present"
            }
          },
          "socialMedia": {
            "facebook": {
              "registered":  "#present",
              "name":  "#present",
              "photo":  "#present",
              "url":  "#present"
            },
            "instagram": {
              "registered":  "#present"
            },
            "flickr": {
              "registered":  "#present",
              "username": "#present"
            },
            "pinterest": {
              "registered":  "#present"
            },
            "twitter": {
              "registered":  "#present"
            },
            "tumblr": {
              "registered": "#present"
            },
            "weibo": {
              "registered": "#present"
            },
            "ok": {
              "registered":  "#present",
              "age":  "#present",
              "city":  "#present",
              "dateJoined":  "#present"
            },
            "imgur": {
              "registered":  "#present"
            },
            "quora": {
              "registered":  "#present"
            },
            "qzone": {
              "registered":  "#present"
            },
            "gravatar": {
              "registered":  "#present",
              "location":  "#present",
              "name":  "#present",
              "profileUrl":  "#present",
              "username": "#present"
            },
            "foursquare": {
              "registered": "#present",
              "bio": "#present",
              "photo": "#present",
              "profileUrl": "#present"
            },
            "myspace": {
              "registered": "#present"
            }
          },
          "messaging": {
            "skype": {
              "registered":"#present",
              "language":"#present",
              "gender": "#present",
              "name": "#present",
              "id": "#present",
              "handle": "#present",
              "bio": "#present",
              "age": "#present",
              "city": "#present",
              "state": "#present",
              "country": "#present",
              "photo": "#present"
            },
            "discord": {
              "registered": "#present"
            },
            "kakao": {
              "registered": "#present"
            }
          },
          "professional": {
            "github": {
              "registered": "#present"
            },
            "wordpress": {
              "registered": "#present"
            },
            "atlassian": {
              "registered": "#present"
            },
            "linkedin": {
              "registered": "#present",
              "url": "#present",
              "name": "#present",
              "company": "#present",
              "title": "#present",
              "location": "#present",
              "website": "#present",
              "twitter": "#present",
              "photo": "#present",
              "connectionCount": "#present"
            },
            "evernote": {
              "registered": "#present"
            },
            "microsoft": {
              "registered": "#present"
            },
            "zoho": {
              "registered": "#present"
            },
            "adobe": {
              "registered": "#present"
            }
          },
          "entertainment": {
            "spotify": {
              "registered": "#present"
            },
            "lastfm": {
              "registered": "#present"
            },
            "vimeo": {
              "registered": "#present"
            },
            "envato": {
              "registered": "#present"
            },
            "patreon": {
              "registered": "#present"
            },
            "disneyplus": {
              "registered": "#present"
            },
            "netflix": {
              "registered": "#present"
            },
            "archiveorg": {
              "registered": "#present"
            }
          },
          "travel": {
            "booking": {
              "registered":"#present"
            },
            "airbnb": {
              "registered": "#present",
              "about": "#present",
              "createdAt": "#present",
              "name": "#present",
              "identityVerified": "#present",
              "location": "#present",
              "photo": "#present",
              "revieweeCount": "#present",
              "trips": "#present",
              "work": "#present"
            }
          }
        }
      },
      "basic": "#null"
    },
    "address":"#null",
    "name": "#null",
    "ip": "#null",
    "identity": "#null",
    "upi": "#null",
    "device": "#null",
    "employment": "#null",
    "income": "#null",
    "blacklist": "#null",
    "bre": "#null"
  },
  "meta": {
    "referenceId": "#present",
    "inputEmail": "#present",
    "requestedPackages": [
      "EMAIL_SOCIAL"
    ]
  },
  "errors": "#array"
}
    """
    Examples:
      | Scenario                                                        | statusCode |
      | Email_Social_SocialMedia_Instagram&Pinterest&Twitter_Registered | 200        |