 @FidoV1  @ignore @seon_email
Feature: Testing of DPI  - EMAIL_BASIC feature scenarios
#@seon_email @ignore
  Background:
    * configure charset = null
    * path '/api/insights/'
    * def authFeature = call read('Auth_Token_Generation.feature')
    * def BearerToken = authFeature.authToken

  @second @smokeTest @smokeTest
  Scenario Outline:  DPI EMAIL_BASIC positive scenario - where emailTenure = notnull <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#number"
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
    * match $.data.email.basic.domainDetails.creationTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.updateTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.expiryTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    * print responseHeaders
    * print responseHeaders["Date"][0]
    * print responseHeaders["Content-Type"][0]
    * match header Content-Type == "application/json"
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    Examples:
      | Scenario                                                       | statusCode |
      | Email_Basic_Possitive_withTLDGmail(abc@gmail.com)              | 200        |
      | Email_Basic_Possitive_withDomainNet(abc@you.me.net)            | 200        |
      | Email_Basic_Possitive_withTLD&DomainOurearch(abc@ourearth.com) | 200        |
      | Email_Basic_Positive_With_BreachData                           | 200        |
      | Email_Basic_Positive_EmailTenure_Present_in_doubledigit        | 200        |
      | Email_Basic_emailTenure_in_decimal_value                       | 200        |
      | Email_Basic_emailTenure_in_single_digit_value                  | 200        |


    #rerun if deliverable is null
  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Imp scenarios for regression with emailTenure notnull  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#number"
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
    * match $.data.email.basic.domainDetails.creationTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.updateTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.expiryTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    Examples:
      | Scenario                                        | statusCode |
      | Email_Basic_isBreached_true_emailTenure_notnull | 200        |
      | Email_Basic_freeProvider_true                   | 200        |
      | Email_Basic_spfStrict_true_acceptAll_false      | 200        |
      | Email_Basic_deliverable_true                    | 200        |

  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Imp scenarios for regression with emailTenure null <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#null"
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
    * match $.data.email.basic.domainDetails.creationTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.updateTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.expiryTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    Then match $.data.email.basic contains payload.response.data.email.basic
    Examples:
      | Scenario                                      | statusCode |
      | Email_Basic_isBreached_false_emailTenure_null | 200        |
      | Email_Basic_freeProvider_false                | 200        |
      | Email_Basic_deliverable_false                 | 200        |
      | Email_Basic_disposable_true                   | 200        |
      | Email_Basic_suspiciousTld_true                | 200        |



  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Special cases <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#null"
    When method POST
    * match $.data.email.basic.domainDetails.creationTime == "#null";
    * match $.data.email.basic.domainDetails.updateTime == "#null";
    * match $.data.email.basic.domainDetails.expiryTime == "#null";
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
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
    Then match $.data.email.basic contains payload.response.data.email.basic
    Examples:
      | Scenario                                                                                                                                                                  | statusCode |
      | Email_Basic_creationTime_updateTime_expiryTime_companyName_acceptAll_null__registered_disposable_freeProvider_dmarcCompliance_spfStrict_suspiciousTld_websiteExists_false | 200        |

    # $.data.email.basic.domainDetails.acceptAll might come as null so rerun -sc48
  ## Check this
  @smokeTest
  Scenario Outline:  DPI EMAIL_BASIC positive scenario where emailTenure = null - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = null
    When method POST
    * match $.data.email.basic.domainDetails.creationTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.updateTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.expiryTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    * print payload.request
    * print payload.response
    * print karate.pretty(response)
    Then status <statusCode>
    Then match $.data.email.basic contains payload.response.data.email.basic
    Examples:
      | Scenario                               | statusCode |
      | Email_Basic_EmailDeliverable_False     | 200        |
      | Email_Basic_EmailTenureIs_NULL         | 200        |
      | Email_Basic_Positive_0_BreachData      | 200        |
      | Email_Basic_Positive_CustomDomain_True | 200        |

  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Imp scenarios for regression with creationTime is null <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
    And headers headers
    And header Authorization = BearerToken
    And request payload.request
    * set payload.response.meta.referenceId = "#ignore"
    * set payload.response.data.email.basic.emailTenure = "#null"
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
    * match $.data.email.basic.domainDetails.creationTime == "#null";
    * match $.data.email.basic.domainDetails.updateTime =="#null";
    * match $.data.email.basic.domainDetails.expiryTime == "#null";
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
    Then match $.data.email.basic contains payload.response.data.email.basic
    Examples:
      | Scenario                                      | statusCode |
      | Email_Basic_custom_true                       | 200        |


  Scenario Outline:  DPI EMAIL_BASIC Negative scenario with invalid input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
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
    Then match $ contains payload.response
#    And match $.errors[1].message == "Invalid email address"
#    And match $.response.errors[1].message == "Invalid email address"

    Examples:
      | Scenario                                                       | statusCode |
      | Email_Basic_Negitive_NoPrefix_with@_withDomainName(@gmail.com) | 400        |
      | Email_Basic_Negitive_withPrefix_with@_NoDomainName(abc@)       | 400        |
      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     | 400        |
      | Email_Basic_Negitive_with_2_different_multiple_email_input     | 400        |
      | Email_Basic_Negitive_Onlyprefix_without@_NoDomainName(abc)     | 400        |

  Scenario Outline: DPI EMAIL_BASIC Negative scenario with null/empty input - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
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
#    Then match $ contains payload.response
    And match $.errors[*].message contains any ["Email cannot be empty/null"]
    And match $.errors[*].code contains any ["MISSING_EMAIL_ADDRESS"]
    And match $.errors[*].package contains any ["EMAIL_BASIC"]
    Examples:
      | Scenario                                | statusCode |
      | Email_Basic_Negitive_Emptyinput('')     | 400        |
      | Email_Basic_Negitive_Nullinput(' ')     | 400        |
      | Email_Basic_Negitive_Nullinput(null)    | 400        |
      | Email_Basic_Negitive_No_input_Email_key | 400        |

  Scenario Outline:  DPI EMAIL_BASIC positive scenario - Imp scenarios for regression with emailTenure notnull  <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
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
    * match $.data.email.basic.domainDetails.creationTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.updateTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * match $.data.email.basic.domainDetails.expiryTime == "#regex\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}";
    * set payload.response.data.email.basic.domainDetails.creationTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.updateTime = "#ignore"
    * set payload.response.data.email.basic.domainDetails.expiryTime = "#ignore"
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
      | Scenario                                        | statusCode |
      | Email_Basic_isBreached_true_emailTenure_notnull | 200        |

  @Schema_validation_2
  Scenario Outline:  DPI PHONE_BASIC_Sub_topUpHistory Negative scenario for Indonesia region with validation of data-points in topUpHistory where no response is given by datapoint  - <Scenario>
    Given url requestUrl
    And def payload = read("data/" + source + "/EMAIL_BASIC/<Scenario>.json")
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
    * print responseHeaders
    * print responseHeaders["Date"][0]
    * print responseHeaders["Content-Type"][0]
    * match header Content-Type == "application/json"
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
					"breaches": "#array"
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
      | Email_Basic_SEON_V2_Schema_validation | 200        |

