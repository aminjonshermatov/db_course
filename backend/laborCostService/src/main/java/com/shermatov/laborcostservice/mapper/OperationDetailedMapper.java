package com.shermatov.laborcostservice.mapper;

import com.shermatov.laborcostservice.entity.OperationDetailed;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OperationDetailedMapper implements RowMapper<OperationDetailed> {
    @Override
    public OperationDetailed mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new OperationDetailed().builder()
                .id(rs.getInt("operation_id"))
                .qualification(rs.getInt("qualification"))
                .detailId(rs.getInt("detail_id"))
                .detailName(rs.getString("detail_name"))
                .price(rs.getDouble("price"))
                .hourlyRate(rs.getInt("hourly_rate"))
                .professionName(rs.getString("profession_name"))
                .build();
    }
}
