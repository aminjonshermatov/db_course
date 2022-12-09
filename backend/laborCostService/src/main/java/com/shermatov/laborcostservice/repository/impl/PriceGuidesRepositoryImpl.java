package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.model.PriceGuide;
import com.shermatov.laborcostservice.repository.PriceGuidesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PriceGuidesRepositoryImpl implements PriceGuidesRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<PriceGuide> findAll() {
        return jdbcTemplate.query("SELECT * FROM price_guide",
                BeanPropertyRowMapper.newInstance(PriceGuide.class));
    }

    @Override
    public PriceGuide findById(Integer priceGuideId) {
        return jdbcTemplate.queryForObject("SELECT * FROM price_guide WHERE price_guide_id=?",
                BeanPropertyRowMapper.newInstance(PriceGuide.class), priceGuideId);
    }

    @Override
    public int save(PriceGuide priceGuide) {
        System.out.println(priceGuide);
        return jdbcTemplate.update("INSERT INTO price_guide (hourly_rate) VALUES(?)",
                priceGuide.getHourlyRate());
    }

    @Override
    public int update(Integer priceGuideId, PriceGuide priceGuide) {
        return jdbcTemplate.update("UPDATE price_guide SET hourly_rate=? WHERE price_guide_id=?",
                priceGuide.getHourlyRate(),
                priceGuideId);
    }

    @Override
    public int deleteById(Integer priceGuideId) {
        return jdbcTemplate.update("DELETE FROM price_guide WHERE price_guide_id=?",
                priceGuideId);
    }
}
