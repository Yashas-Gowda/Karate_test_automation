@EMAIL_BASIC_FIDO  @EMAIL_PACKAGES @regTest_2
Feature: Testing of DPI  - EMAIL_BASIC feature scenarios with FIDO
  # This EMAIL_BASIC FIDO Manual sign off was given by Sameena, where we dont have monnai-fido mapping info. After discussion with roopa, Automation Test data is not verified and taken reference from manual sign off.
  # scenarios names are not updated, which will be picked in the next sprint
  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken


  Scenario Outline:  DPI EMAIL_BASIC positive scenario - where emailTenure = notnull :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
    * print __row
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
    * match header Content-Type == "application/json"
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    * match $.data.email.basic.domainDetails.creationTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
    * match $.data.email.basic.domainDetails.updateTime == "#null"
    * match $.data.email.basic.domainDetails.expiryTime == "#null"
    * set payload.response.data.email.basic.breach = "#ignore"
    * def breach = $.data.email.basic.breach
    #    * def isBreached = karate.jsonPath(jsonObject,'$.data.email.basic.breach?[]')
    #    * def isBreached = karate.jsonPath(karate.pretty(response),)
    * match  breach contains { "isBreached": true }
    * match  breach contains { "noOfBreaches": '#number? _ > 0' }
    * def CountOfBreach = $..breaches.length();
    * def noOfBreaches = CountOfBreach[0]
    * print 'Number of Objects in Breach array---->', noOfBreaches
    #    * match noOfBreaches == $.data.email.basic.breach.noOfBreaches
    * match  breach contains { "firstBreach": "#regex\\d{4}-\\d{2}-\\d{2}" }
    * match  breach contains { "lastBreach": "#regex\\d{4}-\\d{2}-\\d{2}" }
    * def breachs_array = $.data.email.basic.breach.breaches
    * match each breach.breaches == { platformName: '#string', domainName: '##string', breachDate: "#regex\\d{4}-\\d{2}-\\d{2}"  }
    * set payload.response.data.email.basic.emailTenure = "#ignore"
    * match $.data.email.basic.emailTenure == "#number"
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                                        | statusCode |
      | Email_Basic_Possitive_withTLDGmail(abc@gmail.com)_disposable_false_emailTenure_notnull                          | 200        |
      | Email_Basic_Positive_disposable_false_deliverable_true_noOfBreaches_16_EmailTenure_Present_in_double_digit      | 200        |
      | Email_Basic_deliverable_true_disposable_false_noOfBreaches_1_emailTenure_in_decimal_value                       | 200        |
      | Email_Basic_deliverable_true_registered_true_freeProvider_true_noOfBreaches_7_emailTenure_in_single_digit_value | 200        |


  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Imp scenarios for regression with emailTenure notnull  :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
    * print __row
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
    * match header Content-Type == "application/json"
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    * match $.data.email.basic.domainDetails.creationTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
    * match $.data.email.basic.domainDetails.updateTime == "#null"
    * match $.data.email.basic.domainDetails.expiryTime == "#null"
    * set payload.response.data.email.basic.breach = "#ignore"
    * def breach = $.data.email.basic.breach
    #    * def isBreached = karate.jsonPath(jsonObject,'$.data.email.basic.breach?[]')
    #    * def isBreached = karate.jsonPath(karate.pretty(response),)
    * match  breach contains { "isBreached": true }
    * match  breach contains { "noOfBreaches": '#number? _ > 0' }
    * def CountOfBreach = $..breaches.length();
    * def noOfBreaches = CountOfBreach[0]
    * print 'Number of Objects in Breach array---->', noOfBreaches
    #    * match noOfBreaches == $.data.email.basic.breach.noOfBreaches
    * match  breach contains { "firstBreach": "#regex\\d{4}-\\d{2}-\\d{2}" }
    * match  breach contains { "lastBreach": "#regex\\d{4}-\\d{2}-\\d{2}" }
    * def breachs_array = $.data.email.basic.breach.breaches
    * match each breach.breaches == { platformName: '#string', domainName: '##string', breachDate: "#regex\\d{4}-\\d{2}-\\d{2}"  }
    * set payload.response.data.email.basic.emailTenure = "#ignore"
    * match $.data.email.basic.emailTenure == "#number"
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                                                 | statusCode |
      | Email_Basic_deliverable_false_disposable_false_isBreached_true_noOfBreaches_more_than_7_emailTenure_notnull_double_digit | 200        |
      | Email_Basic_freeProvider_true_disposable_false_noOfBreaches_2_emailTenure_notnull                                        | 200        |
      | Email_Basic_registered_true_deliverable_disposable_false_freeProvider_true_isBreached_true                               | 200        |
      | Email_Basic_deliverable_true_freeProvider_true_websiteExists_true                                                        | 200        |


  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Imp scenarios for regression with emailTenure null | :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
    * print __row
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
    * match header Content-Type == "application/json"
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    * match $.data.email.basic.domainDetails.creationTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
    * match $.data.email.basic.domainDetails.updateTime == "#null"
    * match $.data.email.basic.domainDetails.expiryTime == "#null"
    * set payload.response.data.email.basic.domainDetails.companyName = "#ignore"
    * match $.data.email.basic.domainDetails.companyName == "##string"
    * set payload.response.data.email.basic.breach = "#ignore"
    * def breach = $.data.email.basic.breach
    * match  breach contains { "isBreached": false }
    * match  breach contains { "noOfBreaches": '#number? _ == 0' }
    * def CountOfBreach = $..breaches.length();
    * def noOfBreaches = CountOfBreach[0]
    * print 'Number of Objects in Breach array---->', noOfBreaches
    * match noOfBreaches == $.data.email.basic.breach.noOfBreaches
    * match  breach contains { "firstBreach": "#null" }
    * match  breach contains { "lastBreach": "#null" }
    * def breachs_array = $.data.email.basic.breach.breaches
    * match breachs_array == []
    * set payload.response.data.email.basic.emailTenure = "#ignore"
    * match $.data.email.basic.emailTenure == "#null"
    #    * match each breach.breaches == { platformName: '#string', domainName: '#string', breachDate: "#regex\\d{4}-\\d{2}-\\d{2}"  }
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                      | statusCode |
      | Email_Basic_isBreached_false_emailTenure_null | 200        |
      | Email_Basic_freeProvider_false                | 200        |
      | Email_Basic_deliverable_false                 | 200        |
      | Email_Basic_disposable_true                   | 200        |
  #data not found for | Email_Basic_suspiciousTld_true                | 200        |

  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Special cases :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
    * print __row
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
    * match header Content-Type == "application/json"
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    * match $.data.email.basic.domainDetails.creationTime == "##regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
    * match $.data.email.basic.domainDetails.updateTime == "#null"
    * match $.data.email.basic.domainDetails.expiryTime == "#null"
    * set payload.response.data.email.basic.domainDetails.companyName = "#ignore"
    * match $.data.email.basic.domainDetails.companyName == "##string"
    * set payload.response.data.email.basic.breach = "#ignore"
    * def breach = $.data.email.basic.breach
    * match  breach contains { "isBreached": false }
    * match  breach contains { "noOfBreaches": '#number? _ == 0' }
    * def CountOfBreach = $..breaches.length();
    * def noOfBreaches = CountOfBreach[0]
    * print 'Number of Objects in Breach array---->', noOfBreaches
    * match noOfBreaches == $.data.email.basic.breach.noOfBreaches
    * match  breach contains { "firstBreach": "#null" }
    * match  breach contains { "lastBreach": "#null" }
    * def breachs_array = $.data.email.basic.breach.breaches
    * match breachs_array == []
    * set payload.response.data.email.basic.emailTenure = "#ignore"
    * match $.data.email.basic.emailTenure == "#null"
    #    * match each breach.breaches == { platformName: '#string', domainName: '#string', breachDate: "#regex\\d{4}-\\d{2}-\\d{2}"  }
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                                                                                                                                                | statusCode |
      | Email_Basic_creationTime_updateTime_expiryTime_companyName_dmarcCompliance_spfStrict_suspiciousTld_custom_null_deliverable_registered_disposable_websiteExists_acceptAll_isBreached_freeProvider_false_emailTenure_null | 200        |

  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Special cases :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
    * print __row
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
    * match header Content-Type == "application/json"
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.freeProvider = "#ignore"
    * match $.data.email.basic.domainDetails.creationTime == "##regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
    * match $.data.email.basic.domainDetails.updateTime == "#null"
    * match $.data.email.basic.domainDetails.expiryTime == "#null"
    * match $.data.email.basic.domainDetails.freeProvider == "##boolean"
    * set payload.response.data.email.basic.breach = "#ignore"
    * def breach = $.data.email.basic.breach
    #    * def isBreached = karate.jsonPath(jsonObject,'$.data.email.basic.breach?[]')
    #    * def isBreached = karate.jsonPath(karate.pretty(response),)
    * match  breach contains { "isBreached": true }
    * match  breach contains { "noOfBreaches": '#number? _ > 0' }
    * def CountOfBreach = $..breaches.length();
    * def noOfBreaches = CountOfBreach[0]
    * print 'Number of Objects in Breach array---->', noOfBreaches
    #    * match noOfBreaches == $.data.email.basic.breach.noOfBreaches
    * match  breach contains { "firstBreach": "#regex\\d{4}-\\d{2}-\\d{2}" }
    * match  breach contains { "lastBreach": "#regex\\d{4}-\\d{2}-\\d{2}" }
    * def breachs_array = $.data.email.basic.breach.breaches
    * match each breach.breaches == { platformName: '#string', domainName: '##string', breachDate: "#regex\\d{4}-\\d{2}-\\d{2}"  }
    * set payload.response.data.email.basic.emailTenure = "#ignore"
    * match $.data.email.basic.emailTenure == "#number"
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                                                                                                             | statusCode |
      | Email_Basic_Possitive_withDomainNet(abc@you.me.net)_deliverable_true_disposable_true_noOfBreaches_1_emailTenure_notnull              | 200        |
      | Email_Basic_Possitive_withTLD&DomainOurearch(abc@ourearth.com)_creationTime_null_disposable_false_noOfBreaches_2_emailTenure_notnull | 200        |


  Scenario Outline:  DPI EMAIL_BASIC positive scenario where emailTenure = null :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
    * print __row
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
    * match header Content-Type == "application/json"
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    * match $.data.email.basic.domainDetails.creationTime == "##regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
    * match $.data.email.basic.domainDetails.updateTime == "#null"
    * match $.data.email.basic.domainDetails.expiryTime == "#null"
    * set payload.response.data.email.basic.domainDetails.companyName = "#ignore"
    * match $.data.email.basic.domainDetails.companyName == "##string"
    * set payload.response.data.email.basic.breach = "#ignore"
    * def breach = $.data.email.basic.breach
    * match  breach contains { "isBreached": false }
    * match  breach contains { "noOfBreaches": '#number? _ == 0' }
    * def CountOfBreach = $..breaches.length();
    * def noOfBreaches = CountOfBreach[0]
    * print 'Number of Objects in Breach array---->', noOfBreaches
    * match noOfBreaches == $.data.email.basic.breach.noOfBreaches
    * match  breach contains { "firstBreach": "#null" }
    * match  breach contains { "lastBreach": "#null" }
    * def breachs_array = $.data.email.basic.breach.breaches
    * match breachs_array == []
    * set payload.response.data.email.basic.emailTenure = "#ignore"
    * match $.data.email.basic.emailTenure == "#null"
    #    * match each breach.breaches == { platformName: '#string', domainName: '#string', breachDate: "#regex\\d{4}-\\d{2}-\\d{2}"  }
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors
    Examples:
      | Scenario                                             | statusCode |
      #      | Email_Basic_EmailDeliverable_False_companyName_emptyString | 200        |
      | Email_Basic_EmailTenure_Is_NULL                      | 200        |
      | Email_Basic_Positive_isBreached_false_noOfBreaches_0 | 200        |
  #no data | Email_Basic_Positive_CustomDomain_True | 200        |



  Scenario Outline:  DPI EMAIL_BASIC Negitive senario with invalid input :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
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
    * match  $.data.email.basic contains payload.response.data.email.basic
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors

    Examples:
      | Scenario                                                                                | statusCode |
      #    Test cases depricated
      #      | Email_Basic_Negitive_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
      #      | Email_Basic_Negitive_withPrefix_with@_NoDomainName(abc@)       | 400        |
      #      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     | 400        |
      #      | Email_Basic_Negitive_with_2_different_multiple_email_input     | 400        |
      #      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     | 400        |

      | Email_Basic_Negitive_NoPrefix_with@_withDomainName(@gmail.com)_domainType_invalid_email | 200        |
      | Email_Basic_Negitive_withPrefix_with@_NoDomainName(abc@)_domainType_invalid_domain      | 200        |
      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)_domainType_invalid_email     | 200        |
      | Email_Basic_Negitive_with_2_different_multiple_email_input_domainType_invalid_domain    | 200        |

  Scenario Outline: DPI EMAIL_BASIC Negitive scenario with null/empty input :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
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
    * match  $.data ==  null
    * match  $.meta contains  payload.response.meta
    * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
    * match  $.errors contains only deep  payload.response.errors

    Examples:
      | Scenario                                | statusCode |
      | Email_Basic_Negitive_Emptyinput('')     | 400        |
      | Email_Basic_Negitive_Nullinput(' ')     | 400        |
      | Email_Basic_Negitive_Nullinput(null)    | 400        |
      | Email_Basic_Negitive_No_input_Email_key | 400        |

  Scenario Outline: DPI EMAIL_BASIC positive scenario - Schema validation of data points  :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
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

    And match $.data.email.social == '#null'
    And match $.data.email.basic == '#notnull'
    And match $.data.email.basic == '#object'
    And match $.data.email.basic contains deep {"deliverable": '#present',"emailTenure": '#present'}
    And match $.data.email.basic.domainDetails contains deep {"domainName":"#present","tld":"#present","creationTime":"#present","updateTime":"#present","expiryTime":"#present","registered":"#present","companyName":"#present","disposable":"#present","freeProvider":"#present","dmarcCompliance":"#present","spfStrict":"#present","suspiciousTld":"#present","websiteExists":"#present","acceptAll":"#present","custom":"#present"}
    And match $.data.email.basic.breach contains deep {"isBreached":"#present","noOfBreaches":"#present","firstBreach":"#present","lastBreach":"#present","breaches":[{"platformName":"#present","domainName":"#present","breachDate":"#present"}]}
    And match $.data contains deep {"address":"#null","name":"#null","ip":"#null","identity":"#null","upi":"#null","device":"#null","employment":"#null","income":"#null","blacklist":"#null","bre":"#null"}
    And match $.meta contains deep {"referenceId":"#present","inputEmail":"#present","requestedPackages":["EMAIL_BASIC"]}
    And match $.errors == []

    Examples:
      | Scenario                              | statusCode |
      | Email_Basic_FIDO_V2_Schema_validation | 200        |

  #  @Schema_validation_2
  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Schema validation of data points  :- <Scenario>
    Given url requestUrl
    And def payload = read( "../" + source + "/EMAIL_BASIC_FIDO/<Scenario>.json")
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
    Then match $ contains deep

      """
      {
        "data": {
          "phone": null,
          "email": {
            "social": null,
            "basic": {
              "deliverable": '#present',
              "domainDetails": {
                "domainName": '#present',
                "tld": '#present',
                "creationTime": '#present',
                "updateTime": '#present',
                "expiryTime": '#present',
                "registered": '#present',
                "companyName": '#present',
                "disposable": '#present',
                "freeProvider": '#present',
                "dmarcCompliance": '#present',
                "spfStrict": '#present',
                "suspiciousTld": '#present',
                "websiteExists": '#present',
                "acceptAll": '#present',
                "custom": '#present'
              },
              "breach": {
                "isBreached": '#present',
                "noOfBreaches": '#present',
                "firstBreach": '#present',
                "lastBreach": '#present',
                "breaches": [
                  {
                    "platformName": '#present',
                    "domainName": '#present',
                    "breachDate": '#present'
                  }
                ]
              },
              "emailTenure": '#present'
            }
          },
          "address": '#null',
          "name": '#null',
          "ip": '#null',
          "identity": '#null',
          "upi": '#null',
          "device": '#null',
          "employment": '#null',
          "income": '#null',
          "blacklist": '#null',
          "bre": '#null'
        },
        "meta": {
          "referenceId": '#present',
          "inputEmail": '#present',
          "requestedPackages": [
            "EMAIL_BASIC"
          ]
        },
        "errors": []
      }
      """

    Examples:
      | Scenario                              | statusCode |
      | Email_Basic_FIDO_V2_Schema_validation | 200        |

