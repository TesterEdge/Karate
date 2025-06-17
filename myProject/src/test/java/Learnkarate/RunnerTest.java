package Learnkarate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

// import java.io.File;
// import java.util.ArrayList;
// import java.util.Collection;
// import java.util.List;
// import org.apache.commons.io.FileUtils;
// import org.junit.jupiter.api.Test;

// import net.masterthought.cucumber.ReportBuilder;
// import net.masterthought.cucumber.Configuration;



public class RunnerTest {

    @Test
    
    void testParallel() {
            Results results = Runner.path("classpath:Learnkarate")
            .parallel(1);
            // generateReport(results.getReportDir());
            assertTrue(results.getFailCount() == 0, results.getErrorMessages());
        }
    
    
    // @Karate.Test
    // Karate testAll() {
    //     return Karate.run().relativeTo(getClass());
    // }
    // @Karate.Test
    // Karate testTags() {    
    //     return Karate.run().tags("@debug").relativeTo(getClass());
    // }
    // public static void generateReport(String karateOutputPath) {
    //     Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
    //     List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
    //     jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
    //     Configuration config = new Configuration(new File("target"), "Learnkarate");
    //     ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
    //     reportBuilder.generateReports();
    // }
    
}

