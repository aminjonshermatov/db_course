package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.model.LaborCostStandard;
import com.shermatov.laborcostservice.model.LaborCostStandardDetail;
import com.shermatov.laborcostservice.model.LaborCostStandardPropagate;

import java.util.List;

public interface LaborCostStandardsRepository {

    List<LaborCostStandard> findAll();
    List<LaborCostStandardPropagate> findAllPropagate();
    List<LaborCostStandardPropagate> findAllPropagateView();
    LaborCostStandard findById(Integer operationId);
    int save(LaborCostStandard laborCostStandard);
    int update(Integer operationId, LaborCostStandard laborCostStandard);
    int deleteById(Integer operationId);
    List<LaborCostStandardDetail> findByDetailName(String detailName);
}
