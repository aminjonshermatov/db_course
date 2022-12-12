import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {NotificationService} from "../notification.service";
import {BehaviorSubject, Subject, tap} from "rxjs";
import {IProfession} from "./profession.model";

@Injectable({
  providedIn: 'root'
})
export class ProfessionsService {

  private readonly baseUrl: string = environment.baseUrl;

  public readonly professionsSub$: BehaviorSubject<IProfession[]> = new BehaviorSubject<IProfession[]>([]);
  public readonly selectedProfessionSub$: Subject<IProfession> = new Subject<IProfession>();

  constructor(private readonly httpClient: HttpClient,
              private readonly notificationService: NotificationService) { }

  public loadProfessions(): void {
    this.httpClient.get<IProfession[]>(`${this.baseUrl}/professions`)
      .pipe(
        tap(professions => this.professionsSub$.next(professions))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public loadSelectedProfession(professionId: number): void {
    this.httpClient.get<IProfession>(`${this.baseUrl}/professions/${professionId}`)
      .pipe(
        tap(profession => this.selectedProfessionSub$.next(profession))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public createProfession(professionToCreate: IProfession): void {
    this.httpClient.post<IProfession>(`${this.baseUrl}/professions`, professionToCreate)
      .pipe(
        tap(createdProfession => this.professionsSub$.next([...this.professionsSub$.value, createdProfession]))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public editProfession(professionToUpdate: IProfession): void {
    this.httpClient.put(`${this.baseUrl}/professions/${professionToUpdate.professionId}`, professionToUpdate)
      .pipe(
        tap(_ => this.professionsSub$.next(
          [...this.professionsSub$.value.filter(profession => profession.professionId != professionToUpdate.professionId), professionToUpdate]
        ))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public deleteProfession(professionId: number): void {
    this.httpClient.delete(`${this.baseUrl}/professions/${professionId}`)
      .pipe(
        tap(_ => this.professionsSub$.next([...this.professionsSub$.value.filter(profession => profession.professionId != professionId)]))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

}
