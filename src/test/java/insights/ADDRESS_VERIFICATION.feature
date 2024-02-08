@ignore
Feature:Testing of DPI - ADDRESS_VERIFICATION feature scenarios

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  Scenario Outline: Validate the ADDRESS_VERIFICATION package when   -> <Scenario> | InputIP -> <phoneNumber>.
    Given url requestUrl
    And def payload = read("data/" + source + "/ADDRESS_VERIFICATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
    Then status <statusCode>
    # cloud watch traces -start
    * print karate.request.headers
    * print karate.response.headers
    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    * def reference_id = karate.request.headers['x-reference-id']
    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    # ResponseTime
    * print 'responseTime----->',responseTime
    # Request-response
    * print 'API Request----->',payload.request
    * print 'Expected Response---->',payload.response
    * print 'Actual Response---->',karate.pretty(response)
    Then match $.data.upi.advanced contains payload.response.data.upi.advanced
    Then match $.meta contains payload.response.meta
    Then match $.errors contains payload.response.errors

    Examples:
      | Scenario                    | statusCode |
      | ADDRESS_VERIFICATION_sample | 200        |

#  ADDRESS_VERIFICATION
#  Product understanding - Not
#  Test data - Not there
#  Special cases cot on manual testing - ?
#  Region ( Global / Specific) - ID only - currently supports phone number of IOH & XL Telecom Carriers.
#  Dynamic response - enabled
#  input - (address/locationCoordinates) + phone number (ID - supports Indonesia input) .
#  Logic -
#  input :  Phonenumber + address
#  we take locationCoordinates for input address by calling  here.com , after we get the locationCoordinates
#  carrier name - we can get by first 3 digits of the phone number
#  if
#  INDOSAT PREFIX:
#  '814', '815', '816', '855', '856', '857', '858'
#  HUTCH 3 PREFIX:
#  '895', '896', '897', '898', '899'
#  then Use Indosat & H3I Address Verification API
#  else if
#  XL PREFIX:
#  '817', '818', '819', '831', '832', '833', '838', '859', '877', '878', '879'
#  then Use XL Address Verification API
#  else (In case when the system is unable to match the first 3 digits of the input phone number)
#  message “CARRIER NOT SUPPORTED”
