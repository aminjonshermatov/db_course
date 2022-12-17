package com.shermatov.laborcostservice.service.impl;

import com.shermatov.laborcostservice.entity.OperationDetailed;
import com.shermatov.laborcostservice.entity.Profession;
import com.shermatov.laborcostservice.model.OperationWithAggregation;
import com.shermatov.laborcostservice.repository.Task3Orm;
import com.shermatov.laborcostservice.repository.TaskOrm;
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
    TaskOrm task2Orm;

    @Autowired
    Task3Orm task3Orm;

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

    @Override
    public Profession task3() {
        return task3Orm.task3();
    }


}
