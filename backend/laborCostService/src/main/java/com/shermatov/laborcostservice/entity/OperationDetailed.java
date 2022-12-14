package com.shermatov.laborcostservice.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@Entity
public class OperationDetailed {

    @jakarta.persistence.Id
    @Id
    @Column(name = "operation_id")
    Integer id;
    Integer qualification;
    @Column(name = "detail_id")
    Integer detailId;
    @Column(name = "detail_name")
    String detailName;
    Double price;
    @Column(name = "hourly_rate")
    Integer hourlyRate;
    @Column(name = "profession_name")
    String professionName;

}
