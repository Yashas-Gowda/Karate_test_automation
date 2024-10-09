@Update_tenant_config @ignore
Feature: Update_tenant_config

  Background:
    * configure charset = null
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken
  #    * def Tenant_config_stored_in_auth_file = authFeature.tenant_config



  @get_tenant_config_before_update
  Scenario:  GET Tenant config automation - Before Tenant Config update.
    * def AUrl = requestUrl + '/api/registry/tenants/' + _custom_tenant_id
    Given url AUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def beforeRunTenantConfig = response
    * print 'Filter response---->',beforeRunTenantConfig
    * print 'Filter response---->',response

  @Update_tenant_config_partners
  Scenario: UPDATE TENANT CONFIG for Tenant ID
    * def Url = requestUrl + '/api/registry/tenants'
    Given url Url
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload = custom_tenant_config
    * print 'Tenant config to update requestPayload---->',requestPayload
    And request requestPayload
    When method POST
    Then status 201
    * print 'Filter response---->',response

  #get_tenant_config_after_update
  @get_tenant_config_after_update
  Scenario: GET Tenant config automation - After Tenant Config update.
    * def AUrl = requestUrl + '/api/registry/tenants/' + _custom_tenant_id
    Given url AUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * print 'Filter response---->',response

  @Update_to_before_run_tenant_config_partners
  Scenario: UPDATE TENANT CONFIG for Tenant ID
    # 1st API call to update tenant config
    * def Url = requestUrl + '/api/registry/tenants'
    Given url Url
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload = Custom_env_authFeature_tenant_config
    * print requestPayload
    And request requestPayload
    When method POST
    Then status 201
    * print 'Filter response---->',response

  #    # 2nd API call to get tenant config
  #    * def AUrl = requestUrl + '/api/registry/tenants/' + _custom_tenant_id
  #    Given url AUrl
  #    And header Content-Type = 'application/json'
  #    And header Authorization = BearerToken
  #    When method GET
  #    Then status 200
  #    * def beforeRunTenantConfig = response
  #    * print 'Filter response---->',beforeRunTenantConfig