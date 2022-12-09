package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.model.Detail;
import com.shermatov.laborcostservice.repository.DetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DetailsRepositoryImpl implements DetailsRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Detail> findAll() {
        return jdbcTemplate.query("SELECT * FROM details",
                BeanPropertyRowMapper.newInstance(Detail.class));
    }

    @Override
    public Detail findById(Integer detailId) {
        return jdbcTemplate.queryForObject("SELECT * FROM details WHERE detail_id=?",
                BeanPropertyRowMapper.newInstance(Detail.class), detailId);
    }

    @Override
    public int save(Detail detail) {
        return jdbcTemplate.update("INSERT INTO details (\"TYPE\", name, measure_unit, price) VALUES(?,?,?,?)",
                detail.getType().toString(),
                detail.getName(),
                detail.getMeasureUnit(),
                detail.getPrice());
    }

    @Override
    public int update(Integer detailId, Detail detail) {
        return jdbcTemplate.update("UPDATE details SET type=?, name=?, measure_unit=?, price=? WHERE detail_id=?",
                detail.getType().toString(),
                detail.getName(),
                detail.getMeasureUnit(),
                detail.getPrice(),
                detailId);
    }

    @Override
    public int deleteById(Integer detailId) {
        return jdbcTemplate.update("DELETE FROM details WHERE detail_id=?",
                detailId);
    }

    @Override
    public Integer mostExpensiveDetail() {
        return jdbcTemplate.queryForObject("SELECT furniture_details.most_expensive_detail() FROM dual",
                Integer.class);
    }
}
