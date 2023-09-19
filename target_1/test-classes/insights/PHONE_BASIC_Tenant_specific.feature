Feature: Testing of DPI  - Phone_basic scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'

#    phoneDisposable by default it is always false, but after configuration for particular tenant it will picked from data partner SEON
  @PHONE_BASIC @smoke @CTOS Tenant

  Scenario Outline:  DPI PHONE_BASIC full package positive scenario for across regions with validation of full response - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + env + "/PHONE_BASIC_Region_Specific/<Scenario>.json")
    And headers headers
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    * match $.data.phone.basic.phoneDisposable == <phoneDisposable>


    Examples:
      | Scenario                                     | statusCode | phoneDisposable |
      | PHONE_BASIC_Malaysia_MY_phoneDisposable_true | 200        | true            |
      | PHONE_BASIC_India_IN_phoneDisposable_fasle   | 200        | false           |

