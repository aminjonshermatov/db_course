import {Pipe, PipeTransform} from '@angular/core';
import {DetailType} from "./detail.model";

@Pipe({
  name: 'detailType'
})
export class DetailTypePipe implements PipeTransform {

  transform(detailType: DetailType): string {
    if (detailType == DetailType.PURCHASED) return 'Покупная';
    return 'Cобственного производства';
  }

}
