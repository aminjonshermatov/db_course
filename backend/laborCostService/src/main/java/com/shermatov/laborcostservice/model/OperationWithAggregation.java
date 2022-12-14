package com.shermatov.laborcostservice.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class OperationWithAggregation {

    Integer detailId;
    Integer operationId;
    String professionName;
    Integer operationsCount;
    Integer minQualification;

}
