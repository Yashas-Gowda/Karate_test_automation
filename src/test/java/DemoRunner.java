import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class DemoRunner {

    @Test
    void auth_Token() throws InterruptedException {
        Results results = Runner.path("classpath:monnai/Auth_Token_Generation.feature")
//                .outputCucumberJson(true)
                .parallel(5);
        Thread.sleep(2000000);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:monnai/MAIN")
                //.outputCucumberJson(true)
                .tags("~@ignore")
                .karateEnv("test-fidoV2")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
