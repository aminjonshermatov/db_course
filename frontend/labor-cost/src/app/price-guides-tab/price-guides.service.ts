import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {BehaviorSubject, Subject, tap} from "rxjs";
import {IPriceGuide} from "./price-guide.model";
import {HttpClient} from "@angular/common/http";
import {NotificationService} from "../notification.service";

@Injectable({
  providedIn: 'root'
})
export class PriceGuidesService {

  private readonly baseUrl: string = environment.baseUrl;

  public readonly priceGuidesSub$: BehaviorSubject<IPriceGuide[]> = new BehaviorSubject<IPriceGuide[]>([]);

  public readonly selectedPriceGuideSub$: Subject<IPriceGuide> = new Subject<IPriceGuide>();

  constructor(private readonly httpClient: HttpClient,
              private readonly notificationService: NotificationService) { }

  public loadPriceGuides(): void {
    this.httpClient.get<IPriceGuide[]>(`${this.baseUrl}/price_guides`)
      .pipe(
        tap(priceGuides => this.priceGuidesSub$.next(priceGuides))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public loadSelectedPriceGuide(priceGuideId: number): void {
    this.httpClient.get<IPriceGuide>(`${this.baseUrl}/price_guides/${priceGuideId}`)
      .pipe(
        tap(priceGuide => this.selectedPriceGuideSub$.next(priceGuide))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public createPriceGuide(priceGuideToCreate: IPriceGuide): void {
    this.httpClient.post<IPriceGuide>(`${this.baseUrl}/price_guides`, priceGuideToCreate)
      .pipe(
        tap(createdPriceGuide => this.priceGuidesSub$.next([...this.priceGuidesSub$.value, createdPriceGuide]))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public editPriceGuide(priceGuideToUpdate: IPriceGuide): void {
    this.httpClient.put(`${this.baseUrl}/price_guides/${priceGuideToUpdate.priceGuideId}`, priceGuideToUpdate)
      .pipe(
        tap(() => this.priceGuidesSub$.next(
          [...this.priceGuidesSub$.value.filter(priceGuide => priceGuide.priceGuideId != priceGuideToUpdate.priceGuideId), priceGuideToUpdate]
        ))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

  public deletePriceGuide(priceGuideId: number): void {
    this.httpClient.delete(`${this.baseUrl}/price_guides/${priceGuideId}`)
      .pipe(
        tap(() => this.priceGuidesSub$.next([...this.priceGuidesSub$.value.filter(priceGuide => priceGuide.priceGuideId != priceGuideId)]))
      )
      .subscribe({
        error: err => this.notificationService.error(NotificationService._getErrorMsg(err))
      })
  }

}
