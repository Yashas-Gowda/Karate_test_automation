package monnai.LearningCurve;

import net.datafaker.Faker;

public class DataFakerExample {
    public static void main(String[] args) {
        Faker faker = new Faker();
        System.out.println(faker.number().digits(10));
//        System.out.println(faker.address());
//        System.out.println(faker.name().fullName());
        String name = faker.name().fullName();
        System.out.println(name);
        String email_with_space = name.concat("@gmail.com");
        String email = email_with_space.replaceAll("\\s", "");
        System.out.println(email);
//        faker.number().digits(5);
//        faker.address();


    }
}
