package com.shermatov.laborcostservice.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class LaborCostStandard {

    private Integer detailId;
    private Integer operationId;
    private Integer professionId;
    private Integer qualification;
    private Integer priceGuideId;
    private Integer preparatoryTime;
    private Integer pieceTime;

}
