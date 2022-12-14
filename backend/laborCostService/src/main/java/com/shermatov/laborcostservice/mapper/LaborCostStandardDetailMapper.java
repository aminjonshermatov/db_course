package com.shermatov.laborcostservice.mapper;

import com.shermatov.laborcostservice.model.LaborCostStandardDetail;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class LaborCostStandardDetailMapper implements RowMapper<LaborCostStandardDetail> {
    public LaborCostStandardDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new LaborCostStandardDetail().builder()
                .detailId(rs.getInt("detail_id"))
                .operationId(rs.getInt("operation_id"))
                .detailName(rs.getString("detail_name"))
                .detailPrice(rs.getDouble("price"))
                .build();
    }
}
