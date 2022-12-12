import {Component, Inject, OnInit} from '@angular/core';
import {FormGroup, UntypedFormControl, UntypedFormGroup, Validators} from "@angular/forms";
import {MAT_DIALOG_DATA, MatDialogRef} from "@angular/material/dialog";
import {IPriceGuide} from "../price-guide.model";
import {NotificationService} from "../../notification.service";

@Component({
  selector: 'app-edit-create-price-guide',
  templateUrl: './edit-create-price-guide.component.html',
  styleUrls: ['./edit-create-price-guide.component.scss']
})
export class EditCreatePriceGuideComponent implements OnInit {

  public priceGuideForm: FormGroup;

  constructor(private readonly dialogRef: MatDialogRef<EditCreatePriceGuideComponent>,
              private readonly notificationService: NotificationService,
              @Inject(MAT_DIALOG_DATA) public data: { priceGuide: IPriceGuide, isEdit: boolean }) {
    this.priceGuideForm = new UntypedFormGroup({
      hourlyRate: new UntypedFormControl(this.data.priceGuide.hourlyRate, [Validators.required, Validators.min(0.1)])
    })
  }

  ngOnInit(): void { }

  public hasError = (controlName: string, errorName: string) =>
    this.priceGuideForm?.controls[controlName].hasError(errorName);

  public onNoClick(): void {
    this.data.isEdit = false;
    this.dialogRef.close(this.data);
  }

  public save(): void {
    if (!this.priceGuideForm.valid) {
      this.notificationService.error(`Don't cheat!!!`)
      return;
    }
    const isEdit = this.data.isEdit;
    const priceGuideId = this.data.priceGuide.priceGuideId;
    this.data.isEdit = true;
    this.data.priceGuide = this.priceGuideForm?.value;
    if (isEdit) this.data.priceGuide = { ...this.data.priceGuide, priceGuideId }
    this.dialogRef.close(this.data);
  }

}
