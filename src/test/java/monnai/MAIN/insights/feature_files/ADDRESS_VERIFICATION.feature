  #@ignore
  @ADDRESS_VERIFICATION

  Feature:Testing of DPI - ADDRESS_VERIFICATION feature scenarios

    Background:
      * configure charset = null
      * path '/api/insights/'
      * def authFeature = call read('classpath:monnai/Auth_Token_Generation.feature')
      * def BearerToken = authFeature.authToken

    @ADDRESS_VERIFICATION_IN
    Scenario Outline: Validate DPI ADDRESS_VERIFICATION positive scenarios for Country india -> <Scenario>
      Given url requestUrl
      And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/IN/<Scenario>.json")
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
      * set payload.response.data.address.verification.addressLastVisited = "#ignore"
      Then match $.data.address.verification contains payload.response.data.address.verification
      * match $.data.address.verification.addressLastVisited == "##regex\\d{4}-\\d{2}-\\d{2}"

      Then match $.meta contains payload.response.meta
      Then match $.errors contains only payload.response.errors

      Examples:
        | Scenario                                                                                                                                                                                   | statusCode |
        #    case 1
        | ADDRESS_VERIFICATION_IN_positive_request_phone_address_response_phoneMatch_addressMatch_phoneAndAddressMatch_MATCH_addressVisited_true_with_addressLastVisited                             | 200        |
        | ADDRESS_VERIFICATION_IN_positive_request_phone_address_without_optional_datapoints_response_phoneMatch_addressMatch_phoneAndAddressMatch_MATCH_addressVisited_true_with_addressLastVisited | 200        |
        | ADDRESS_VERIFICATION_IN_positive_request_phone_address_response_phoneMatch_MATCH_addressMatch_phoneAndAddressMatch_NO_MATCH_addressVisited_false_without_addressLastVisited                | 200        |
        | ADDRESS_VERIFICATION_IN_positive_request_phone_address_response_phoneMatch_phoneAndAddressMatch_NO_MATCH_addressMatch_MATCH_addressVisited_true_with_addressLastVisited                    | 200        |
        #  Response from partner changed      | ADDRESS_VERIFICATION_IN_positive_request_phone_address_response_addressMatch_phoneAndAddressMatch_NO_MATCH_phoneMatch_MATCH_addressVisited_true_with_addressLastVisited                    | 200        |
        #      https://monnai.atlassian.net/browse/MB-6651
        | ADDRESS_VERIFICATION_IN_positive_request_phone_address_response_only_addressVisited_false                                                                                                  | 200        |

        #    case 2
        | ADDRESS_VERIFICATION_IN_positive_request_only_address_response_only_addressVisited_true_with_addressLastVisited                                                                            | 200        |
        | ADDRESS_VERIFICATION_IN_positive_request_only_address_without_optional_datapoints_response_only_addressVisited_true_with_addressLastVisited                                                | 200        |
        | ADDRESS_VERIFICATION_IN_positive_request_only__address_response_only_addressVisited_false                                                                                                  | 200        |



    @ADDRESS_VERIFICATION_IN @Negative
    Scenario Outline: Validate DPI ADDRESS_VERIFICATION Negative scenarios for Country india -> <Scenario>
      Given url requestUrl
      And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/IN/Negative/<Scenario>.json")
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
      Then match $.data == null
      Then match $.meta contains payload.response.meta
      * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
      Then match $.errors contains only payload.response.errors


      Examples:
        | Scenario                                                                                              | statusCode |
        #    https://monnai.atlassian.net/browse/MB-6655
        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_country_with_empty_string              | 400        |
        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_country_with_space                     | 400        |
        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_country_with_null                      | 400        |

        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_addressLine1_with_empty_string         | 400        |
        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_addressLine1_with_space                | 400        |
        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_addressLine1_with_null                 | 400        |

        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_country_addressLine1_with_empty_string | 400        |
        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_country_addressLine1_with_space        | 400        |
        | ADDRESS_VERIFICATION_IN_Negative_request_where_mandatory_input_country_addressLine1_with_null         | 400        |

    @ADDRESS_VERIFICATION_ID
    Scenario Outline: Validate DPI ADDRESS_VERIFICATION positive scenarios for Country india -> <Scenario>
      Given url requestUrl
      And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/ID/<Scenario>.json")
      And headers headers
      And headers headers
      And header Authorization = BearerToken
      And request payload.request
      * set payload.response.meta.referenceId = "#ignore"
      * set payload.response.data.address.verification.packageDetails = "#ignore"
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
      #      * set payload.response.data.address.verification.closestDistance.min = "#ignore"
      * match $.data.address.verification.closestDistance.min == "#number"
      * match $.data.address.verification.closestDistance.max == "#number"
      * match $.data.address.verification contains {"locationConfidence": "#string","cellTowerDensity": "#string","cellTowerRanking": "#number","locationType": "#string"}
      # Data is highly dynamic which is changing daily so asserted genrally
      #      Then match $.data.address.verification contains payload.response.data.address.verification
      Then match $.meta contains payload.response.meta
      Then match $.errors contains only payload.response.errors

      Examples:
        | Scenario                                                                                                                                                                                               | statusCode |
        #  Use Case 1 - Phone + Location Coordinates input (Live)
        | ADDRESS_VERIFICATION_ID_positive_INDOSAT_request_phoneNumber_locationCoordinates_response_closestDistance_locationConfidence_Medium_cellTowerDensity_VeryHigh_cellTowerRanking_3_locationType_NIGHT    | 200        |
        | ADDRESS_VERIFICATION_ID_positive_INDOSAT_request_phoneNumber_locationCoordinates_response_closestDistance_locationConfidence_High_cellTowerDensity_High_cellTowerRanking_2_locationType_NIGHT          | 200        |
        | ADDRESS_VERIFICATION_ID_positive_INDOSAT_request_phoneNumber_locationCoordinates_response_closestDistance_locationConfidence_VeryHigh_cellTowerDensity_Strongest_cellTowerRanking_1_locationType_NIGHT | 200        |
        | ADDRESS_VERIFICATION_ID_positive_INDOSAT_request_phoneNumber_locationCoordinates_response_closestDistance_locationConfidence_Low_cellTowerDensity_VeryHigh_cellTowerRanking_1_locationType_DAY         | 200        |

    # Srivatsa bug where data partner prime_analytics_one_api is called - DPI is giving S2101 along with response
    #        | ADDRESS_VERIFICATION_ID_positive_HUTCH_request_phoneNumber_locationCoordinates_response_closestDistance_locationConfidence_Medium_cellTowerDensity_Strongest_cellTowerRanking_2_locationType_NIGHT     | 200        |
    #        | ADDRESS_VERIFICATION_ID_positive_TELKOMSEL_request_phoneNumber_locationCoordinates_response_closestDistance_locationConfidence_Medium_cellTowerDensity_Strongest_cellTowerRanking_2_locationType_NIGHT | 200        |
    #        | ADDRESS_VERIFICATION_ID_positive_XL_request_phoneNumber_locationCoordinates_response_closestDistance_locationConfidence_Medium_cellTowerDensity_Strongest_cellTowerRanking_2_locationType_NIGHT        | 200        |

    @ADDRESS_VERIFICATION_ID
    Scenario Outline: Validate DPI ADDRESS_VERIFICATION positive scenarios for Country india -> <Scenario>
      Given url requestUrl
      And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/ID/<Scenario>.json")
      And headers headers
      And headers headers
      And header Authorization = BearerToken
      And request payload.request
      * set payload.response.meta.referenceId = "#ignore"
      #      * set payload.response.data.address.verification.packageDetails = "#ignore"
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
      #      * set payload.response.data.address.verification.closestDistance.min = "#ignore"
      #      * match $.data.address.verification.closestDistance.min == "#number"
      #      * match $.data.address.verification.closestDistance.max == "#number"
      #      * match $.data.address.verification contains {"locationConfidence": "#string","cellTowerDensity": "#string","cellTowerRanking": "#number","locationType": "#string"}

      Then match $.data.address.verification contains payload.response.data.address.verification
      Then match $.meta contains payload.response.meta
      Then match $.errors contains only payload.response.errors

      Examples:
        | Scenario                                                                                                                                   | statusCode |
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_locationCoordinates_response_packageDetails_S2101_data_partner_Location_not_available | 200        |


    @ADDRESS_VERIFICATION_ID
    Scenario Outline: Validate DPI ADDRESS_VERIFICATION positive scenarios for Country india -> <Scenario>
      Given url requestUrl
      And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/ID/<Scenario>.json")
      And headers headers
      And headers headers
      And header Authorization = BearerToken
      And request payload.request
      * set payload.response.meta.referenceId = "#ignore"
      * set payload.response.data.address.verification.packageDetails = "#ignore"
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
      #      * set payload.response.data.address.verification.closestDistance.min = "#ignore"
      * match $.data.address.verification.closestDistance.min == "#number"
      * match $.data.address.verification.closestDistance.max == "#number"
      #      * match $.data.address.verification contains {"locationConfidence": "#string","cellTowerDensity": "#string","cellTowerRanking": "#number","locationType": "#string"}

      Then match $.data.address.verification contains payload.response.data.address.verification
      Then match $.meta contains payload.response.meta
      Then match $.errors contains only payload.response.errors

      Examples:
        | Scenario                                                                                        | statusCode |
        # Use Case 2 - Phone + Address input (Planned)
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_address_response_closestDistance_0_250     | 200        |
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_address_response_closestDistance_251_500   | 200        |
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_address_response_closestDistance_501_750   | 200        |
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_address_response_closestDistance_751_1000  | 200        |
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_address_response_closestDistance_1001_2000 | 200        |
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_address_response_closestDistance_2001_4000 | 200        |

    @ADDRESS_VERIFICATION_ID
    Scenario Outline: Validate DPI ADDRESS_VERIFICATION positive scenarios for Country india -> <Scenario>
      Given url requestUrl
      And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/ID/<Scenario>.json")
      And headers headers
      And headers headers
      And header Authorization = BearerToken
      And request payload.request
      * set payload.response.meta.referenceId = "#ignore"
      * set payload.response.data.address.verification.packageDetails = "#ignore"
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
      #      * set payload.response.data.address.verification.closestDistance.min = "#ignore"
      #      * match $.data.address.verification.closestDistance.min == "#number"
      #      * match $.data.address.verification.closestDistance.max == "#number"
      #      * match $.data.address.verification contains {"locationConfidence": "#string","cellTowerDensity": "#string","cellTowerRanking": "#number","locationType": "#string"}
      Then match $.data.address.verification contains payload.response.data.address.verification
      Then match $.meta contains payload.response.meta
      Then match $.errors contains only payload.response.errors

      Examples:
        | Scenario                                                                                                                 | statusCode |
        #     https://monnai.atlassian.net/browse/MB-6658
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_address_response_packageDetails_S2101_when_dp_closest_distance_null | 200        |

    @ADDRESS_VERIFICATION_ID
    Scenario Outline: Validate DPI ADDRESS_VERIFICATION positive scenarios for Country india -> <Scenario>
      Given url requestUrl
      And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/ID/<Scenario>.json")
      And headers headers
      And headers headers
      And header Authorization = BearerToken
      And request payload.request
      * set payload.response.meta.referenceId = "#ignore"
      #      * set payload.response.data.address.verification.packageDetails = "#ignore"
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
      #      * set payload.response.data.address.verification.closestDistance.min = "#ignore"
      #      * match $.data.address.verification.closestDistance.min == "#number"
      #      * match $.data.address.verification.closestDistance.max == "#number"
      #      * match $.data.address.verification contains {"locationConfidence": "#string","cellTowerDensity": "#string","cellTowerRanking": "#number","locationType": "#string"}

      Then match $.data.address.verification contains payload.response.data.address.verification
      Then match $.meta contains payload.response.meta
      Then match $.errors contains only payload.response.errors

      Examples:
        | Scenario                                                                                        | statusCode |
        | ADDRESS_VERIFICATION_ID_positive_request_phoneNumber_address_response_closestDistance_4001_null | 200        |


    @ADDRESS_VERIFICATION_ID @Negative
    Scenario Outline: Validate DPI ADDRESS_VERIFICATION Negative scenarios for Country india -> <Scenario>
      Given url requestUrl
      And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/ID/Negative/<Scenario>.json")
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
      Then match $.data == null
      Then match $.meta contains payload.response.meta
      * match  $.meta.requestedPackages[0] contains  payload.response.meta.requestedPackages[0]
      Then match $.errors contains only payload.response.errors


      Examples:
        | Scenario                                                                                                         | statusCode |
        #    https://monnai.atlassian.net/browse/MB-6655
        #  https://monnai.atlassian.net/browse/MB-6732
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_country_with_empty_string                         | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_country_with_space                                | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_country_with_null                                 | 400        |

        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_addressLine1_with_empty_string                    | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_addressLine1_with_space                           | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_addressLine1_with_null                            | 400        |

        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_country_addressLine1_with_empty_string            | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_country_addressLine1_with_space                   | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_country_addressLine1_with_null                    | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_country_addressLine1_missing                      | 400        |


        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phoneNumber_with_empty_string                     | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phoneNumber_with_space                            | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phoneNumber_with_null                             | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phoneNumber_missing                               | 400        |

        #      https://monnai.atlassian.net/browse/MB-6651
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phoneNumber_with_invalid_phonenumber              | 400        |

        #      https://monnai.atlassian.net/browse/MB-6659
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_locationCoordinates_with_empty_string             | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_locationCoordinates_with_space                    | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_locationCoordinates_with_null                     | 400        |

        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phonenumber_locationCoordinates_with_empty_string | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phonenumber_locationCoordinates_with_space        | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phonenumber_locationCoordinates_with_null         | 400        |


        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_locationCoordinates_missing                       | 400        |
        | ADDRESS_VERIFICATION_ID_Negative_request_where_mandatory_input_phonenumber_locationCoordinates_missing           | 400        |



    # For mock used this  'Content-Type' ---->  * header Content-Type = 'application/vnd.monnai.mock+json'
    #    Adding test cases using mock for this package is paused as there is issue in adding mock for thie packaghe which will fixed by aman later in up comming sprint
    #  @ADDRESS_VERIFICATION_IN @ADDRESS_VERIFICATION_moc
    #  Scenario Outline: Validate DPI ADDRESS_VERIFICATION positive scenarios for Country india with Mock <Scenario>
    #    Given url requestUrl
    #    And def payload = read( "../" + source + "/ADDRESS_VERIFICATION/IN/<Scenario>.json")
    #    And headers headers
    #    * header Content-Type = 'application/vnd.monnai.mock+json'
    #    And header Authorization = BearerToken
    #    And request payload.request
    #    * set payload.response.meta.referenceId = "#ignore"
    #    When method POST
    #    # cloud watch traces -start
    #    * print karate.request.headers
    #    * print karate.response.headers
    #    * print 'x-reference-id----->',karate.request.headers['x-reference-id']
    #    * def reference_id = karate.request.headers['x-reference-id']
    #    * def Cloud_Watch_Traces = "https://ap-southeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-southeast-1#xray:traces/query?~(query~(expression~'Annotation.x_reference_id*20*3d*20*22" + reference_id + "*22)~context~(timeRange~(delta~21600000)))"
    #    * print 'Cloudwatch_dpi Traces----->',Cloud_Watch_Traces
    #    # ResponseTime
    #    * print 'responseTime----->',responseTime
    #    # Request-response
    #    * print 'API Request----->',payload.request
    #    * print 'Expected Response---->',payload.response
    #    * print 'Actual Response---->',karate.pretty(response)
    #    Then status <statusCode>
    #    Then match payload.response.data.address.verification contains $.data.address.verification
    #    Then match $.meta contains payload.response.meta
    #    Then match $.errors contains payload.response.errors
    #
    #    Examples:
    #      | Scenario                                                                                                                                                       | statusCode |
    #      #    case 1
    ##      | ADDRESS_VERIFICATION_IN_positive_request_phone_address_response_phoneMatch_addressMatch_phoneAndAddressMatch_MATCH_addressVisited_true_with_addressLastVisited | 200        |






