import {AfterViewInit, Component, OnInit, ViewChild} from '@angular/core';
import {BehaviorSubject, catchError, combineLatest, map, Observable, of, tap} from "rxjs";
import {MatSort} from "@angular/material/sort";
import {MatTableDataSource} from "@angular/material/table";
import {IOperationDetailed} from "../OperationDetailed.model";
import {TasksService} from "../tasks.service";

interface IColumn { key: string; label: string; }

@Component({
  selector: 'app-task1',
  templateUrl: './task1.component.html',
  styleUrls: ['./task1.component.scss']
})
export class Task1Component implements OnInit, AfterViewInit {

  @ViewChild(MatSort) sort: MatSort = new MatSort();

  static make_column = (key: string, label: string): IColumn => ({ key, label });

  public readonly columns: IColumn[] = [
    Task1Component.make_column('id', 'Operation Id'),
    Task1Component.make_column('detailId', 'Detail Id'),
    Task1Component.make_column('detailName', 'Detail Name'),
    Task1Component.make_column('price', 'Price'),
    Task1Component.make_column('hourlyRate', 'Hourly Rate'),
    Task1Component.make_column('professionName', 'Profession Name'),
  ];
  public readonly columnsKey: string[] = this.columns.map(col => col.key);

  public readonly isUseOrmSub$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);
  public readonly isUseOrm$: Observable<boolean> = this.isUseOrmSub$.asObservable();

  public readonly operationIdSub$: BehaviorSubject<number> = new BehaviorSubject<number>(1);
  public readonly operationId$: Observable<number> = this.operationIdSub$.asObservable();

  public readonly dataSource: MatTableDataSource<IOperationDetailed> = new MatTableDataSource<IOperationDetailed>([]);

  public readonly operationsDetailedAsMatTableDataSource$: Observable<MatTableDataSource<IOperationDetailed>> =
    combineLatest(
      this.isUseOrm$,
      this.operationId$
    )
    .pipe(
      tap(([isUseOrm, operationId]) => isUseOrm ? this.tasksService.loadOperationsDetailedOrm(operationId) : this.tasksService.loadOperationsDetailedRaw(operationId)),
      map(([isUseOrm, _]) => isUseOrm ? this.tasksService.operationsDetailedOrmSub$ : this.tasksService.operationsDetailedRawSub$),
      map(data$ => {
        this.dataSource.data = data$.value;
        return this.dataSource;
      }),
      catchError(() => {
        this.dataSource.data = [];
        return of(this.dataSource);
      })
    )

  constructor(private readonly tasksService: TasksService) { }

  ngOnInit(): void { }

  public onToggle(): void {
    this.isUseOrmSub$.next(!this.isUseOrmSub$.value);
  }

  public onChange($event: Event) {
    const searchQuery = ($event.target as HTMLInputElement).value?.trim();
    if (Number(searchQuery)) this.operationIdSub$.next(Number(searchQuery));
  }
  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
  }
}
