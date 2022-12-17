import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {NotificationService} from "../notification.service";
import {BehaviorSubject, tap} from "rxjs";
import {IOperationDetailed} from "./OperationDetailed.model";
import {IOperationWithAggregation} from "./OperationWithAggregation.model";
import {IProfession} from "../professions-tab/profession.model";

@Injectable({
  providedIn: 'root'
})
export class TasksService {

  private readonly baseUrl: string = environment.baseUrl;

  public readonly operationsDetailedRawSub$: BehaviorSubject<IOperationDetailed[]> = new BehaviorSubject<IOperationDetailed[]>([]);
  public readonly operationsDetailedOrmSub$: BehaviorSubject<IOperationDetailed[]> = new BehaviorSubject<IOperationDetailed[]>([]);
  public readonly operationsWithAggregationSub$: BehaviorSubject<IOperationWithAggregation[]> = new BehaviorSubject<IOperationWithAggregation[]>([]);
  public readonly task3ProfessionsSub$: BehaviorSubject<IProfession[]> = new BehaviorSubject<IProfession[]>([]);

  constructor(private readonly httpClient: HttpClient,
              private readonly notificationService: NotificationService) { }

  public loadOperationsDetailedRaw(operationId: number): void {
    this.httpClient.get<IOperationDetailed>(`${this.baseUrl}/tasks/1/raw/${operationId}`)
      .pipe(
        tap(operations => this.operationsDetailedRawSub$.next([operations]))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      });
  }

  public loadOperationsDetailedOrm(operationId: number): void {
    this.httpClient.get<IOperationDetailed>(`${this.baseUrl}/tasks/1/orm/${operationId}`)
      .pipe(
        tap(operations => this.operationsDetailedOrmSub$.next([operations]))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      });
  }

  public loadOperationWithAggregation(): void {
    this.httpClient.get<IOperationWithAggregation[]>(`${this.baseUrl}/tasks/2`)
      .pipe(
        tap(operations => this.operationsWithAggregationSub$.next(operations))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      });
  }

  public loadProfessions(): void {
    this.httpClient.get<IProfession[]>(`${this.baseUrl}/tasks/3`)
      .pipe(
        tap(professions => this.task3ProfessionsSub$.next(professions))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

}
