package com.shermatov.laborcostservice.controller;

import com.shermatov.laborcostservice.model.LaborCostStandard;
import com.shermatov.laborcostservice.model.LaborCostStandardDetail;
import com.shermatov.laborcostservice.model.LaborCostStandardPropagate;
import com.shermatov.laborcostservice.service.LaborCostStandardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/labor_cost_standards")
public class LaborCostStandardsController {

    @Autowired
    LaborCostStandardService laborCostStandardService;

    @GetMapping("ping")
    String hello() { return "works"; }

    @GetMapping
    List<LaborCostStandard> getLaborCostStandards() {
        return laborCostStandardService.getLaborCostStandards();
    }

    @GetMapping("/propagate")
    List<LaborCostStandardPropagate> getLaborCostStandardsPropagate() {
        return laborCostStandardService.getLaborCostStandardsPropagate();
    }

    @GetMapping("/propagate/view")
    List<LaborCostStandardPropagate> getLaborCostStandardsPropagateView() {
        return laborCostStandardService.getLaborCostStandardsPropagateView();
    }

    @GetMapping("/{operationId}")
    LaborCostStandard getLaborCostStandardById(@PathVariable Integer operationId) {
        return laborCostStandardService.getLaborCostStandard(operationId);
    }

    @GetMapping("/with_detail/{detailName}")
    List<LaborCostStandardDetail> getLaborCostStandardSWithDetailName(@PathVariable String detailName) {
        return laborCostStandardService.getLaborCostStandardSWithDetailName(detailName);
    }

    @PostMapping
    LaborCostStandard createLaborCostStandard(@RequestBody LaborCostStandard laborCostStandard) {
        return laborCostStandardService.createLaborCostStandard(laborCostStandard);
    }

    @PutMapping("/{operationId}")
    ResponseEntity<String> updateLaborCostStandard(@PathVariable Integer operationId,
                                                   @RequestBody LaborCostStandard laborCostStandard) {
        laborCostStandardService.updateLaborCostStandard(operationId, laborCostStandard);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{operationId}")
    ResponseEntity<String> deleteLaborCostStandard(@PathVariable Integer operationId) {
        laborCostStandardService.removeLaborCostStandard(operationId);
        return ResponseEntity.ok().build();
    }

}
