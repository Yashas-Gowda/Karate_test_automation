Feature:Testing of DPI - UPI_ADVANCED feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario:
    * print BearerToken

  Scenario Outline: Validation of UPI_ADVANCED Negative scenario for error code when an invalid / null / empty phoneNumber input -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/source/UPI_ADVANCED/<Scenario>.json")
    And request payload.request
    And headers headers
    And header Authorization = BearerToken
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then status <statusCode>
    Then match $ contains any payload.response
    Examples:
      | Scenario                                                        | statusCode |
      | UPI_ADVANCED_POSITIVE_phone&Email_input_@ybl_@paytm_@okhdfcbank | 200        |

