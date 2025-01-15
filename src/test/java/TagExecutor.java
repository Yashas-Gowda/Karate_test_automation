import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class TagExecutor {

    @Test
    void auth_Token() {
        Results results = Runner.path("classpath:monnai/Auth_Token_Generation.feature")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void PHONE_PACKAGES() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .tags("@PHONE_PACKAGES","~@ignore" )
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void EMAIL_PACKAGES() {
        Results results = Runner.path("classpath:monnai/MAIN/insights")
                .tags("@EMAIL_PACKAGES","~@ignore" )
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void EMPLOYMENT_DOMAIN_PACKAGES() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .tags("@regTest_3","~@ignore" )
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void UPI_INCOME_KYC_ADDRESS_VERIFICATION_PACKAGES() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .tags("@regTest_4","~@ignore" )
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void IP_DEVICE_ADDRESS_BASIC_PACKAGES() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .tags("@regTest_5","~@ignore" )
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void demo1() {
        Results results = Runner.path("classpath:monnai/MAIN/verification")
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