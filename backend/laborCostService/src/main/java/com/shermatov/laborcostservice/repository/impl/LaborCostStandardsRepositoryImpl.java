package com.shermatov.laborcostservice.repository.impl;

import com.shermatov.laborcostservice.model.LaborCostStandard;
import com.shermatov.laborcostservice.model.LaborCostStandardDetail;
import com.shermatov.laborcostservice.mapper.LaborCostStandardDetailMapper;
import com.shermatov.laborcostservice.model.LaborCostStandardPropagate;
import com.shermatov.laborcostservice.repository.LaborCostStandardsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.*;
import org.springframework.stereotype.Repository;

import java.sql.CallableStatement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    public List<LaborCostStandardPropagate> findAllPropagate() {
        return jdbcTemplate.query("SELECT d.detail_id detailId, d.type detailType, d.name detailName, d.measure_unit detailMeasureUnit, d.price detailPrice, operation_id operationId, qualification, preparatory_time preparatoryTime, piece_time pieceTime, p.profession_id professionId, p.name professionName, pg.price_guide_id priceGuideId, pg.hourly_rate priceGuideHourlyRate\n" +
                        "FROM AMINJON.labor_cost_standards\n" +
                        "         LEFT JOIN AMINJON.details d ON labor_cost_standards.detail_id = d.detail_id\n" +
                        "         LEFT JOIN AMINJON.price_guide pg ON labor_cost_standards.price_guide_id = pg.price_guide_id\n" +
                        "         LEFT JOIN AMINJON.professions p ON p.profession_id = labor_cost_standards.profession_id\n",
                BeanPropertyRowMapper.newInstance(LaborCostStandardPropagate.class));
    }

    @Override
    public List<LaborCostStandardPropagate> findAllPropagateView() {
        return jdbcTemplate.query("SELECT * FROM labor_cost_all_details",
                BeanPropertyRowMapper.newInstance(LaborCostStandardPropagate.class));
    }

    @Override
    public LaborCostStandard findById(Integer operationId) {
        return jdbcTemplate.queryForObject("SELECT * FROM labor_cost_standards WHERE operation_id=?",
                BeanPropertyRowMapper.newInstance(LaborCostStandard.class), operationId);
    }

    @Override
    public LaborCostStandard save(LaborCostStandard laborCostStandard) {
        List paramList = new ArrayList();
        paramList.add(new SqlParameter(Types.INTEGER));
        paramList.add(new SqlParameter(Types.INTEGER));
        paramList.add(new SqlParameter(Types.INTEGER));
        paramList.add(new SqlParameter(Types.INTEGER));
        paramList.add(new SqlParameter(Types.INTEGER));
        paramList.add(new SqlParameter(Types.INTEGER));
        paramList.add(new SqlOutParameter("operation_id", Types.INTEGER));

        Map resultMap = jdbcTemplate.call(connection -> {

            CallableStatement callableStatement = connection.prepareCall("{ CALL INSERT INTO labor_cost_standards (detail_id, profession_id, qualification, price_guide_id, preparatory_time, piece_time) VALUES(?,?,?,?,?,?) RETURNING operation_id INTO ? }");
            callableStatement.setInt(1, laborCostStandard.getDetailId());
            callableStatement.setInt(2, laborCostStandard.getProfessionId());
            callableStatement.setInt(3, laborCostStandard.getQualification());
            callableStatement.setInt(4, laborCostStandard.getPriceGuideId());
            callableStatement.setInt(5, laborCostStandard.getPreparatoryTime());
            callableStatement.setInt(6, laborCostStandard.getPieceTime());
            callableStatement.registerOutParameter(7, Types.INTEGER);
            return callableStatement;

        }, paramList);

        Integer insertedId = (Integer)resultMap.getOrDefault("operation_id", -1);
        laborCostStandard.setOperationId(insertedId);
        return laborCostStandard;
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

    @Override
    public List<LaborCostStandardDetail> findByDetailName(String detailName) {
        return jdbcTemplate.query("SELECT * from TABLE ( furniture_details.get_operations_with_detail(?) )", new LaborCostStandardDetailMapper(), detailName);
    }
}
