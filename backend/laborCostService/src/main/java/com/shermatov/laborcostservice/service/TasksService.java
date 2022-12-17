package com.shermatov.laborcostservice.service;

import com.shermatov.laborcostservice.entity.OperationDetailed;
import com.shermatov.laborcostservice.entity.Profession;
import com.shermatov.laborcostservice.model.OperationWithAggregation;

import java.util.List;

public interface TasksService {

    OperationDetailed getOperationDetailed(Integer operationId, Boolean isRawSql);
    List<OperationWithAggregation> getOperationsWithAggregation();

    Profession task3();

}
