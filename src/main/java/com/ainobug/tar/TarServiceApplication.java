package com.ainobug.tar;

import me.libme.module.spring.mybatis.NoOpAnyExternalResourceConfig;
import me.libme.module.webboot.ApplicationBoot;
import me.libme.module.webboot.EnableCppWebAll;
import me.libme.module.webboot.fn.swagger.EnableCppSwagger2;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.AutoConfigurationExcludeFilter;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.TypeExcludeFilter;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.Import;


//

//
@EnableCppSwagger2
@EnableCppWebAll
@SpringBootApplication
@ComponentScan(excludeFilters = {
        @ComponentScan.Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
        @ComponentScan.Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) },
        basePackages={"me.libme","com.ainobug"}
)
@MapperScan({"com.ainobug.**.mapper"})
@Import({NoOpAnyExternalResourceConfig.class})
public class TarServiceApplication {

    private static final Logger LOGGER= LoggerFactory.getLogger(TarServiceApplication.class);

    public static void main(String[] args) throws Exception {

        ApplicationBoot.start(new Object[]{TarServiceApplication.class},args);

    }

}
