export interface IOperationWithAggregation {

  detailId: number;
  operationId: number;
  professionName: string;
  operationsCount: number;
  minQualification: number;

}

export class OperationWithAggregation implements IOperationWithAggregation {

  constructor(public detailId: number,
              public operationId: number,
              public professionName: string,
              public operationsCount: number,
              public minQualification: number) { }

}
