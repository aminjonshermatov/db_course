package com.shermatov.laborcostservice.service;

import com.shermatov.laborcostservice.model.Detail;

import java.util.List;

public interface DetailsService {
    List<Detail> getDetails();
    Detail getDetail(Integer detailId);
    void createDetail(Detail detail);
    void updateDetail(Integer detailId, Detail detail);
    void removeDetail(Integer detailId);
    Integer getMostExpensiveDetail();
}
