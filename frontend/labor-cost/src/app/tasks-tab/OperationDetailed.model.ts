export interface IOperationDetailed {
  id: number;
  qualification: number;
  detailId: number;
  detailName: string;
  price: number;
  hourlyRate: number;
  professionName: string;
}

export class OperationDetailed implements IOperationDetailed {

  constructor(public id: number,
              public qualification: number,
              public detailId: number,
              public detailName: string,
              public price: number,
              public hourlyRate: number,
              public professionName: string) { }

}
