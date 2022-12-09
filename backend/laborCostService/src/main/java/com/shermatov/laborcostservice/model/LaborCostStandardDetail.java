package com.shermatov.laborcostservice.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class LaborCostStandardDetail {

    private Integer detailId;
    private Integer operationId;
    private String  detailName;
    private Double price;

}

