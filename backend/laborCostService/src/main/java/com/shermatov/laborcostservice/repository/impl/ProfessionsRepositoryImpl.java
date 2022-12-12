package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.model.Profession;
import com.shermatov.laborcostservice.repository.ProfessionsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import java.sql.CallableStatement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class ProfessionsRepositoryImpl implements ProfessionsRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Profession> findAll() {
        return jdbcTemplate.query("SELECT * FROM AMINJON.professions",
                BeanPropertyRowMapper.newInstance(Profession.class));
    }

    @Override
    public Profession findById(Integer professionId) {
        return jdbcTemplate.queryForObject("SELECT * FROM AMINJON.professions WHERE profession_id=?",
                BeanPropertyRowMapper.newInstance(Profession.class), professionId);
    }

    @Override
    public Profession save(Profession profession) {
        List paramList = new ArrayList();
        paramList.add(new SqlParameter(Types.VARCHAR));
        paramList.add(new SqlOutParameter("profession_id", Types.INTEGER));

        Map resultMap = jdbcTemplate.call(connection -> {

            CallableStatement callableStatement = connection.prepareCall("{ CALL INSERT INTO AMINJON.professions (name) VALUES(?) RETURNING profession_id INTO ? }");
            callableStatement.setString(1, profession.getName());
            callableStatement.registerOutParameter(2, Types.INTEGER);
            return callableStatement;

        }, paramList);

        Integer insertedId = (Integer)resultMap.getOrDefault("profession_id", -1);
        profession.setProfessionId(insertedId);
        return profession;
    }

    @Override
    public int update(Integer professionId, Profession profession) {
        return jdbcTemplate.update("UPDATE AMINJON.professions SET name=? WHERE profession_id=?",
                profession.getName(),
                professionId);
    }

    @Override
    public int deleteById(Integer professionId) {
        return jdbcTemplate.update("DELETE FROM AMINJON.professions WHERE profession_id=?",
                professionId);
    }

}
