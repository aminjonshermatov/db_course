package com.shermatov.laborcostservice.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@Entity
@Table(name = "professions")
public class Profession {

    @Id
    @Column(name = "profession_id")
    Integer id;

    @Column(name = "name")
    String name;

}
