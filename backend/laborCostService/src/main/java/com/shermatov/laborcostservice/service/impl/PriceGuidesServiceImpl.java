package com.shermatov.laborcostservice.service.impl;

import com.shermatov.laborcostservice.exception.ResourceNotFoundException;
import com.shermatov.laborcostservice.model.PriceGuide;
import com.shermatov.laborcostservice.repository.PriceGuidesRepository;
import com.shermatov.laborcostservice.service.PriceGuidesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PriceGuidesServiceImpl implements PriceGuidesService {

    @Autowired
    private PriceGuidesRepository priceGuidesRepository;

    @Override
    public List<PriceGuide> getPriceGuides() {
        try {
            return priceGuidesRepository.findAll();
        } catch (EmptyResultDataAccessException ex) {
            throw new ResourceNotFoundException(ex.getMessage());
        }
    }

    @Override
    public PriceGuide getPriceGuide(Integer priceGuideId) {
        return priceGuidesRepository.findById(priceGuideId);
    }

    @Override
    public PriceGuide createPriceGuide(PriceGuide priceGuide) {
        return priceGuidesRepository.save(priceGuide);
    }

    @Override
    public void updatePriceGuide(Integer priceGuideId, PriceGuide priceGuide) {
        priceGuidesRepository.update(priceGuideId, priceGuide);
    }

    @Override
    public void removePriceGuide(Integer priceGuideId) {
        priceGuidesRepository.deleteById(priceGuideId);
    }
}
