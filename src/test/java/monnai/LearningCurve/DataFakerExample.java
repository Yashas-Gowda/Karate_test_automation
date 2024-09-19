package monnai.LearningCurve;

import net.datafaker.Faker;

public class DataFakerExample {
    public static void main(String[] args) {
        Faker faker = new Faker();
        System.out.println(faker.number().digits(10));
        System.out.println(faker.address());
        System.out.println(faker.name().fullName());

//        faker.number().digits(5);
//        faker.address();


    }
}
