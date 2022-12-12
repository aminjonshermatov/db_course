import {AfterViewInit, Component, OnInit, TemplateRef, ViewChild} from '@angular/core';
import {catchError, map, Observable, of, tap} from "rxjs";
import {Detail, DetailType, IDetail} from "./detail.model";
import {DetailsService} from "./details.service";
import {MatTableDataSource} from "@angular/material/table";
import {MatSort} from "@angular/material/sort";
import {MatDialog, MatDialogRef} from "@angular/material/dialog";
import {EditCreateDetailComponent} from "./edit-create-detail/edit-create-detail.component";

@Component({
  selector: 'app-details-tab',
  templateUrl: './details-tab.component.html',
  styleUrls: ['./details-tab.component.scss']
})
export class DetailsTabComponent implements OnInit, AfterViewInit {

  @ViewChild(MatSort) sort: MatSort = new MatSort();
  @ViewChild('most_expensive_detail_dialog') expensiveDetailDialog?: TemplateRef<any>;

  private expensiveDetailDialogRef?: MatDialogRef<any>;

  public readonly columns: string[] = ['detailId', 'name', 'type', 'price', 'measureUnit', 'edit', 'delete']
  public readonly dataSource: MatTableDataSource<IDetail> = new MatTableDataSource<IDetail>([]);

  public readonly details$: Observable<IDetail[]> = this.detailService.detailsSub$.asObservable();
  public readonly detailsAsMatTableDataSource$: Observable<MatTableDataSource<IDetail>> =
    this.details$.pipe(
      map(details => {
        this.dataSource.data = details;
        return this.dataSource;
      }),
      catchError(() => {
        this.dataSource.data = [];
        return of(this.dataSource);
      })
    );
  public readonly mostExpensiveDetail$: Observable<number> = this.detailService.mostExpensiveDetailSub$.asObservable();

  constructor(private readonly detailService: DetailsService,
              private readonly dialog: MatDialog) { }

  ngOnInit(): void {
    this.detailService.loadDetails();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
  }

  public editDetail(detail: IDetail): void {
    this.dialog.open(EditCreateDetailComponent, {
      data: {detail, isEdit: true},
    }).afterClosed()
      .subscribe(data => data.isEdit && this.detailService.editDetail(data.detail));
  }

  public createDetail(): void {
    this.dialog.open(EditCreateDetailComponent, {
      data: {detail: new Detail(-1, DetailType.PURCHASED, '', '', 0), isEdit: false},
    }).afterClosed()
      .subscribe(data => data.isEdit && this.detailService.createDetail(data.detail));
  }

  public deleteDetail(detailId: number): void {
    this.detailService.deleteDetail(detailId);
  }

  public loadMostExpensiveDetail(): void {
    this.detailService.loadMostExpensiveDetail();
    this.expensiveDetailDialogRef = this.dialog.open(this.expensiveDetailDialog!);
  }

  public closeExpensiveDialog(): void {
    this.expensiveDetailDialogRef?.close();
  }

}
