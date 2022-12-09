package com.shermatov.laborcostservice.controller;

import com.shermatov.laborcostservice.model.Detail;
import com.shermatov.laborcostservice.service.DetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/details")
public class DetailsController {

    @Autowired
    DetailsService detailsService;

    @GetMapping("ping")
    String hello() { return "works"; }

    @GetMapping
    List<Detail> getDetails() { return detailsService.getDetails(); }

    @GetMapping("/{detailId}")
    Detail getDetailById(@PathVariable Integer detailId) {
        return detailsService.getDetail(detailId);
    }

    @PostMapping
    ResponseEntity<String> createDetail(@RequestBody Detail detail) {
        detailsService.createDetail(detail);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PutMapping("/{detailId}")
    ResponseEntity<String> updateDetail(@PathVariable Integer detailId,
                                        @RequestBody Detail detail) {
        detailsService.updateDetail(detailId, detail);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{detailId}")
    ResponseEntity<String> deleteDetail(@PathVariable Integer detailId) {
        detailsService.removeDetail(detailId);
        return ResponseEntity.ok().build();
    }

}
