package com.shermatov.laborcostservice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class DbSessionSetter implements ApplicationRunner {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        jdbcTemplate.execute("ALTER SESSION SET CURRENT_SCHEMA = AMINJON");
        //jdbcTemplate.execute("BEGIN SEED_DATA(); END;");
    }
}
