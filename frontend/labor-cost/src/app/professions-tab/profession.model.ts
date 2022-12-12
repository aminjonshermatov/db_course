export interface IProfession {

  professionId: number;
  name: string;

}

export class Profession implements IProfession {

  constructor(public professionId: number,
              public name: string) { }

}
