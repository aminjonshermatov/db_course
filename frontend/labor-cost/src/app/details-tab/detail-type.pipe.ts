import {Pipe, PipeTransform} from '@angular/core';
import {DetailType} from "./detail.model";

@Pipe({
  name: 'detailType'
})
export class DetailTypePipe implements PipeTransform {

  transform(detailType: any): string {
    if (typeof detailType == 'string') {
      if (detailType == DetailType.PURCHASED) return 'Покупная';
      else if (detailType == DetailType.IN_HOUSE) return 'Cобственного производства';
    }
    return detailType;
  }

}
