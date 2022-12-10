package com.shermatov.laborcostservice.service.impl;

import com.shermatov.laborcostservice.exception.ResourceNotFoundException;
import com.shermatov.laborcostservice.model.Detail;
import com.shermatov.laborcostservice.repository.DetailsRepository;
import com.shermatov.laborcostservice.service.DetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetailsServiceImpl implements DetailsService {

    @Autowired
    DetailsRepository detailsRepository;

    @Override
    public List<Detail> getDetails() {
        return detailsRepository.findAll();
    }

    @Override
    public Detail getDetail(Integer detailId) {
        try {
            return detailsRepository.findById(detailId);
        } catch (EmptyResultDataAccessException ex) {
            throw new ResourceNotFoundException(ex.getMessage());
        }
    }

    @Override
    public Detail createDetail(Detail detail) {
        return detailsRepository.save(detail);
    }

    @Override
    public void updateDetail(Integer detailId, Detail detail) {
        detailsRepository.update(detailId, detail);
    }

    @Override
    public void removeDetail(Integer detailId) {
        detailsRepository.deleteById(detailId);
    }

    @Override
    public Integer getMostExpensiveDetail() {
        return detailsRepository.mostExpensiveDetail();
    }

}
