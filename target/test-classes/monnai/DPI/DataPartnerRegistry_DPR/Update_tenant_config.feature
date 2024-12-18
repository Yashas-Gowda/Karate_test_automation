@Update_Tenant_config
Feature: FILTER_PARTNER_CURL

  Background:
    * configure charset = null
   * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authTokenFeature:


  Scenario: UPDATE TENANT CONFIG for tenant id automation
    * def Url = requestUrl + '/api/registry/tenants'
    Given url Url
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
    """
    {
	"tenant": "01GFJCPPHBAWE6SBY28VGJV84Y",
	"exclude": {
		"PHONE_SOCIAL": {
			"01H6BBPQ3TVTVSTDH4TKRX3VGY": {
				"name": "FIDO Phone",
				"order": 0
			}
		}
	},
	"include": {
		"PHONE_SOCIAL": {
			"01GVK2BBQCZVCB8A88Q1MW2MTR": {
				"name": "Seon Phone",
				"order": 0
			}
		}
	}
}
    """
    And request requestPayload
    When method POST
    Then status 200
    * print 'Filter response---->',response

