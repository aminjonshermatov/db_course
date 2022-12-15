import {AfterViewInit, Component, OnInit, ViewChild} from '@angular/core';
import {MatSort} from "@angular/material/sort";
import {catchError, map, Observable, of} from "rxjs";
import {IOperationWithAggregation} from "../OperationWithAggregation.model";
import {TasksService} from "../tasks.service";
import {MatTableDataSource} from "@angular/material/table";

interface IColumn { key: string; label: string; }

@Component({
  selector: 'app-task2',
  templateUrl: './task2.component.html',
  styleUrls: ['./task2.component.scss']
})
export class Task2Component implements OnInit, AfterViewInit {

  @ViewChild(MatSort) sort: MatSort = new MatSort();

  static make_column = (key: string, label: string): IColumn => ({ key, label });

  public readonly columns: IColumn[] = [
    Task2Component.make_column('detailId', 'Detail Id'),
    Task2Component.make_column('operationId', 'Operation Id'),
    Task2Component.make_column('professionName', 'Profession Name'),
    Task2Component.make_column('operationsCount', 'Operations Count'),
    Task2Component.make_column('minQualification', 'Min Qualification'),
  ];
  public readonly columnsKey: string[] = this.columns.map(col => col.key);

  public readonly dataSource: MatTableDataSource<IOperationWithAggregation> = new MatTableDataSource<IOperationWithAggregation>([]);
  private readonly operationsWithAggregation$: Observable<IOperationWithAggregation[]> = this.tasksService.operationsWithAggregationSub$.asObservable();
  public readonly operationsWithAggregationAsMatTableDataSource$: Observable<MatTableDataSource<IOperationWithAggregation>> =
    this.operationsWithAggregation$
      .pipe(
        map(operations => {
          this.dataSource.data = operations;
          return  this.dataSource;
        }),
        catchError(() => {
          this.dataSource.data = [];
          return of(this.dataSource);
        })
      )

  constructor(private readonly tasksService: TasksService) { }

  ngOnInit(): void {
    this.tasksService.loadOperationWithAggregation();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
  }

}
