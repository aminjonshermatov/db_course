package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.model.Detail;

import java.util.List;

public interface DetailsRepository {

    List<Detail> findAll();
    Detail findById(Integer detailId);
    int save(Detail detail);
    int update(Integer detailId, Detail detail);
    int deleteById(Integer detailId);
    Integer mostExpensiveDetail();
}
