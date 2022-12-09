package com.shermatov.laborcostservice.service;

import com.shermatov.laborcostservice.model.LaborCostStandard;

import java.util.List;

public interface LaborCostStandardService {

    List<LaborCostStandard> getLaborCostStandards();
    LaborCostStandard getLaborCostStandard(Integer operationId);
    void createLaborCostStandard(LaborCostStandard laborCostStandards);
    void updateLaborCostStandard(Integer operationId, LaborCostStandard laborCostStandard);
    void removeLaborCostStandard(Integer operationId);

}
