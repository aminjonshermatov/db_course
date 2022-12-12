import {Component, Inject, OnInit} from '@angular/core';
import {FormGroup, UntypedFormControl, UntypedFormGroup, Validators} from "@angular/forms";
import {MAT_DIALOG_DATA, MatDialogRef} from "@angular/material/dialog";
import {NotificationService} from "../../notification.service";
import {ILaborCostStandard, ILaborCostStandardPropagate} from "../labor-cost-standard.model";

@Component({
  selector: 'app-edit-create-labor-cost-standard',
  templateUrl: './edit-create-labor-cost-standard.component.html',
  styleUrls: ['./edit-create-labor-cost-standard.component.scss']
})
export class EditCreateLaborCostStandardComponent implements OnInit {

  public laborCostStandardForm: FormGroup;
  constructor(private readonly dialogRef: MatDialogRef<EditCreateLaborCostStandardComponent>,
              private readonly notificationService: NotificationService,
              @Inject(MAT_DIALOG_DATA) public data: { laborCostStandard: ILaborCostStandard | ILaborCostStandardPropagate, isEdit: boolean }) {
    this.laborCostStandardForm = new UntypedFormGroup({
      detailId: new UntypedFormControl(this.data.laborCostStandard.detailId, [Validators.required]),
      professionId: new UntypedFormControl(this.data.laborCostStandard.professionId, [Validators.required]),
      priceGuideId: new UntypedFormControl(this.data.laborCostStandard.priceGuideId, [Validators.required]),
      qualification: new UntypedFormControl(this.data.laborCostStandard.qualification, [Validators.required, Validators.min(1)]),
      preparatoryTime: new UntypedFormControl(this.data.laborCostStandard.preparatoryTime, [Validators.required, Validators.min(0)]),
      pieceTime: new UntypedFormControl(this.data.laborCostStandard.pieceTime, [Validators.required, Validators.min(0)])
    })
  }

  ngOnInit(): void { }

  public hasError = (controlName: string, errorName: string) =>
    this.laborCostStandardForm?.controls[controlName].hasError(errorName);

  public onNoClick(): void {
    this.data.isEdit = false;
    this.dialogRef.close(this.data);
  }

  public save(): void {
    if (!this.laborCostStandardForm.valid) {
      this.notificationService.error(`Don't cheat!!!`)
      return;
    }

    this.data.isEdit = true;
    this.data.laborCostStandard = { ...this.data.laborCostStandard, ...this.laborCostStandardForm.value }
    this.dialogRef.close(this.data);
  }

}
