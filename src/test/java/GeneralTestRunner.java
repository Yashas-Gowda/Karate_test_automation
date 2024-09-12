import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class GeneralTestRunner {

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "test-automation");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

    @Test
    void auth_Token() {
        Results results = Runner.path("classpath:monnai/Auth_Token_Generation.feature")
                .outputCucumberJson(true)
//                .tags("@auth_Token")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void custom_auth_Token() {
        Results results = Runner.path("classpath:monnai/Auth_Token_Generation_parallel.feature")
                .outputCucumberJson(true)
//                .tags("@auth_Token")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .outputCucumberJson(true)
                .tags("~@ignore")
                .karateEnv("MONNAI_API_Automation")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }


    @Test
    void _dpi_gen_call() {
        Results results = Runner.path("classpath:monnai/DPI/DPI_general_call")
                .outputCucumberJson(true)
                .tags("@gen_insights")
//                .tags("@gen_verification")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void _userManagement() {
        Results results = Runner.path("classpath:monnai/UserManagement")
                .outputCucumberJson(true)
                .tags("@fido_email_basic")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void DEX() {
        Results results = Runner.path("classpath:monnai/DPI/DataExchange_DEX")
                .outputCucumberJson(true)
                .tags("@custom_dex_call")
//                .tags("@fido_email_basic")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void DPI_Partner_registry() {
        Results results = Runner.path("classpath:monnai/DPI/DataPartnerRegistry_DPR")
                .outputCucumberJson(true)
                .tags("@Filter_Partner")
//                .tags("@Get_Tenant_config")
//                .tags("@Update_Tenant_config")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void mockDex() {
        Results results = Runner.path("classpath:monnai")
                .outputCucumberJson(true)
                .tags("@data_partner_res_phone_social")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void Inside_Insights() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .outputCucumberJson(true)
                .tags("@get_tenant_config_before_update")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void EMAIL_BASIC_CUSTOM() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .outputCucumberJson(true)
                .tags("@EMAIL_BASIC_FIDO_PARALLEL")
                .parallel(1);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void Test_tag1() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .outputCucumberJson(true)
                .tags("@KYC_GOVERNMENT,KYC_MOBILE")
                .parallel(1);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void Test_tag2() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .outputCucumberJson(true)
                .tags("@EMAIL_BASIC_CUSTOM_PARALLEL,@EMAIL_BASIC_FIDO")
                .parallel(1);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void EMAIL_BASIC_COMBINE() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .outputCucumberJson(true)
                .tags("@EMAIL_BASIC_FIDO,@EMAIL_BASIC_CUSTOM")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void Inside_Monnai() {
        Results results = Runner.path("classpath:monnai/MAIN")
                .outputCucumberJson(true)
//                .tags("@EMAIL_BASIC_FIDO,@EMAIL_SOCIAL_FIDOV2,@PHONE_SOCIAL_FIDOV2")
                .tags("@EMAIL_SOCIAL_FIDOV1,@PHONE_SOCIAL_FidoV1")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }
}