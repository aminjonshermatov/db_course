package com.shermatov.laborcostservice.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class PriceGuide {

    private Integer priceGuideId;
    private Integer hourlyRate;

}
