package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.model.PriceGuide;
import com.shermatov.laborcostservice.repository.PriceGuidesRepository;
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
public class PriceGuidesRepositoryImpl implements PriceGuidesRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<PriceGuide> findAll() {
        return jdbcTemplate.query("SELECT * FROM AMINJON.price_guide",
                BeanPropertyRowMapper.newInstance(PriceGuide.class));
    }

    @Override
    public PriceGuide findById(Integer priceGuideId) {
        return jdbcTemplate.queryForObject("SELECT * FROM AMINJON.price_guide WHERE price_guide_id=?",
                BeanPropertyRowMapper.newInstance(PriceGuide.class), priceGuideId);
    }

    @Override
    public PriceGuide save(PriceGuide priceGuide) {
        List paramList = new ArrayList();
        paramList.add(new SqlParameter(Types.VARCHAR));
        paramList.add(new SqlOutParameter("price_guide_id", Types.INTEGER));

        Map resultMap = jdbcTemplate.call(connection -> {

            CallableStatement callableStatement = connection.prepareCall("{ CALL INSERT INTO AMINJON.price_guide (hourly_rate) VALUES(?) RETURNING price_guide_id INTO ? }");
            callableStatement.setInt(1, priceGuide.getHourlyRate());
            callableStatement.registerOutParameter(2, Types.INTEGER);
            return callableStatement;

        }, paramList);

        Integer insertedId = (Integer)resultMap.getOrDefault("price_guide_id", -1);
        priceGuide.setPriceGuideId(insertedId);
        return priceGuide;
    }

    @Override
    public int update(Integer priceGuideId, PriceGuide priceGuide) {
        return jdbcTemplate.update("UPDATE AMINJON.price_guide SET hourly_rate=? WHERE price_guide_id=?",
                priceGuide.getHourlyRate(),
                    priceGuideId);
    }

    @Override
    public int deleteById(Integer priceGuideId) {
        return jdbcTemplate.update("DELETE FROM AMINJON.price_guide WHERE price_guide_id=?",
                priceGuideId);
    }
}
