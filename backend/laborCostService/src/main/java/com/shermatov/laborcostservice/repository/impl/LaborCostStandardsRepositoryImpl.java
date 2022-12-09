package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.model.Detail;
import com.shermatov.laborcostservice.model.LaborCostStandard;
import com.shermatov.laborcostservice.repository.LaborCostStandardsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LaborCostStandardsRepositoryImpl implements LaborCostStandardsRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<LaborCostStandard> findAll() {
        return jdbcTemplate.query("SELECT * FROM labor_cost_standards",
                BeanPropertyRowMapper.newInstance(LaborCostStandard.class));
    }

    @Override
    public LaborCostStandard findById(Integer operationId) {
        return jdbcTemplate.queryForObject("SELECT * FROM labor_cost_standards WHERE operation_id=?",
                BeanPropertyRowMapper.newInstance(LaborCostStandard.class), operationId);
    }

    @Override
    public int save(LaborCostStandard laborCostStandard) {
        return jdbcTemplate.update("INSERT INTO labor_cost_standards (detail_id, profession_id, qualification, price_guide_id, preparatory_time, piece_time)" +
                        "VALUES(?,?,?,?,?,?)",
                laborCostStandard.getDetailId(),
                laborCostStandard.getProfessionId(),
                laborCostStandard.getQualification(),
                laborCostStandard.getPriceGuideId(),
                laborCostStandard.getPreparatoryTime(),
                laborCostStandard.getPieceTime());
    }

    @Override
    public int update(Integer operationId, LaborCostStandard laborCostStandard) {
        return jdbcTemplate.update("UPDATE labor_cost_standards SET detail_id=?, profession_id=?, qualification=?, price_guide_id=?, preparatory_time=?, piece_time=? WHERE operation_id=?",
                laborCostStandard.getDetailId(),
                laborCostStandard.getProfessionId(),
                laborCostStandard.getQualification(),
                laborCostStandard.getPriceGuideId(),
                laborCostStandard.getPreparatoryTime(),
                laborCostStandard.getPieceTime(),
                operationId);
    }

    @Override
    public int deleteById(Integer operationId) {
        return jdbcTemplate.update("DELETE FROM labor_cost_standards WHERE operation_id=?",
                operationId);
    }
}
