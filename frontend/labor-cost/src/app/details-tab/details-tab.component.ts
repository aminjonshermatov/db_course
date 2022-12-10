import {AfterViewInit, Component, OnInit, ViewChild} from '@angular/core';
import {NotificationService} from "../notification.service";
import {catchError, map, Observable, of} from "rxjs";
import {IDetail} from "./detail.model";
import {DetailsService} from "./details.service";
import {MatTableDataSource} from "@angular/material/table";
import {MatSort} from "@angular/material/sort";

@Component({
  selector: 'app-details-tab',
  templateUrl: './details-tab.component.html',
  styleUrls: ['./details-tab.component.scss']
})
export class DetailsTabComponent implements OnInit, AfterViewInit {

  @ViewChild(MatSort) sort: MatSort = new MatSort();

  public readonly columns: string[] = ['detailId', 'type', 'name', 'measureUnit', 'price']
  public readonly dataSource: MatTableDataSource<IDetail> = new MatTableDataSource<IDetail>([]);

  public readonly details$: Observable<IDetail[]> = this.detailService.detailsSub$.asObservable();
  public readonly detailsAsMatTableDataSource$: Observable<MatTableDataSource<IDetail>> =
    this.details$.pipe(
      map(details => {
        this.dataSource.data = details;
        return this.dataSource;
      }),
      catchError(err => {
        this.dataSource.data = [];
        return of(this.dataSource);
      })
    );

  constructor(private readonly notificationService: NotificationService,
              private readonly detailService: DetailsService) { }

  ngOnInit(): void {
    this.detailService.loadDetails();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
  }

  public notify(isSuccess: boolean): void {
    if (isSuccess) this.notificationService.success("test");
    else this.notificationService.error("error lorem ipsum")
  }

}
