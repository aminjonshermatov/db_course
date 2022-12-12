export interface IPriceGuide {

  priceGuideId: number;
  hourlyRate: number;

}

export class PriceGuide implements IPriceGuide {

  constructor(public priceGuideId: number,
              public hourlyRate: number) { }


}
