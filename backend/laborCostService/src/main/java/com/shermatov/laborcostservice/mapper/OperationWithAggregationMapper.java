package com.shermatov.laborcostservice.mapper;

import com.shermatov.laborcostservice.model.OperationWithAggregation;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;


public class OperationWithAggregationMapper implements RowMapper<OperationWithAggregation> {
    @Override
    public OperationWithAggregation mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new OperationWithAggregation().builder()
                .detailId(rs.getInt("detail_id"))
                .operationId(rs.getInt("operation_id"))
                .professionName(rs.getString("profession_name"))
                .operationsCount(rs.getInt("operations_count"))
                .minQualification(rs.getInt("min_qualification"))
                .build();
    }
}
