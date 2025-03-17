Feature: features API of User Management automation from roles to getting features and getting

  Background:
    * configure charset = null
    #   * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = "Bearer eyJraWQiOiJUeHZBRldSUTJ4QVJjSGlVeVRtQisyV3BKa3VLaTZ3aDZKbkNaXC9nNkJBYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfdFhFUlFkZTdGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiMmhscDRndTRlYTRrMG9qczhoaHFxc28xZmQiLCJvcmlnaW5fanRpIjoiZWEzNTM1ZDAtZDg3NS00NzgxLThlMTQtMDI2OGMzMzgyODA1IiwidG9rZW5fdXNlIjoiYWNjZXNzIiwic2NvcGUiOiJwaG9uZSBvcGVuaWQgcHJvZmlsZSBlbWFpbCIsImF1dGhfdGltZSI6MTcwMTI0NzQyNiwiZXhwIjoxNzAxMzMzODI2LCJpYXQiOjE3MDEyNDc0MjcsImp0aSI6ImI3NTNmN2QwLWMyNDMtNGM3OC05YWI4LThjOTUxZmRmNTAxYiIsInVzZXJuYW1lIjoiNTgzN2YyM2UtZDRlMC00Yjk5LTk1NDYtOTk1MmI2MDA5ZTJiIn0.RAfwRnO0tSZtlES2n4NuQdEF3OdcQG_nhEK0inuwIlS3TGfN724oTd59FKv4l2OgWWAMW6gmUWL9pOmSwNNpnzFhNovmOcJiWyLmWU62pQtvtmSImrfkxYe7RtKn8UBxbVNDe_wFkzJ9dEYyvLa-kI_S2Hw5snxze_roLH6MG0ahWEGlVMJGVVvUWcbocknEvtUWRS942WYNMS9yh76oqHziHV6Eje1VazrASlc3sRjw8SqqQ7X41uoxRORq8ZBIiZE5SEIOHE-n2g2_7vCpJ4qtFYYkMaiDk1Ga4OwzUjYPK3FuRd1qQ8CwkKilcfhp_sOSdZ-cyk7-2xrVk0d3sw"


  Scenario:GET ROLES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/tenant_01GKKZ8HMH2FQHBHE08YHMHJKZ/roles'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def roles = response
    * print 'Roles--->',roles

  Scenario:GET ALl FEATURES of the tenants
    * def umUrl = requestUrl + '/api/tenants/features'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def all_features = response
    * print 'features of tenant--->',all_features
    * def all_features_list = get $[*].id
    * print all_features_list

  Scenario:GET FEATURES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/01GFJCPPHBAWE6SBY28VGJV84Y/features'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def features = response
    * print 'features of tenant--->',features
    * def features_list = get $[*].id
    * print features_list
  #        get $.data.upi.advanced.accounts[*].upiId


  Scenario:PUT FEATURES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/01GFJCPPHBAWE6SBY28VGJV84Y/features'
    Given url umUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "featureIds":[
          "feature_01GKKS7GTG4PJ7QF7M34YW0WN2",
          "feature_01GKKS7GTGFBXBDK8PTNJB43QA",
          "feature_01GKKS7GTGK7V4QC3QTCMSV58R",
          "feature_01GKKS7GTGP3J7BFEK278TFEB8",
          "feature_01GKKS7GTGR7WTXZXXPGREHY92",
          "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
          "feature_01GKKS7GTGXXMFEAHSP6XSMH52",
          "feature_01GSYH4B4X2QMDPS5E03SZVE62",
          "feature_01H07GA45JR7M55M64MJXTBNNE",
          "feature_01HFY9H4R35GPGZ897HF45GEN0",
          "feature_01HFY9SPPFNB3XW0WSKZ4E077J",
          "feature_01HG0MR7S8HZB2YG588E18WXXK"
        ]
      }
      """
    And request requestPayload
    When method PUT
    Then status 200
    * def dpResponse = response
    * print dpResponse



















































