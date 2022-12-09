package com.shermatov.laborcostservice.controller;

import com.shermatov.laborcostservice.model.PriceGuide;
import com.shermatov.laborcostservice.service.PriceGuidesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/price_guides")
public class PriceGuidesController {

    @Autowired
    private PriceGuidesService priceGuidesService;

    @GetMapping("ping")
    String hello() { return "works"; }

    @GetMapping
    List<PriceGuide> getPriceGuides() {
        return priceGuidesService.getPriceGuides();
    }

    @GetMapping("/{priceGuideId}")
    PriceGuide getPriceGuideById(@PathVariable Integer priceGuideId) {
        return priceGuidesService.getPriceGuide(priceGuideId);
    }

    @PostMapping
    ResponseEntity<String> createPriceGuide(@RequestBody PriceGuide priceGuide) {
        priceGuidesService.createPriceGuide(priceGuide);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PutMapping("/{priceGuideId}")
    ResponseEntity<String> updatePriceGuide(@PathVariable Integer priceGuideId,
                                            @RequestBody PriceGuide priceGuide) {
        priceGuidesService.updatePriceGuide(priceGuideId, priceGuide);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{priceGuideId}")
    ResponseEntity<String> deletePriceGuide(@PathVariable Integer priceGuideId) {
        priceGuidesService.removePriceGuide(priceGuideId);
        return ResponseEntity.ok().build();
    }

}
