package insights;

import com.intuit.karate.junit5.Karate;

@SuppressWarnings("java:S5960")
public class InsightsTest {
  @Karate.Test
  Karate testSample() {
    return Karate.run("classpath:insights/UPI_ADVANCED.feature").tags("test").relativeTo(getClass());
  }

  @Karate.Test
  Karate smokeTest(){
    return Karate.run("classpath:insights").tags("@smokeTest").relativeTo(getClass());
  }

  @Karate.Test
  Karate testTags() {
    return Karate.run("classpath:insights").tags("@topUpHistory").relativeTo(getClass());
  }

  @Karate.Test
  Karate testSystemProperty() {
    return Karate.run("classpath:insights")
            .tags("@topUpHistory")
            .outputCucumberJson(true)
            .karateEnv("dev");
//            .systemProperty("foo", "bar");
  }
}
