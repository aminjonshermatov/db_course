package com.shermatov.laborcostservice.repository;

import com.shermatov.laborcostservice.entity.OperationDetailed;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface Task2Orm extends JpaRepository<OperationDetailed, Long> {

    @Query(nativeQuery = true, value = "SELECT * FROM TABLE ( tasks.get_operation_detailed(:req_operation_id) )")
    OperationDetailed getOperationDetailed(@Param("req_operation_id") Integer operationId);

}
