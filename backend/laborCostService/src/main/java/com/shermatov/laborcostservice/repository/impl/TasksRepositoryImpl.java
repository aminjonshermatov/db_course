package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.entity.OperationDetailed;
import com.shermatov.laborcostservice.mapper.OperationDetailedMapper;
import com.shermatov.laborcostservice.mapper.OperationWithAggregationMapper;
import com.shermatov.laborcostservice.model.OperationWithAggregation;
import com.shermatov.laborcostservice.repository.TasksRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TasksRepositoryImpl implements TasksRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    @Override
    public OperationDetailed getOperationDetailed(Integer operationId) {
        var res = jdbcTemplate.query("SELECT * from TABLE ( tasks.get_operation_detailed(?) )", new OperationDetailedMapper(), operationId);
        assert (res.size() == 1);
        return res.get(0);
    }

    @Override
    public List<OperationWithAggregation> getOperationsWithAggregation() {
        return jdbcTemplate.query("SELECT * FROM TABLE ( tasks.get_operations_with_aggregation() )", new OperationWithAggregationMapper());
    }
}
