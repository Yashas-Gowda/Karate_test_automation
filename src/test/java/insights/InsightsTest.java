package insights;

//import com.intuit.karate.FileUtils;
import com.intuit.karate.Results;
import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class InsightsTest {
  @Karate.Test
  Karate testInsights() {
    return Karate.run("classpath:insights").relativeTo(getClass());
  }

  @Karate.Test
  Karate smokeTests() {
    return Karate.run("classpath:insights/IDENTITY_ENRICHMENT.feature").tags("@smokeTest").relativeTo(getClass());
  }

  @Karate.Test
  Karate testInsightsWithReport() {
    Karate karate = Karate.run("classpath:insights/IDENTITY_ENRICHMENT.feature").relativeTo(getClass()).outputCucumberJson(true);
    /*Results results = karate
            .outputCucumberJson(true)
            .tags("")
            .parallel(0);*/
    Results results = karate.parallel(0);
    generateReport(karate.parallel(0).getReportDir());
    assertEquals(Float.parseFloat(results.getErrorMessages()), 0, results.getFailCount());
    return karate;
  }

  public static void generateReport(String karateOutputPath) {
    Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
    List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
    jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
    Configuration config = new Configuration(new File("target"), "src/test/java");
    ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
    reportBuilder.generateReports();

  }

}