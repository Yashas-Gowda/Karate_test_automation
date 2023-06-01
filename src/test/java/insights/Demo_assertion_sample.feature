Feature:Demo practise assertion - https://priyankab85.medium.com/cheat-sheet-for-karate-assertions-and-matching-d248383546e0  | match-contains shortcuts - https://github.com/karatelabs/karate#contains-short-cuts

  Scenario: p1
    Given url "https://reqres.in/api/users/2"
    When method get
    Then status 200
    * assert response.data.id == 2
    * assert response.data.first_name == 'Janet'
    * print response

    * def name = response.data.first_name
    * def surname = response.data.last_name
    * assert name + surname == 'JanetWeaver'

    * def name = response.data.first_name
    * def id = response.data.id
    * assert name + id == 'Janet2'

  Scenario: p2 Dynamically add numeric values and assert with expected value.
    Given url "https://reqres.in/api/users?page=2"
    When method get
    Then status 200
    * print response
    * def perPage = response.per_page
    * def totalPages = response.total_pages
    * print perPage, totalPages
    * print perPage + totalPages
# 6 + 2 = 8
    * assert perPage + totalPages == 8

  Scenario: p3 - Fuzzy Matching: is designed to match complicated JSON or XML payloads dynamically.
    Given url "https://reqres.in/api/users?page=2"
    When method get
    Then status 200
    * print response
    * string textResponse = response
    * print textResponse

#    * match response.page == '#number'
#    * def page = 2
#    * match response.page == '#(page)'

    * match response == {page:'#number',per_page:'#notnull', total:'#present', total_pages: '#ignore', data:'#array', support: '##object'}

#  .+ - is used to escape string
#  ^ - start of string
#  [0-9]* - 0+ digits
#  [.]? - an optional period
#  [0-9]{2} - two digits
#  $ - end of string
    * match response.data[*] contains {id:'#number? _ > 0', email:'#regex .+@reqres.in', first_name:'#string', last_name:'#string', avatar: '#string'}


  Scenario: p4 - Technique 3 — Match: is often used to address complex assertion requirements for JSON and XML response payloads.
    Given url "https://reqres.in/api/users?page=2"
    When method get
    Then status 200
    * print response

# 1. Absolute match by using "==" to strictly existence of check all keys
    * def page = 2
    * match response.page == '#(page)'

# 2. contains: match existence of some keys
    * match response contains {per_page:'#notnull', total_pages: '#ignore', data:'#array', support: '##object'}

# 3. !contains: assert that specified key does not exists
    * def available_ids = karate.jsonPath(response,"$..['id']")
    * print available_ids
    * match available_ids !contains [2]

# 4. contains only: assert that all array elements are present but in any order
    * match available_ids contains only [10,9,7,8,12,11]

# 5. contains any: assert any of the given array elements are present
    * match available_ids contains any [10,9,7,8]

# 6. match each: Iterate over all elements in a JSON array using the each modifier
    * match each response.data[*] == {id:'#number? _ > 0', email:'#regex .+@reqres.in', first_name:'#string', last_name:'#string', avatar: '#string'}

# 7. contains deep: is an alternative of "match contains" as it supports matching of nested nested lists or objects i.e. match some values in the various "trees" of data
    * def nested_data = karate.jsonPath(response,"$..['id','first_name']")
    * print nested_data
    * match response.data contains deep
"""
[
{ "id": 7,
"first_name": "Michael"
},
{
"id": 8,
"first_name": "Lindsay"
},
{
"id": 9
}
]
"""

#  Symbol	Means
#  ^	contains
#  ^^	contains only
#  ^*	contains any
#  ^+	contains deep
#  !^	not contains


