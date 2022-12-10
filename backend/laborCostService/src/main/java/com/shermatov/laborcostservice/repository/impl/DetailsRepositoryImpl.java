package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.model.Detail;
import com.shermatov.laborcostservice.repository.DetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.*;
import org.springframework.stereotype.Repository;

import java.sql.CallableStatement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    public Detail save(Detail detail) {
        List paramList = new ArrayList();
        paramList.add(new SqlParameter(Types.VARCHAR));
        paramList.add(new SqlParameter(Types.VARCHAR));
        paramList.add(new SqlParameter(Types.VARCHAR));
        paramList.add(new SqlParameter(Types.DECIMAL));
        paramList.add(new SqlOutParameter("detail_id", Types.INTEGER));

        Map resultMap = jdbcTemplate.call(connection -> {

            CallableStatement callableStatement = connection.prepareCall("{ CALL INSERT INTO details (\"TYPE\", name, measure_unit, price) VALUES(?,?,?,?) RETURNING detail_id INTO ? }");
            callableStatement.setString(1, detail.getType().toString());
            callableStatement.setString(2, detail.getName());
            callableStatement.setString(3, detail.getMeasureUnit());
            callableStatement.setDouble(4, detail.getPrice());
            callableStatement.registerOutParameter(5, Types.INTEGER);
            return callableStatement;

        }, paramList);

        Integer insertedId = (Integer)resultMap.getOrDefault("detail_id", -1);
        detail.setDetailId(insertedId);
        return detail;
    }

    @Override
    public void update(Integer detailId, Detail detail) {
        jdbcTemplate.update("UPDATE details SET type=?, name=?, measure_unit=?, price=? WHERE detail_id=?",
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
