package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.model.PriceGuide;

import java.util.List;

public interface PriceGuidesRepository {

    List<PriceGuide> findAll();
    PriceGuide findById(Integer priceGuideId);
    PriceGuide save(PriceGuide priceGuide);
    int update(Integer priceGuideId, PriceGuide priceGuide);
    int deleteById(Integer priceGuideId);

}
