package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.entity.OperationDetailed;
import com.shermatov.laborcostservice.model.OperationWithAggregation;

import java.util.List;

public interface TasksRepository {

    OperationDetailed getOperationDetailed(Integer operationId);
    List<OperationWithAggregation> getOperationsWithAggregation();

}
