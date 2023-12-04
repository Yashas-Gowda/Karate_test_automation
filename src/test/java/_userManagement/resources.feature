Feature: features API of User Management automation from roles to getting features and getting

  Background:
    * configure charset = null
#    * def authFeature = call read('classpath:insights/Auth_Token_Generation.feature')
    * def BearerToken = "Bearer eyJraWQiOiJUeHZBRldSUTJ4QVJjSGlVeVRtQisyV3BKa3VLaTZ3aDZKbkNaXC9nNkJBYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI1ODM3ZjIzZS1kNGUwLTRiOTktOTU0Ni05OTUyYjYwMDllMmIiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfdFhFUlFkZTdGIiwidmVyc2lvbiI6MiwiY2xpZW50X2lkIjoiMmhscDRndTRlYTRrMG9qczhoaHFxc28xZmQiLCJvcmlnaW5fanRpIjoiZWEzNTM1ZDAtZDg3NS00NzgxLThlMTQtMDI2OGMzMzgyODA1IiwidG9rZW5fdXNlIjoiYWNjZXNzIiwic2NvcGUiOiJwaG9uZSBvcGVuaWQgcHJvZmlsZSBlbWFpbCIsImF1dGhfdGltZSI6MTcwMTI0NzQyNiwiZXhwIjoxNzAxMzMzODI2LCJpYXQiOjE3MDEyNDc0MjcsImp0aSI6ImI3NTNmN2QwLWMyNDMtNGM3OC05YWI4LThjOTUxZmRmNTAxYiIsInVzZXJuYW1lIjoiNTgzN2YyM2UtZDRlMC00Yjk5LTk1NDYtOTk1MmI2MDA5ZTJiIn0.RAfwRnO0tSZtlES2n4NuQdEF3OdcQG_nhEK0inuwIlS3TGfN724oTd59FKv4l2OgWWAMW6gmUWL9pOmSwNNpnzFhNovmOcJiWyLmWU62pQtvtmSImrfkxYe7RtKn8UBxbVNDe_wFkzJ9dEYyvLa-kI_S2Hw5snxze_roLH6MG0ahWEGlVMJGVVvUWcbocknEvtUWRS942WYNMS9yh76oqHziHV6Eje1VazrASlc3sRjw8SqqQ7X41uoxRORq8ZBIiZE5SEIOHE-n2g2_7vCpJ4qtFYYkMaiDk1Ga4OwzUjYPK3FuRd1qQ8CwkKilcfhp_sOSdZ-cyk7-2xrVk0d3sw"


  Scenario:GET ROLES of the tenants by tenant_id
    * def umUrl = requestUrl + '/api/tenants/01GFJCPPHBAWE6SBY28VGJV84Y/roles'
    Given url umUrl
    And header Content-Typ = 'application/json'
    And header Authorization = BearerToken
    When method GET
    Then status 200
    * def roles = response
    * print 'Roles--->',roles

  Scenario:GET ALl RESOURCES of the tenants
    * def umUrl = requestUrl + '/api/tenants/resources'
    Given url umUrl
    And header Content-Typ = 'application/json'
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







