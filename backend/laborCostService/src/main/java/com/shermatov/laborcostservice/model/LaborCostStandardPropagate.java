package com.shermatov.laborcostservice.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class LaborCostStandardPropagate {

    private Integer detailId;
    private Detail.DetailType detailType;
    private String detailName;
    private String detailMeasureUnit;
    private Double detailPrice;

    private Integer operationId;
    private Integer qualification;
    private Integer preparatoryTime;
    private Integer pieceTime;

    private Integer professionId;
    private String professionName;

    private Integer priceGuideId;
    private Integer priceGuideHourlyRate;

}
