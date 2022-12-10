export enum DetailType { PURCHASED, IN_HOUSE }

export interface IDetail {

  detailId: number;
  type: DetailType;
  name: string;
  measureUnit: string;
  price: number;

}

export class Detail implements IDetail {

  constructor(public detailId: number,
              public type: DetailType,
              public name: string,
              public measureUnit: string,
              public price: number) { }

}
