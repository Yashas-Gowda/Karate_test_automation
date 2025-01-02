import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class MonnaiTestRunner {

    @Test
    void auth_Token() {
        Results results = Runner.path("classpath:monnai/Auth_Token_Generation.feature")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void testInsights() {
        Results results = Runner.path("classpath:monnai/MAIN/insights")
                .tags("~@ignore")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }


    @Test
    void testVerification() {
        Results results = Runner.path("classpath:monnai/MAIN/verification")
                .tags("~@ignore")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void testInsightsVerification() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .tags("~@ignore")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
