package com.shermatov.laborcostservice.service;

import com.shermatov.laborcostservice.model.PriceGuide;

import java.util.List;

public interface PriceGuidesService {
    List<PriceGuide> getPriceGuides();
    PriceGuide getPriceGuide(Integer priceGuideId);
    PriceGuide createPriceGuide(PriceGuide priceGuide);
    void updatePriceGuide(Integer priceGuideId, PriceGuide priceGuide);
    void removePriceGuide(Integer priceGuideId);

}
