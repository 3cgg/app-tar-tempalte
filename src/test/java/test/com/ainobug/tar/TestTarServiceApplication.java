package test.com.ainobug.tar;

import me.libme.module.webboot.ApplicationBoot;
import me.libme.module.webboot.EnableCppWebAll;
import me.libme.module.webboot.fn.swagger.EnableCppSwagger2;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.AutoConfigurationExcludeFilter;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.TypeExcludeFilter;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;


//

//
@EnableCppSwagger2
@EnableCppWebAll
@SpringBootApplication
@ComponentScan(excludeFilters = {
        @ComponentScan.Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
        @ComponentScan.Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) },
        basePackages={"me.libme","com.ainobug","test.com.ainobug"}
)
public class TestTarServiceApplication {

    private static final Logger LOGGER= LoggerFactory.getLogger(TestTarServiceApplication.class);

    public static void main(String[] args) throws Exception {

        ApplicationBoot.start(new Object[]{TestTarServiceApplication.class},args);

    }

}
