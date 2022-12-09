package com.shermatov.laborcostservice.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class Detail {

    public enum DetailType { PURCHASED, IN_HOUSE }

    private Integer detailId;
    private DetailType type;
    private String name;
    private String measureUnit;
    private Double price;

}
