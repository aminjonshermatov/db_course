package com.shermatov.laborcostservice.service;

import com.shermatov.laborcostservice.model.Profession;

import java.util.List;

public interface ProfessionsService {
    List<Profession> getProfessions();
    Profession getProfession(Integer professionId);
    Profession createProfession(Profession profession);
    void updateProfession(Integer professionId, Profession profession);
    void removeProfession(Integer professionId);

}
