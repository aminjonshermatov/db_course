export interface IPriceGuide {

  priceGuideId: number;
  hourlyRate: number;

}

export class PriceGuideModel implements IPriceGuide {

  constructor(public priceGuideId: number,
              public hourlyRate: number) { }


}
