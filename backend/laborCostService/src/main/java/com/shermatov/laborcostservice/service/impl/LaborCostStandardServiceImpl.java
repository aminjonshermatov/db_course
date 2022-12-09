package com.shermatov.laborcostservice.service.impl;

import com.shermatov.laborcostservice.exception.ResourceNotFoundException;
import com.shermatov.laborcostservice.model.LaborCostStandard;
import com.shermatov.laborcostservice.model.LaborCostStandardDetail;
import com.shermatov.laborcostservice.model.LaborCostStandardPropagate;
import com.shermatov.laborcostservice.repository.LaborCostStandardsRepository;
import com.shermatov.laborcostservice.service.LaborCostStandardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LaborCostStandardServiceImpl implements LaborCostStandardService {

    @Autowired
    private LaborCostStandardsRepository laborCostStandardsRepository;

    @Override
    public List<LaborCostStandard> getLaborCostStandards() {
        return laborCostStandardsRepository.findAll();
    }

    @Override
    public List<LaborCostStandardPropagate> getLaborCostStandardsPropagate() {
        return laborCostStandardsRepository.findAllPropagate();
    }

    @Override
    public List<LaborCostStandardPropagate> getLaborCostStandardsPropagateView() {
        return laborCostStandardsRepository.findAllPropagateView();
    }

    @Override
    public LaborCostStandard getLaborCostStandard(Integer operationId) {
        try {
            return laborCostStandardsRepository.findById(operationId);
        } catch (EmptyResultDataAccessException ex) {
            throw new ResourceNotFoundException(ex.getMessage());
        }
    }

    @Override
    public void createLaborCostStandard(LaborCostStandard laborCostStandards) {
        laborCostStandardsRepository.save(laborCostStandards);
    }

    @Override
    public void updateLaborCostStandard(Integer operationId, LaborCostStandard laborCostStandard) {
        laborCostStandardsRepository.update(operationId, laborCostStandard);
    }

    @Override
    public void removeLaborCostStandard(Integer operationId) {
        laborCostStandardsRepository.deleteById(operationId);
    }

    @Override
    public List<LaborCostStandardDetail> getLaborCostStandardSWithDetailName(String detailName) {
        return laborCostStandardsRepository.findByDetailName(detailName);
    }
}
