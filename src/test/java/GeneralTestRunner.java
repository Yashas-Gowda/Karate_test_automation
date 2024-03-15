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
        Results results = Runner.path("classpath:insights/Auth_Token_Generation.feature")
                .outputCucumberJson(true)
//                .tags("@auth_Token")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:insights")
                .outputCucumberJson(true)
                .tags("~@ignore")
                .karateEnv("MONNAI_API_Automation")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }


    @Test
    void _dpi_gen_call() {
        Results results = Runner.path("classpath:_dpi_gen_call")
                .outputCucumberJson(true)
                .tags("@gen_insights")
//                .tags("@gen_verification")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void _userManagement() {
        Results results = Runner.path("classpath:_userManagement")
                .outputCucumberJson(true)
                .tags("@fido_email_basic")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void DEX() {
        Results results = Runner.path("classpath:DEX")
                .outputCucumberJson(true)
                .tags("@custom_dex_call")
//                .tags("@fido_email_basic")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void DPI_Partner_registry() {
        Results results = Runner.path("classpath:DPI_Partner_registry")
                .outputCucumberJson(true)
                .tags("@Partner_Filter")
//                .tags("@Get_Tenant_config")
//                .tags("@Update_Tenant_config")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    @Test
    void Inside_Insights() {
        Results results = Runner.path("classpath:insights")
                .outputCucumberJson(true)
                .tags("@Mutliple_package_negative_scenarios")
                .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }
}