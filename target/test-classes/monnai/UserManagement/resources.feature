Feature: features API of User Management automation from roles to getting features and getting

  Background:
    * configure charset = null
    #   * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = "Bearer eyJraWQiOiJUeHZBRldSUTJ4QVJjSGlVeVRtQisyV3BKa3VLaTZ3aDZKbkNaXC9nNkJBYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhNDQ4ZWQ5NS04NDFmLTRlZGItYTI5Mi0wY2RiMmY5ZDBkNjAiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfdFhFUlFkZTdGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiMmhscDRndTRlYTRrMG9qczhoaHFxc28xZmQiLCJvcmlnaW5fanRpIjoiOWYwNzIxM2UtNzM3Yy00MmQzLThhMzAtN2FkZDM1Y2MzZmRmIiwiZXZlbnRfaWQiOiI3NTFjODVhMC0yMDEwLTQwNDctYTQ2YS04ZTYwZGFhYThhOWEiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6InBob25lIG9wZW5pZCBwcm9maWxlIGVtYWlsIiwiYXV0aF90aW1lIjoxNzI3MDY4ODA3LCJleHAiOjE3MjcxNTUyMDcsImlhdCI6MTcyNzA2ODgwOCwianRpIjoiOWQyYmEzMzQtNDc5Zi00M2E4LThjNWMtNzA5YmIxODk3ODRmIiwidXNlcm5hbWUiOiJhNDQ4ZWQ5NS04NDFmLTRlZGItYTI5Mi0wY2RiMmY5ZDBkNjAifQ.njPqQ-nr5g6jE1qe8sZKxoVKY75J5_VB7rIaesfa0irkpoxjq77r_HaUxEbDoe9SAudr9biB8CpthLVKpD9Dffzo5VDcZk-laIm3MU_C7qr2sJVWV4Jps2kHhluFEjY1JEg0J3_piHq-eX1c5mNCOwdjNvK24WPC5q8QE1M5Q72RmG2B_2lEBZD-f2mhMdT7PVSxL3BreY7fnmLpkRHuGvwfqOKnZlsla4Sqs_AilLX4jY9dNYUJNB6DO9HC602-oN55MflwWF9YXrtQNXC-S9gjFNE9Qii7J9wXRCPkeg5kUj4PKLUTmaFn70TR1nKwHZrw71ybI-boIgHpZF2PMA"
    * def id_token = "eyJraWQiOiJLNmpwVFo2UURzYVBzNmtXdTBIQWNGM2dqSDRrV0pQZCtmdkFtSUhnSnVFPSIsImFsZyI6IlJTMjU2In0.eyJhdF9oYXNoIjoiUGZUWVZ6U2tzLWtRb0stYmlDM1hrZyIsInN1YiI6ImE0NDhlZDk1LTg0MWYtNGVkYi1hMjkyLTBjZGIyZjlkMGQ2MCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJyb2xlcyI6Ik1PTk5BSV9BRE1JTiIsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5hcC1zb3V0aGVhc3QtMS5hbWF6b25hd3MuY29tXC9hcC1zb3V0aGVhc3QtMV90WEVSUWRlN0YiLCJjb2duaXRvOnVzZXJuYW1lIjoiYTQ0OGVkOTUtODQxZi00ZWRiLWEyOTItMGNkYjJmOWQwZDYwIiwiZ2l2ZW5fbmFtZSI6Illhc2hhcyIsIm9yaWdpbl9qdGkiOiI5ZjA3MjEzZS03MzdjLTQyZDMtOGEzMC03YWRkMzVjYzNmZGYiLCJhdWQiOiIyaGxwNGd1NGVhNGswb2pzOGhocXFzbzFmZCIsImV2ZW50X2lkIjoiNzUxYzg1YTAtMjAxMC00MDQ3LWE0NmEtOGU2MGRhYWE4YTlhIiwidGVuYW50TmFtZSI6Ik1vbm5haSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNzI3MDY4ODA3LCJ0ZW5hbnRJZCI6IjAxR0ZKQ1BQSEJBV0U2U0JZMjhWR0pWODRZIiwiZXhwIjoxNzI3MTU1MjA3LCJpYXQiOjE3MjcwNjg4MDgsImZhbWlseV9uYW1lIjoiTW9ubmFpIiwianRpIjoiOTg4MmUyMzUtYzNmOC00MTkxLTkwNGUtZDNhNDE2OTdlNWUwIiwiZW1haWwiOiJ5YXNoYXNAbW9ubmFpLmNvbSJ9.sj9Zm3SCyrhCu0vH1jzZbG7ZAt1xNF8kokXo4RPOhcSW-0WwFzKG7KyjzevMZuVrrdiPwQnS3QSOStbbRr-wArhCvOppuU2MFqQ5oush-pioLhWRVCghR4bzyEjcdK9MhOovKGRuQDrVwTWkurgBwMnrJBm30XJpkoLpRJ0b2fH1qI_iSbI4mElH4NXLo4exFShBcGx8I4WwphJGnWz9aO0ebns3h-AIv8l9Y4YzeE6ZpMViNAmF4EtD4z3iX14hqJLlQOz23DSEwXP7C9A4hpvuTvLn7qK9WlQ-P-sVRg_14Uhxf2rqSvD-moslNdJ67flck9HnYb_XwkbCJuvRGg"

  Scenario:GET ROLES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/01GFJCPPHBAWE6SBY28VGJV84Y/roles'
    Given url umUrl
    And header Content-Type = 'application/json'
    And header id_token = id_token
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def roles = response
    * print 'Roles--->',roles


  Scenario:GET ALl RESOURCES of the tenants
    * def umUrl = requestUrl + '/api/tenants/resources'
    Given url umUrl
    And header Content-Type = 'application/json'
    And header id_token = id_token
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def all_resources = response
    * print 'all_resources of tenant--->',all_resources
    * def all_resources_list = get $[*].id
    * print all_resources_list

  Scenario:GET RESOURCES of the Roles by Role_id
    * def umUrl = requestUrl + '/api/tenants/roles/role_01HFY0GJHQBCJC9YH1CC7W9VDW/resources'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def resources = response
    * print 'resources of tenant--->',resources
    * def resources_list = get $[*].id
    * print resources_list


  Scenario:PUT RESOURCES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/roles/role_01HFY0GJHQBCJC9YH1CC7W9VDW/resources'
    Given url umUrl
    And header Content-Type = 'application/json'
    And header Authorization = BearerToken
    And def requestPayload =
      """
      {
        "resourceIds": [
          "resource_01GKKV6BJX598HQH68HCEH6DFM",
          "resource_01GKKV6BJX67ZX0HT3HYZE1S0Z",
          "resource_01GKKV6BJX8NPA9D172B6XF8BN",
          "resource_01GKKV6BJX98X9JRC5P41WAK4T",
          "resource_01GKKV6BJXA14CCT6PSXZJ0KN1",
          "resource_01GKKV6BJXFKMTW3N9Z5ZB2EB8",
          "resource_01GKKV6BJXGYCT35FBM5Z2YYE5",
          "resource_01GKKV6BJXJP5ZGE68TZNWE8ZN",
          "resource_01GKKV6BJXK19Z2M22TXVEWEAG",
          "resource_01GKKV6BJXKVC3APKSVNJKYSVV",
          "resource_01GKKV6BJXKZ45AMW5356FPJAZ",
          "resource_01GKKV6BJXPSWTGY64NZYB9GCF",
          "resource_01GKKV6BJXQPP3YWJQJSQFD3WC",
          "resource_01GKKV6BJXRFPBX8QX9ARBSG2J",
          "resource_01GKKV6BJXXJWKN1A6P5YQRE6Z",
          "resource_01GKKV6BJXYZ7TTNQ6DG55CDAA",
          "resource_01GKKV6BJY3JNPKRFFXBJMKSMA",
          "resource_01GKKV6BJYHJH48NT8TWVM3SXQ",
          "resource_01GKKV6BJYYBKV040XMKYT9R2S",
          "resource_01GSYHNTK001R5941TE8RNBK50",
          "resource_01HFY9HCD5KTVV6FVPF6GCGYYN",
          "resource_01HFY9V8E1T0QDFMRVY0YGY13M",
          "resource_01HG29ASZWTMSHNTNDQAAYM4K7"
        ]
      }
      """
    And request requestPayload
    When method PUT
    Then status 200
    * def resources = response
    * print 'resources of tenant--->',resources
    * def resources_list = get $.resources[*].id
    * print resources_list



  @um_test_1
  Scenario:PUT RESOURCES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/roles/role_01HFY0GJHQBCJC9YH1CC7W9VDW/resources'

    * def all_resources =
      """
      [
        {
          "id": "resource_01GKKV6BJX598HQH68HCEH6DFM",
          "name": "EditUsers",
          "featureId": "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
          "path": "/api/tenants/users/*",
          "method": "PUT",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJX67ZX0HT3HYZE1S0Z",
          "name": "ListCustomers",
          "featureId": "feature_01GKKS7GTGP3J7BFEK278TFEB8",
          "path": "/api/tenants/*/subtenants",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJX69KCR1F4QH5B74WE",
          "name": "CreateRoles",
          "featureId": "feature_01GKKS7GTG2MHPEX4JVFXBWKMD",
          "path": "/api/tenants/*/roles",
          "method": "POST",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJX8NPA9D172B6XF8BN",
          "name": "UpdateFeaturesOfACustomer",
          "featureId": "feature_01GKKS7GTGP3J7BFEK278TFEB8",
          "path": "/api/tenants/*/features",
          "method": "PUT",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJX98X9JRC5P41WAK4T",
          "name": "ViewTransactionsDetails",
          "featureId": "feature_01GKKS7GTGFBXBDK8PTNJB43QA",
          "path": "/api/transactions/**",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXA14CCT6PSXZJ0KN1",
          "name": "RemoveCustomers",
          "featureId": "feature_01GKKS7GTGP3J7BFEK278TFEB8",
          "path": "/api/tenants/*",
          "method": "DELETE",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXFKMTW3N9Z5ZB2EB8",
          "name": "ListUsers",
          "featureId": "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
          "path": "/api/tenants/*/users",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXGYCT35FBM5Z2YYE5",
          "name": "RemoveUsers",
          "featureId": "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
          "path": "/api/tenants/users/*",
          "method": "DELETE",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXJP5ZGE68TZNWE8ZN",
          "name": "CreateUsers",
          "featureId": "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
          "path": "/api/tenants/*/users",
          "method": "POST",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXK19Z2M22TXVEWEAG",
          "name": "GetCustomerDetails",
          "featureId": "feature_01GKKS7GTGP3J7BFEK278TFEB8",
          "path": "/api/tenants/*",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXKVC3APKSVNJKYSVV",
          "name": "UpdateRolesOfAUser",
          "featureId": "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
          "path": "/api/tenants/users/*/roles",
          "method": "PUT",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXKZ45AMW5356FPJAZ",
          "name": "RunInsights1.0",
          "featureId": "feature_01GKKS7GTGR7WTXZXXPGREHY92",
          "path": "/api/insights/**",
          "method": "POST",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXPSWTGY64NZYB9GCF",
          "name": "EditCustomers",
          "featureId": "feature_01GKKS7GTGP3J7BFEK278TFEB8",
          "path": "/api/tenants/*",
          "method": "PUT",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXQPP3YWJQJSQFD3WC",
          "name": "GetUserDetails",
          "featureId": "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
          "path": "/api/tenants/users/*",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXRFPBX8QX9ARBSG2J",
          "name": "ListRolesOfAUser",
          "featureId": "feature_01GKKS7GTGVJNG3WN9BH6GVK56",
          "path": "/api/tenants/users/*/roles",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXXJWKN1A6P5YQRE6Z",
          "name": "ListFeaturesOfACustomer",
          "featureId": "feature_01GKKS7GTGP3J7BFEK278TFEB8",
          "path": "/api/tenants/*/features",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJXYZ7TTNQ6DG55CDAA",
          "name": "CreateCustomers",
          "featureId": "feature_01GKKS7GTGP3J7BFEK278TFEB8",
          "path": "/api/tenants/*/subtenants",
          "method": "POST",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJY1G836WXM1B3J5VM0",
          "name": "RemoveRoles",
          "featureId": "feature_01GKKS7GTG2MHPEX4JVFXBWKMD",
          "path": "/api/tenants/roles/*",
          "method": "DELETE",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJY1X0MPB6PJFQZ05CW",
          "name": "EditResources",
          "featureId": "feature_01GKKS7GTGVG10XSMRRG70DM4W",
          "path": "/api/tenants/resources/*",
          "method": "PUT",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJY354B8BZR7X1YZJM1",
          "name": "RemoveResources",
          "featureId": "feature_01GKKS7GTGVG10XSMRRG70DM4W",
          "path": "/api/tenants/resources/*",
          "method": "DELETE",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJY3JNPKRFFXBJMKSMA",
          "name": "RunBatch",
          "featureId": "feature_01GKKS7GTGK7V4QC3QTCMSV58R",
          "path": "/api/batch/**",
          "method": "POST",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJY5K3GZ32NVPS67T7D",
          "name": "EditFeatures",
          "featureId": "feature_01GKKS7GTGHRX3KTX97902AQCS",
          "path": "/api/tenants/features/*",
          "method": "PUT",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJY7MYGF00H6PRJ2C73",
          "name": "ProductCoverage",
          "featureId": "feature_01GKKS7GTG3APM706WWRA555CF",
          "path": "/api",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYATQSHEJ55N4NGW5H",
          "name": "ListResourcesOfARole",
          "featureId": "feature_01GKKS7GTG2MHPEX4JVFXBWKMD",
          "path": "/api/tenants/roles/*/resources",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYB2Q0W0936QVEM3WT",
          "name": "GetRoleDetails",
          "featureId": "feature_01GKKS7GTG2MHPEX4JVFXBWKMD",
          "path": "/api/tenants/roles/*",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYGEW9NNBB3FV01S1R",
          "name": "ListResources",
          "featureId": "feature_01GKKS7GTGVG10XSMRRG70DM4W",
          "path": "/api/tenants/resources",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYHJH48NT8TWVM3SXQ",
          "name": "Documentation",
          "featureId": "feature_01GKKS7GTGXXMFEAHSP6XSMH52",
          "path": "/api",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYJERXJQBN61ZEQ1NT",
          "name": "UpdateResourcesOfARole",
          "featureId": "feature_01GKKS7GTG2MHPEX4JVFXBWKMD",
          "path": "/api/tenants/roles/*/resources",
          "method": "PUT",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYJKDFZP8GD5E1VECC",
          "name": "RemoveFeatures",
          "featureId": "feature_01GKKS7GTGHRX3KTX97902AQCS",
          "path": "/api/tenants/features/*",
          "method": "DELETE",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYMWBCWXV8FRXP8T5F",
          "name": "ListRoles",
          "featureId": "feature_01GKKS7GTG2MHPEX4JVFXBWKMD",
          "path": "/api/tenants/*/roles",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYNK6R6X4AAFVD7GS2",
          "name": "CreateResources",
          "featureId": "feature_01GKKS7GTGVG10XSMRRG70DM4W",
          "path": "/api/tenants/resources",
          "method": "POST",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYR9TGHP9J25S34MRD",
          "name": "ListFeatures",
          "featureId": "feature_01GKKS7GTGHRX3KTX97902AQCS",
          "path": "/api/tenants/features",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYS772GPRV5E7Q1059",
          "name": "GetFeatureDetails",
          "featureId": "feature_01GKKS7GTGHRX3KTX97902AQCS",
          "path": "/api/tenants/features/*",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYVB9QN8K0YR80GAYY",
          "name": "EditRoles",
          "featureId": "feature_01GKKS7GTG2MHPEX4JVFXBWKMD",
          "path": "/api/tenants/roles/*",
          "method": "PUT",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYWBHN7MZTHFWR4Q77",
          "name": "GetResourcesDetails",
          "featureId": "feature_01GKKS7GTGVG10XSMRRG70DM4W",
          "path": "/api/tenants/resources/*",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYX83JVSABZ62QCQR1",
          "name": "CreateFeatures",
          "featureId": "feature_01GKKS7GTGHRX3KTX97902AQCS",
          "path": "/api/tenants/features",
          "method": "POST",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GKKV6BJYYBKV040XMKYT9R2S",
          "name": "DashBoard",
          "featureId": "feature_01GKKS7GTG4PJ7QF7M34YW0WN2",
          "path": "/api",
          "method": "GET",
          "createdAt": "2022-12-09T13:00:49Z",
          "updatedAt": "2022-12-09T13:00:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GSYHNTK001R5941TE8RNBK50",
          "name": "ReadDataPartnerFromRegistry",
          "featureId": "feature_01GSYH4B4X2QMDPS5E03SZVE62",
          "path": "/api/registry/**",
          "method": "GET",
          "createdAt": "2023-03-14T07:53:39Z",
          "updatedAt": "2023-03-14T07:53:39Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GSYHP3DJ9RQJNXHEW56KNQ3V",
          "name": "UpdateInPartnerExchange",
          "featureId": "feature_01GSYH4B4X2QMDPS5E03SZVE62",
          "path": "/api/exchange/**",
          "method": "PUT",
          "createdAt": "2023-03-14T07:53:39Z",
          "updatedAt": "2023-03-14T07:53:39Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GSYHP9J2JMK9WSZXN5X3SRER",
          "name": "AccessEnrichmentEngine",
          "featureId": "feature_01GSYH4B4X2QMDPS5E03SZVE62",
          "path": "/api/enrichment/**",
          "method": "POST",
          "createdAt": "2023-03-14T07:53:39Z",
          "updatedAt": "2023-03-14T07:53:39Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GSYJ6423YK188BP042270N2H",
          "name": "UpdateDataPartnerInRegistry",
          "featureId": "feature_01GSYH4B4X2QMDPS5E03SZVE62",
          "path": "/api/registry/**",
          "method": "PUT",
          "createdAt": "2023-03-14T07:53:39Z",
          "updatedAt": "2023-03-14T07:53:39Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GSYJ69ZXWDN9F5P9TE1MYES3",
          "name": "DeleteDataPartnerFromRegistry",
          "featureId": "feature_01GSYH4B4X2QMDPS5E03SZVE62",
          "path": "/api/registry/**",
          "method": "DELETE",
          "createdAt": "2023-03-14T07:53:39Z",
          "updatedAt": "2023-03-14T07:53:39Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01GSYJ6ESQH5T6YEP7DT2HSJAK",
          "name": "WriteDataPartnerInRegistry",
          "featureId": "feature_01GSYH4B4X2QMDPS5E03SZVE62",
          "path": "/api/registry/**",
          "method": "POST",
          "createdAt": "2023-03-14T07:53:39Z",
          "updatedAt": "2023-03-14T07:53:39Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HFY9HCD5KTVV6FVPF6GCGYYN",
          "name": "RiskInsights",
          "featureId": "feature_01HFY9H4R35GPGZ897HF45GEN0",
          "path": "/api/insights/**",
          "method": "POST",
          "createdAt": "2023-11-24T06:08:45Z",
          "updatedAt": "2023-11-24T06:08:45Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HFY9V8E1T0QDFMRVY0YGY13M",
          "name": "VerificationAML",
          "featureId": "feature_01HFY9SPPFNB3XW0WSKZ4E077J",
          "path": "/api/verification/**",
          "method": "POST",
          "createdAt": "2023-11-24T06:08:45Z",
          "updatedAt": "2023-11-24T06:08:45Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HG29ASZWTMSHNTNDQAAYM4K7",
          "name": "RunBatchScore",
          "featureId": "feature_01HG0MR7S8HZB2YG588E18WXXK",
          "path": "/api/batch-processor/score/**",
          "method": "POST",
          "createdAt": "2023-11-29T07:18:24Z",
          "updatedAt": "2023-11-29T07:18:24Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HHMBWKZR178Y2E4JZS6PTVMN",
          "name": "TransactionSummary",
          "featureId": "feature_01HHMBMY682Q2F6FZRXD1D2TKZ",
          "path": "/api/transactions/**",
          "method": "GET",
          "createdAt": "2023-12-15T13:07:07Z",
          "updatedAt": "2023-12-15T13:07:07Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HKW28VJVHRTB0ARANN6617HN",
          "name": "GlobalDashboard",
          "featureId": "feature_01HKW28KW63NBX5J1KKA7JWNKS",
          "path": "/api",
          "method": "GET",
          "createdAt": "2024-01-12T03:34:35Z",
          "updatedAt": "2024-01-12T03:34:35Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HNYD72565CB4HJCRWG3PB3EP",
          "name": "TransactionDetailsViewButton",
          "featureId": "feature_01HNYD72555W1TJS691S019XN4",
          "path": "/api/transactions/tenant",
          "method": "GET",
          "createdAt": "2024-02-13T06:06:33Z",
          "updatedAt": "2024-02-13T06:06:33Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HNYDDPZPQ7P5P54MTSD1QKQV",
          "name": "TransactionDetailsDownloadButton",
          "featureId": "feature_01HNYDDPZNFTGEYT58YHYVMQ4Y",
          "path": "/api/transactions/tenant/*/download",
          "method": "GET",
          "createdAt": "2024-02-13T06:06:33Z",
          "updatedAt": "2024-02-13T06:06:33Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HQ5QN8X2T0HFHWZF3C6ZVE5Z",
          "name": "SystemStatus",
          "featureId": "feature_01HQ5QK2MJ64WXR54F531KN0JA",
          "path": "/systemStatus",
          "method": "GET",
          "createdAt": "2024-02-23T06:01:32Z",
          "updatedAt": "2024-02-23T06:01:32Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HQ7NN58RM69DWZV3KV9NPGM7",
          "name": "ViewAnalytics",
          "featureId": "feature_01HQ7NMT0HC0G0AXZ64CCBENMH",
          "path": "/api/batch-processor/score/**",
          "method": "POST",
          "createdAt": "2024-02-23T06:35:28Z",
          "updatedAt": "2024-02-23T06:35:28Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HRBWWZ5N24SN19QZSG87WEMD",
          "name": "TransactionDetailsReviewButton",
          "featureId": "feature_01HRBWSNSAQD9T5EQRCJXMJE5X",
          "path": "/api/transactions/tenant",
          "method": "GET",
          "createdAt": "2024-03-20T05:35:42Z",
          "updatedAt": "2024-03-20T05:35:42Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01HYAAHMPRWYNHJ9Z8TYHH59NS",
          "name": "RunInsights",
          "featureId": "feature_01HYAAFG9PM1XSX740N0AQNG9X",
          "path": "/api/insights/**",
          "method": "POST",
          "createdAt": "2024-05-24T04:46:57Z",
          "updatedAt": "2024-05-24T04:46:57Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01J2B6YTCFJP7NKW9Q3EJ3QZ8B",
          "name": "Rules",
          "featureId": "feature_01J2B9AQCG1EA72R346KYWDBBH",
          "path": "/api/rulesengine/**",
          "method": "POST",
          "createdAt": "2024-07-10T04:19:48Z",
          "updatedAt": "2024-07-10T04:19:48Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01J2B72KGF57DEANCMQBN8WYJ2",
          "name": "TransactionDetailsInternalViewButton",
          "featureId": "feature_01J2B724XBA0AJMYVKPWVH4QHB",
          "path": "/api/transactions/tenant/*/request/*/transaction-omnidata/download",
          "method": "GET",
          "createdAt": "2024-07-10T04:19:48Z",
          "updatedAt": "2024-07-10T04:19:48Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01J2B9BDCNQ2C9KP9NHQF0S2DZ",
          "name": "Rulebooks",
          "featureId": "feature_01J2B9B47E35J554NXHFJHK3AS",
          "path": "/api/rulesengine/**",
          "method": "POST",
          "createdAt": "2024-07-10T04:19:49Z",
          "updatedAt": "2024-07-10T04:19:49Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        },
        {
          "id": "resource_01J2BEHGP9A6NYT5Y8H4WAJYZN",
          "name": "Verification",
          "featureId": "feature_01J2B6YDZQPV2ME4HWG1JA20V0",
          "path": "/api/verification/**",
          "method": "POST",
          "createdAt": "2024-07-10T04:19:48Z",
          "updatedAt": "2024-07-10T04:19:48Z",
          "createdBy": "seed",
          "updatedBy": "seed"
        }
      ]
      """
    * print 'all_resources of tenant--->',all_resources
    * def all_resources_list = get all_resources[*].id
    * print all_resources_list


