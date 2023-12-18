Feature: INCOME_ESTIMATION Package full Automation

  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

    # When Yashas did automation, Phone and NIK id were both are mandatory fields. Automation was done on the reference of manual sign off given by Sameena.

  Scenario Outline: Validation of INCOME_ESTIMATION Positive scenario for valid phoneNumber & NIK id as input -> <Scenario> |
    Given url requestUrl
    And def payload = read("data/" + source + "/INCOME_ESTIMATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
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
    Then status <statusCode>
    * match $.data.income.estimation contains only deep payload.response.data.income.estimation
    * match $.meta contains only deep payload.response.meta
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                                              | statusCode |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_null_2500000      | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_2500000_3500000   | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_3500000_4500000   | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_4500000_5500000   | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_5500000_7500000   | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_7500000_10000000  | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_10000000_12500000 | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_12500000_15000000 | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_15000000_17500000 | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_17500000_20000000 | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_20000000_25000000 | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_25000000_30000000 | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_30000000_40000000 | 200        |
#      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_40000000_50000000  | 200        |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_50000000_75000000 | 200        |
#      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_750000000_100000000 | 200        |
#      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_salaryRange_100000000_null     | 200        |


  # below test case for input NIK id and not adding optional datapoint phone number in the request
  Scenario Outline: Validation of INCOME_ESTIMATION Positive scenario for valid NIK id only as input -> <Scenario> |
    Given url requestUrl
    And def payload = read("data/" + source + "/INCOME_ESTIMATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
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
    Then status <statusCode>
    * match $.data.income.estimation contains only deep payload.response.data.income.estimation
    * match $.meta contains only deep payload.response.meta
    * match $.errors contains only deep payload.response.errors
    Examples:
      | Scenario                                                                      | statusCode |
      | INCOME_ESTIMATION_POSITIVE_input_only_NIK_output_salaryRange_7500001_10000000 | 200        |


  Scenario Outline: Validation of INCOME_ESTIMATION Positive scenario for valid phoneNumber & NIK id as input where are data partner doesn't return data  -> <Scenario> |
    Given url requestUrl
    And def payload = read("data/" + source + "/INCOME_ESTIMATION/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
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
    Then status <statusCode>
    * match $.data.income.estimation == null
    * match $.meta contains only deep payload.response.meta
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                                | statusCode |
      | INCOME_ESTIMATION_POSITIVE_input_phoneNumber_NIK_output_estimation_null | 200        |

  Scenario Outline: Validation of INCOME_ESTIMATION NEGATIVE scenario for permutation and combination of input data points -> <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/INCOME_ESTIMATION/<Scenario>.json")
    And request payload.request.phoneDefaultCountryCode = <phoneDefaultCountryCode>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
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
    Then status <statusCode>
    * match $.meta contains only deep payload.response.meta
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                                    | statusCode | phoneDefaultCountryCode |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_phoneDefaultCountryCode_Valid   | 400        | "IN"                    |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_phoneDefaultCountryCode_missing | 400        | ""                      |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_phoneDefaultCountryCode_missing | 400        | " "                     |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_phoneDefaultCountryCode_invalid | 400        | "IDNONESIA"             |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_phoneDefaultCountryCode_invalid | 400        | "123"                   |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_phoneDefaultCountryCode_invalid | 400        | "abc"                   |


  Scenario Outline: Validation of INCOME_ESTIMATION NEGATIVE scenario for permutation and combination of input idType data points -> <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/INCOME_ESTIMATION/<Scenario>.json")
    And request payload.request.idType = <idType>
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    When method POST
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
    Then status <statusCode>
    * match $.meta contains only deep payload.response.meta
    * match $.errors contains only deep payload.response.errors

    Examples:
      | Scenario                                                   | statusCode | idType   |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_idType_invalid | 400        | "NIK123" |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_idType_invalid | 400        | "123"    |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_idType_invalid | 400        | "abcdef" |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_idType_missing | 400        | ""       |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_idType_missing | 400        | " "      |
      | INCOME_ESTIMATION_NEGATIVE_input_validation_idType_missing | 400        | null     |








