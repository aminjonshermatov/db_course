package com.shermatov.laborcostservice.controller;

import com.shermatov.laborcostservice.entity.OperationDetailed;
import com.shermatov.laborcostservice.model.OperationWithAggregation;
import com.shermatov.laborcostservice.service.TasksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/tasks")
public class TasksController {

    @Autowired
    TasksService tasksService;

    @GetMapping("/1/raw/{operationId}")
    OperationDetailed operationDetailedRaw(@PathVariable Integer operationId) {
        return tasksService.getOperationDetailed(operationId, true);
    }

    @GetMapping("/1/orm/{operationId}")
    OperationDetailed operationDetailedOrm(@PathVariable Integer operationId) {
        return tasksService.getOperationDetailed(operationId, false);
    }

    @GetMapping("/2")
    List<OperationWithAggregation> getOperationsWithAggregation() {
        return tasksService.getOperationsWithAggregation();
    }

}
