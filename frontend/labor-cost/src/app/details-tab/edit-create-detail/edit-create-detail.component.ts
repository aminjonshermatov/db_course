import {Component, Inject, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatDialogRef} from "@angular/material/dialog";
import {DetailType, IDetail} from "../detail.model";
import {FormGroup, UntypedFormControl, UntypedFormGroup, Validators} from "@angular/forms";

@Component({
  selector: 'app-edit-create-detail',
  templateUrl: './edit-create-detail.component.html',
  styleUrls: ['./edit-create-detail.component.scss']
})
export class EditCreateDetailComponent implements OnInit {

  public detailForm: FormGroup;

  constructor(private readonly dialogRef: MatDialogRef<EditCreateDetailComponent>,
              @Inject(MAT_DIALOG_DATA) public data: { detail: IDetail, isEdit: boolean }) {
    this.detailForm = new UntypedFormGroup({
      name: new UntypedFormControl(this.data.detail.name, [Validators.required]),
      type: new UntypedFormControl(this.data.detail.type),
      price: new UntypedFormControl(this.data.detail.price, [Validators.required, Validators.min(0.1)]),
      measureUnit: new UntypedFormControl(this.data.detail.measureUnit, [Validators.required])
    });
  }

  ngOnInit(): void { }

  public hasError = (controlName: string, errorName: string) =>
    this.detailForm?.controls[controlName].hasError(errorName);

  public getDetailTypes = () => [DetailType.PURCHASED, DetailType.IN_HOUSE]

  public onNoClick(): void {
    this.data.isEdit = false;
    this.dialogRef.close(this.data);
  }

  public save(): void {
    const isEdit = this.data.isEdit;
    const detailId = this.data.detail.detailId;
    this.data.isEdit = true;
    this.data.detail = this.detailForm?.value;
    if (isEdit) this.data.detail = { ...this.data.detail, detailId }
    this.dialogRef.close(this.data);
  }
}
