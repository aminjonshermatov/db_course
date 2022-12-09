package com.shermatov.laborcostservice.service;

import com.shermatov.laborcostservice.model.Profession;

import java.util.List;

public interface ProfessionsService {
    List<Profession> getProfessions();
    Profession getProfession(Integer professionId);
    void createProfession(Profession profession);
    void updateProfession(Integer professionId, Profession profession);
    void removeProfession(Integer professionId);

}
