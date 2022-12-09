package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.model.Profession;

import java.util.List;

public interface ProfessionsRepository {

    List<Profession> findAll();
    Profession findById(Integer professionId);
    int save(Profession profession);
    int update(Integer professionId, Profession profession);
    int deleteById(Integer professionId);

}
