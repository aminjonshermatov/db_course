import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {BehaviorSubject, Subject, tap} from "rxjs";
import {IDetail} from "./detail.model";
import {NotificationService} from "../notification.service";

@Injectable({
  providedIn: 'root'
})
export class DetailsService {

  private readonly baseUrl: string = environment.baseUrl;

  public readonly detailsSub$: BehaviorSubject<IDetail[]> = new BehaviorSubject<IDetail[]>([]);
  public readonly selectedDetailSub$: BehaviorSubject<IDetail | null> = new BehaviorSubject<IDetail | null>(null);
  public readonly mostExpensiveDetailSub$: Subject<number> = new Subject<number>();

  constructor(private readonly httpClient: HttpClient,
              private readonly notificationService: NotificationService) { }

  public loadDetails(): void {
    this.httpClient.get<IDetail[]>(`${this.baseUrl}/details`)
      .pipe(
        tap(details => this.detailsSub$.next(details))
      )
      .subscribe({
        error: err => {
          this.notificationService.error(NotificationService._getErrorMsg(err));
          this.detailsSub$.next([]);
        }
      })
  }

  public loadSelectedDetail(detailId: number): void {
    this.httpClient.get<IDetail>(`${this.baseUrl}/details/${detailId}`)
      .pipe(
        tap(detail => this.selectedDetailSub$.next(detail))
      )
      .subscribe({
        error: err => {
          this.notificationService.error(NotificationService._getErrorMsg(err));
          this.selectedDetailSub$.next(null);
        }
      })
  }

  public createDetail(detail: IDetail): void {
    this.httpClient.post<IDetail>(`${this.baseUrl}/details`, detail)
      .pipe(
        tap(createdDetail => this.detailsSub$.next([...this.detailsSub$.value, createdDetail]))
      )
      .subscribe({
        error: err => {
          this.notificationService.error(NotificationService._getErrorMsg(err));
          this.detailsSub$.next([]);
        }
      })
  }

  public editDetail(detailToUpdate: IDetail): void {
    this.httpClient.put<void>(`${this.baseUrl}/details/${detailToUpdate.detailId}`, detailToUpdate)
      .pipe(
        tap(_ => this.detailsSub$.next(
          [...this.detailsSub$.value.filter(detail => detail.detailId != detailToUpdate.detailId), detailToUpdate]
        ))
      )
      .subscribe({
        error: err => {
          console.log(err)
          this.notificationService.error(NotificationService._getErrorMsg(err));
          this.detailsSub$.next([]);
        }
      })
  }

  public deleteDetail(detailId: number): void {
    this.httpClient.delete(`${this.baseUrl}/details/${detailId}`)
      .pipe(
        tap(_ => this.detailsSub$.next([...this.detailsSub$.value.filter(detail => detail.detailId != detailId)]))
      )
      .subscribe({
        error: err => {
          this.notificationService.error(NotificationService._getErrorMsg(err));
          this.detailsSub$.next([]);
        }
      })
  }

  public loadMostExpensiveDetail(): void {
    this.httpClient.get<number>(`${this.baseUrl}/details/most_expensive_detail`)
      .pipe(
        tap(cost => this.mostExpensiveDetailSub$.next(cost))
      )
      .subscribe({
        error: err => {
          this.notificationService.error(NotificationService._getErrorMsg(err));
          this.mostExpensiveDetailSub$.next(0);
        }
      })
  }

}
