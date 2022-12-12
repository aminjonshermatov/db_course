import {Component, Inject, OnInit} from '@angular/core';
import {FormGroup, UntypedFormControl, UntypedFormGroup, Validators} from "@angular/forms";
import {MAT_DIALOG_DATA, MatDialogRef} from "@angular/material/dialog";
import {IProfession} from "../profession.model";
import {NotificationService} from "../../notification.service";

@Component({
  selector: 'app-edit-create-profession',
  templateUrl: './edit-create-profession.component.html',
  styleUrls: ['./edit-create-profession.component.scss']
})
export class EditCreateProfessionComponent implements OnInit {

  public professionForm: FormGroup;

  constructor(private readonly dialogRef: MatDialogRef<EditCreateProfessionComponent>,
              private readonly notificationService: NotificationService,
              @Inject(MAT_DIALOG_DATA) public data: { profession: IProfession, isEdit: boolean }) {
    this.professionForm = new UntypedFormGroup({
      name: new UntypedFormControl(this.data.profession.name, [Validators.required, Validators.max(60)])
    })
  }

  ngOnInit(): void { }

  public hasError = (controlName: string, errorName: string) =>
    this.professionForm?.controls[controlName].hasError(errorName);

  public onNoClick(): void {
    this.data.isEdit = false;
    this.dialogRef.close(this.data);
  }

  public save(): void {
    if (!this.professionForm.valid) {
      this.notificationService.error(`Don't cheat!!!`)
      return;
    }
    const isEdit = this.data.isEdit;
    const professionId = this.data.profession.professionId;
    this.data.isEdit = true;
    this.data.profession = this.professionForm?.value;
    if (isEdit) this.data.profession = { ...this.data.profession, professionId }
    this.dialogRef.close(this.data);
  }

}
