package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.entity.Profession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface Task3Orm extends JpaRepository<Profession, Integer> {

    @Query(nativeQuery = true, value = "SELECT *\n" +
            "FROM professions p\n" +
            "WHERE (SELECT COUNT(*) FROM price_guide) =\n" +
            "      (SELECT COUNT(DISTINCT lcs.price_guide_id) FROM labor_cost_standards lcs WHERE lcs.profession_id = p.profession_id)")
    Profession task3();

}
