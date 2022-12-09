package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.model.LaborCostStandard;

import java.util.List;

public interface LaborCostStandardsRepository {

    List<LaborCostStandard> findAll();
    LaborCostStandard findById(Integer operationId);
    int save(LaborCostStandard laborCostStandard);
    int update(Integer operationId, LaborCostStandard laborCostStandard);
    int deleteById(Integer operationId);

}
