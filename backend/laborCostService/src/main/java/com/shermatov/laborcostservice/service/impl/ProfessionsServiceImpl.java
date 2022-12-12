package com.shermatov.laborcostservice.service.impl;

import com.shermatov.laborcostservice.exception.ResourceNotFoundException;
import com.shermatov.laborcostservice.model.Profession;
import com.shermatov.laborcostservice.repository.ProfessionsRepository;
import com.shermatov.laborcostservice.service.ProfessionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProfessionsServiceImpl implements ProfessionsService {

    @Autowired
    ProfessionsRepository professionsRepository;

    @Override
    public List<Profession> getProfessions() {
        return professionsRepository.findAll();
    }

    @Override
    public Profession getProfession(Integer professionId) {
        try {
            return professionsRepository.findById(professionId);
        } catch (EmptyResultDataAccessException ex) {
            throw new ResourceNotFoundException(ex.getMessage());
        }
    }

    @Override
    public Profession createProfession(Profession profession) {
        return professionsRepository.save(profession);
    }

    @Override
    public void updateProfession(Integer professionId, Profession profession) {
        professionsRepository.update(professionId, profession);
    }

    @Override
    public void removeProfession(Integer professionId) {
        professionsRepository.deleteById(professionId);
    }
}
