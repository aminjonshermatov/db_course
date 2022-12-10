import { Injectable } from '@angular/core';
import {MatSnackBar, MatSnackBarConfig} from "@angular/material/snack-bar";

@Injectable({
  providedIn: 'root'
})
export class NotificationService {

  private config: MatSnackBarConfig = {
    duration: 3000,
    horizontalPosition: "center",
    verticalPosition: "bottom",
  };

  constructor(private readonly snackBar: MatSnackBar) { }

  private _changeClasses(classList: string[]): void {
    this.config.panelClass = classList;
  }

  public success(msg: string): void {
    this._changeClasses(['success', 'notification']);
    this.snackBar.open(msg, 'Close', this.config);
  }

  public error(msg: string): void {
    this._changeClasses(['error', 'notification']);
    this.snackBar.open(msg, 'Close', this.config);
  }

  static _getErrorMsg(err?: any): string {
    return err?.error['detail'] || err?.message || 'Unknown error!';
  }

}
