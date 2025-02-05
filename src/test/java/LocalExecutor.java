import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class LocalExecutor {

    @Test
    void auth_Token() {
        Results results = Runner.path("classpath:monnai/Auth_Token_Generation.feature")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void regTest_1() {
        Results results = Runner.path("classpath:monnai/MAIN/insights")
                .tags("@EMAIL_BASIC_CUSTOM_PARALLEL")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void regTest_2() {
        Results results = Runner.path("classpath:monnai/MAIN/insights")
                .tags("@delete_jan_14")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }


    @Test
    void testVerification_demo1() {
        Results results = Runner.path("classpath:monnai/MAIN/verification")
                .tags("~@ignore")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }


    @Test
    void testInsightsVerification_demo1() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .tags("~@ignore")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

//23 - 9 -2024	Annotation
//Phone Feature files 	                        regTest_1, PHONE_PACKAGES	@PHONE_BASIC_FULL --> @PHONE_BASIC,
//Email feature files	                        regTest_2, EMAIL_PACKAGES
//(Employment feature files + Domain Breach)	regTest_3, EMPLOYMENT_PACKAGES , DOMAIN_BREACH
//Income + KYC + UPI + Address Verfifcation 	regTest_4, INCOME, KYC , UPI, ADDRESS VERIFICATION
//IP basic + Device details + Address basic 	regTest_5, IP_BASIC, DEVICE_DETAILS, ADDRESS_BASIC