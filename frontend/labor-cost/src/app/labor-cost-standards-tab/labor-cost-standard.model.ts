import {DetailType} from "../details-tab/detail.model";

export interface ILaborCostStandard {

  detailId: number;
  professionId: number;
  priceGuideId: number;
  operationId: number;
  qualification: number;
  preparatoryTime: number;
  pieceTime: number;

}

export class LaborCostStandard implements ILaborCostStandard {

  constructor(public detailId: number,
              public professionId: number,
              public priceGuideId: number,
              public operationId: number,
              public qualification: number,
              public preparatoryTime: number,
              public pieceTime: number) { }

}

export interface ILaborCostStandardPropagate extends ILaborCostStandard {

  detailType: DetailType;
  detailName: string;
  detailMeasureUnit:string;
  detailPrice: number;
  professionName: string;
  priceGuideHourlyRate: number;

}

export interface ILaborCostStandardDetail extends Pick<ILaborCostStandard, "detailId" | "operationId">, Pick<ILaborCostStandardPropagate, "detailName" | "detailPrice"> {}
