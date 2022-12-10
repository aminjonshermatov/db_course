package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.model.Detail;

import java.util.List;

public interface DetailsRepository {

    List<Detail> findAll();
    Detail findById(Integer detailId);
    Detail save(Detail detail);
    void update(Integer detailId, Detail detail);
    int deleteById(Integer detailId);
    Integer mostExpensiveDetail();
}
