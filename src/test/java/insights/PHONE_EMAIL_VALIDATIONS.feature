 Feature: Testing of DPI  - Phone & Email Validations scenarios

   Background:
     * configure charset = null
     * path '/api/insights/'

#   @smokeTest
#   Scenario Outline:  DPI Identity Enrichment Scenarios of phone validations - <Scenario>
#   Given url requestUrl
#   And def payload = read("data/" + env + "/PHONE_EMAIL_VALIDATIONS/<Scenario>.json")
#   And headers headers
#   And request payload.request
#   * set payload.response.meta.referenceId = "#ignore"
#   When method POST
#   * print payload.request
#   * print payload.response
#   * print karate.pretty(response)
#   Then status <statusCode>
#   And match $ contains payload.response
#   Examples:
#     | Scenario         | statusCode |
#     | TC001            | 400        |
#     | TC002            | 400        |
#     | TC003            | 400        |
#     | TC004            | 400        |
#     | TC005            | 400        |
#     | TC006            | 400        |
#     | TC007            | 400        |
#     | TC008            | 400        |
#     | TC009            | 400        |
#     | TC010            | 400        |
#     | TC011            | 400        |
#     | TC012            | 400        |