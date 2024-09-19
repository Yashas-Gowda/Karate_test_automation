@genrate_random
Feature: Generate random data using Java faker library

  @genrate_random_1
  Scenario: Create simple JSON Object - Data Faker
    * def dataFaker = Java.type("net.datafaker.Faker")
    * def dataFakerObject = new dataFaker()
    * def idValue = dataFakerObject.number().digits(5)
    * def nameValue = dataFakerObject.name().fullName()
    * set jsonObjectPayload
      | path | value                              |
      | id   | dataFakerObject.number().digits(5) |
      | name | dataFakerObject.name().fullName()  |
    * print jsonObjectPayload
    * karate.set("daata", jsonObjectPayload)
    * print karate.get("daata")

  Scenario: Create simple JSON Object - Data Faker - WIth custom class
    * def dataFaker = Java.type("monnai.LearningCurve.RandomDataGenerator")
    * def idValue = dataFaker.getRandomInteger(6)
    * def abc = "dsfds"
    * def nameValue = dataFaker.getRandomFullName(abc)
    * set jsonObjectPayload
      | path | value     |
      | id   | idValue   |
      | name | nameValue |
    * print jsonObjectPayload
    * print karate.get("daata")