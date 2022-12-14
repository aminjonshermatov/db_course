package com.shermatov.laborcostservice.service.impl;

import com.shermatov.laborcostservice.entity.OperationDetailed;
import com.shermatov.laborcostservice.model.OperationWithAggregation;
import com.shermatov.laborcostservice.repository.Task2Orm;
import com.shermatov.laborcostservice.repository.TasksRepository;
import com.shermatov.laborcostservice.service.TasksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TasksServiceImpl implements TasksService {

    @Autowired
    TasksRepository tasksRepository;

    @Autowired
    Task2Orm task2Orm;

    @Override
    public OperationDetailed getOperationDetailed(Integer operationId, Boolean isRawSql) {
        return isRawSql
                ? tasksRepository.getOperationDetailed(operationId)
                : task2Orm.getOperationDetailed(operationId);
    }

    @Override
    public List<OperationWithAggregation> getOperationsWithAggregation() {
        return tasksRepository.getOperationsWithAggregation();
    }
}
