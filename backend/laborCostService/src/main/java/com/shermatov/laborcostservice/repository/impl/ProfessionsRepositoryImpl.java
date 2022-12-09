package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.model.Profession;
import com.shermatov.laborcostservice.repository.ProfessionsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProfessionsRepositoryImpl implements ProfessionsRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Profession> findAll() {
        return jdbcTemplate.query("SELECT * FROM professions",
                BeanPropertyRowMapper.newInstance(Profession.class));
    }

    @Override
    public Profession findById(Integer professionId) {
        return jdbcTemplate.queryForObject("SELECT * FROM professions WHERE profession_id=?",
                BeanPropertyRowMapper.newInstance(Profession.class), professionId);
    }

    @Override
    public int save(Profession profession) {
        return jdbcTemplate.update("INSERT INTO professions (name) VALUES(?)",
                profession.getName());
    }

    @Override
    public int update(Integer professionId, Profession profession) {
        return jdbcTemplate.update("UPDATE professions SET name=? WHERE profession_id=?",
                profession.getName(),
                professionId);
    }

    @Override
    public int deleteById(Integer professionId) {
        return jdbcTemplate.update("DELETE FROM professions WHERE profession_id=?",
                professionId);
    }

}
