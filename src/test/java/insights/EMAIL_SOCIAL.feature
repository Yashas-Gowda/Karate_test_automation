Feature: Testing of DPI  - EMAIL_SOCIAL feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

  Scenario Outline:  DPI EMAIL_SOCIAL Positive scenarios - <Scenario>
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
      | Scenario                                                                    | statusCode |
      | Email_Social                                                                | 200        |
      | Email_Social_EmailProvider_Booking&Spotify&Adobe&Atlassian&Quora_Registered | 200        |
      | Email_Social_EmailProvider_LinkedIn&Airbnb_Registered                       | 200        |
#      | Email_Social_EmailProvider_LinkedIn&Email_Social_EmailProvider_Yahoo&Google_Registered | 200        |
      | Email_Social_Lazada&Tumblr&Skype&Microsoft&Evernote&Amazon_Registered       | 200        |
      | Email_Social_wordpress&Gravatar&TwitterPinterest&Flipkart&Ebay_Registered   | 200        |

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
    Examples:
      | Scenario                                                        | statusCode |
      | Email_Social_consumerElectronics_Registered_ageOnSocial_is_null | 200        |
      | Email_Social_Messaging_Skype&Discord_Registered                 | 200        |
      | Email_Social_SocialMedia_Instagram&Pinterest&Twitter_Registered | 200        |

  Scenario Outline:  DPI EMAIL_BASIC Negative scenario with invalid input - <Scenario>
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

  Scenario Outline:  DPI EMAIL_BASIC Negative scenario with null/empty input - <Scenario>
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
      | Scenario                             | statusCode |
      | Email_Social_Negative_Emptyinput('') | 400        |
      | Email_Social_Negative_NullInput(' ') | 400        |

