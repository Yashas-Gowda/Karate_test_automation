Feature: Testing of DPI  - EMAIL_SOCIAL feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  @smokeTest
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios - Email_Social_Schema validation,Booking&Spotify&Adobe&Quora_Registered,LinkedIn&Airbnb_Registered,Lazada&Microsoft&Evernote_Registered, wordpress&Gravatar&Twitter&Flipkart_Registered   - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.social.summary.ageOnSocial = "#number"
    * set payload.response.data.email.social.profiles.professional.linkedin.photo = "##string"
    * set payload.response.data.email.social.profiles.emailProvider.google.photo = "##string"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>

    Then match $ contains payload.response
    Examples:
      | Scenario                                                          | statusCode |
      | Email_Social                                                      | 200        |
      | Email_Social_EmailProvider_Booking&Spotify&Adobe&Quora_Registered | 200        |
      | Email_Social_EmailProvider_LinkedIn&Airbnb_Registered             | 200        |
#      | Email_Social_EmailProvider_LinkedIn&Email_Social_EmailProvider_Yahoo&Google_Registered | 200        |
      | Email_Social_Lazada&Microsoft&Evernote_Registered                 | 200        |
      | Email_Social_wordpress&Gravatar&Twitter&Flipkart_Registered       | 200        |

     ## Check - Can we test scenario with ageonSocial NOT NULL
  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios where ageOnSocial is null - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.social.summary.ageOnSocial = "##number"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>

    Then match $ contains payload.response

    Examples:
      | Scenario                                                        | statusCode |
      | Email_Social_consumerElectronics_Registered_ageOnSocial_is_null | 200        |
    # | Email_Social_Messaging_Skype&Discord_Registered                 | 200        |
      | Email_Social_SocialMedia_Instagram&Pinterest&Twitter_Registered | 200        |

  Scenario Outline:  DPI EMAIL_SOCIAL Negative scenario with invalid input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $ contains payload.response
#    And match $.errors[1].message == "Invalid email address"
#    And match $.response.errors[1].message == "Invalid email address"

    Examples:
      | Scenario                                                        | statusCode |
      | Email_Social_Negative_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
      | Email_Social_Negative_Onlyprefix_without@_NoDomainName(abc)     | 400        |
      | Email_Social_Negative_withPrefix_with@_NoDomainName(abc@)       | 400        |


  Scenario Outline:  DPI EMAIL_SOCIAL Negative scenario with null/empty/invalid input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/EMAIL_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
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
    And def payload = read("data/" + env + "/EMAIL_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
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
    And def payload = read("data/" + env + "/EMAIL_SOCIAL/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>

    And match $.data.email.social.profiles.emailProvider.google.registered == true
    And match $.data.email.social.profiles.emailProvider.google.photo == "#regex https://*.*"
    And match $.data.email.social.profiles.professional.linkedin.registered == "#null"
    And match $.data.email.social.profiles.professional.linkedin.url == "#null"


    Examples:
      | Scenario                                                    | statusCode |
      | Email_Social_Google_With_Photo_IsRegistered_LinkedIn_IsNull | 200        |