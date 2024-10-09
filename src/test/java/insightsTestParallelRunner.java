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

public class insightsTestParallelRunner {

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "demo");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

    @Test
    void auth_Token() {
        Results results = Runner.path("classpath:monnai")
                .outputCucumberJson(true)
                .tags("@auth_Token")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

//    @Test
//    void testParallel() {
//        /*Results results = Runner.path("classpath:monnai").outputCucumberJson(true)
//                .tags("@demonov103pm")
//                .parallel(5); */
//
//        Results results = Runner.path("classpath:monnai")
//                .outputCucumberJson(true)
////                .tags("@ported_prod_sanity,@upi_prod_sanity")
////                .tags("@FidoV1")
////                .tags("~@ignore")
//                .tags("@FIDO_EMAIL_BASIC")
//                .parallel(5);
//        generateReport(results.getReportDir());
//        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
//    }
//

//    @Test
//    void dex() {
//        Results results = Runner.path("/Users/yashas/IdeaProjects/test-automation/src/test/java/monnai.DEX")
//                .outputCucumberJson(true)
//                .tags("@fido_email_basic")
//                .parallel(5);
//        generateReport(results.getReportDir());
//        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
//    }
//
//    @Test
//    void _userManagement() {
//        Results results = Runner.path("/Users/yashas/IdeaProjects/test-automation/src/test/java/_userManagement").outputCucumberJson(true)
//                .tags("@fido_email_basic")
//                .parallel(5);
//        generateReport(results.getReportDir());
//        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
//    }

    @Test
    void deployment() {
        Results results = Runner.path("classpath:monnai").outputCucumberJson(true)
                .tags("@SMOKE_UPI_BASIC, @Mutliple_package_negative_scenarios")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void mockDex() {
        Results results = Runner.path("classpath:monnai").outputCucumberJson(true)
                .tags("@data_partner_res_phone_social")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void single() {
        Results results = Runner.path("classpath:monnai/MAIN/insights/feature_files").outputCucumberJson(true)
                //.tags("@EMAIL_BASIC_FIDO, @Mutliple_package_negative_scenarios")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }
}