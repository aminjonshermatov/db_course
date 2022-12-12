package com.shermatov.laborcostservice.controller;

import com.shermatov.laborcostservice.model.Profession;
import com.shermatov.laborcostservice.service.ProfessionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/professions")
public class ProfessionsController {

    @Autowired
    ProfessionsService professionsService;

    @GetMapping("ping")
    String hello() { return "works"; }

    @GetMapping
    List<Profession> getProfessions() { return professionsService.getProfessions(); }

    @GetMapping("/{professionId}")
    Profession getProfessionById(@PathVariable Integer professionId) {
        return professionsService.getProfession(professionId);
    }

    @PostMapping
    Profession createProfession(@RequestBody Profession profession) {
        return professionsService.createProfession(profession);
    }

    @PutMapping("/{professionId}")
    ResponseEntity<String> updateDetail(@PathVariable Integer professionId,
                                        @RequestBody Profession profession) {
        professionsService.updateProfession(professionId, profession);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{professionId}")
    ResponseEntity<String> deleteProfession(@PathVariable Integer professionId) {
        professionsService.removeProfession(professionId);
        return ResponseEntity.ok().build();
    }

}
