import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {BehaviorSubject, Subject, tap} from "rxjs";
import {ILaborCostStandard, ILaborCostStandardPropagate} from "./labor-cost-standard.model";
import {HttpClient} from "@angular/common/http";
import {NotificationService} from "../notification.service";

@Injectable({
  providedIn: 'root'
})
export class LaborCostStandardsService {

  private readonly baseUrl: string = environment.baseUrl;

  public readonly laborCostStandardsSub$: BehaviorSubject<ILaborCostStandard[]> = new BehaviorSubject<ILaborCostStandard[]>([]);
  public readonly laborCostStandardsPropagateSub$: BehaviorSubject<ILaborCostStandardPropagate[]> = new BehaviorSubject<ILaborCostStandardPropagate[]>([]);
  public readonly selectedLaborCostStandardsSub$: Subject<ILaborCostStandard> = new Subject<ILaborCostStandard>();

  constructor(private readonly httpClient: HttpClient,
              private readonly notificationService: NotificationService) { }

  public loadLaborCostStandards(): void {
    this.httpClient.get<ILaborCostStandard[]>(`${this.baseUrl}/labor_cost_standards`)
      .pipe(
        tap(laborCostStandards => this.laborCostStandardsSub$.next(laborCostStandards))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public loadLaborCostStandardsPropagate(isFromView: boolean = false): void {
    this.httpClient.get<ILaborCostStandardPropagate[]>(`${this.baseUrl}/labor_cost_standards/propagate${isFromView ? '/view': ''}`)
      .pipe(
        tap(laborCostStandards => this.laborCostStandardsPropagateSub$.next(laborCostStandards))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public loadSelectedLaborCostStandard(operationId: number): void {
    this.httpClient.get<ILaborCostStandard>(`${this.baseUrl}/labor_cost_standards/${operationId}`)
      .pipe(
        tap(laborCostStandard => this.selectedLaborCostStandardsSub$.next(laborCostStandard))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public createLaborCostStandard(laborCostStandardToCreate: ILaborCostStandard): void {
    this.httpClient.post<ILaborCostStandard>(`${this.baseUrl}/labor_cost_standards`, laborCostStandardToCreate)
      .pipe(
        tap(createdLaborCostStandard => this.laborCostStandardsSub$.next([...this.laborCostStandardsSub$.value, createdLaborCostStandard]))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public editLaborCostStandard(laborCostStandardToUpdate: ILaborCostStandard): void {
    this.httpClient.put(`${this.baseUrl}/labor_cost_standards/${laborCostStandardToUpdate.operationId}`, laborCostStandardToUpdate)
      .pipe(
        tap(() => {
          this.laborCostStandardsSub$.next(
            [...this.laborCostStandardsSub$.value.filter(laborCostStandard => laborCostStandard.operationId != laborCostStandardToUpdate.operationId), laborCostStandardToUpdate]
          )
          this.laborCostStandardsPropagateSub$.next(
            [...this.laborCostStandardsPropagateSub$.value.map(laborCostStandard => laborCostStandard.operationId == laborCostStandardToUpdate.operationId ? { ...laborCostStandard, ...laborCostStandardToUpdate } : laborCostStandard)]
          )
        })
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public deleteLaborCostStandard(operationId: number): void {
    this.httpClient.delete(`${this.baseUrl}/labor_cost_standards/${operationId}`)
      .pipe(
        tap(() => {
          this.laborCostStandardsSub$.next([...this.laborCostStandardsSub$.value.filter(laborCostStandard => laborCostStandard.operationId != operationId)])
          this.laborCostStandardsPropagateSub$.next([...this.laborCostStandardsPropagateSub$.value.filter(laborCostStandard => laborCostStandard.operationId != operationId)])
        })
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

}
