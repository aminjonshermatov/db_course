import {Component, OnInit, ViewChild} from '@angular/core';
import {MatSort} from "@angular/material/sort";
import {MatTableDataSource} from "@angular/material/table";
import {catchError, map, Observable, of} from "rxjs";
import {TasksService} from "../tasks.service";
import {IProfession} from "../../professions-tab/profession.model";

interface IColumn { key: string; label: string }

@Component({
  selector: 'app-task3',
  templateUrl: './task3.component.html',
  styleUrls: ['./task3.component.scss']
})
export class Task3Component implements OnInit {

  @ViewChild(MatSort) sort: MatSort = new MatSort();

  static make_column = (key: string, label: string): IColumn => ({ key, label });

  public readonly columns: IColumn[] = [
    Task3Component.make_column('professionId', 'Profession Id'),
    Task3Component.make_column('name', 'Name')
  ];
  public readonly columnsKey: string[] = this.columns.map(col => col.key);

  public readonly dataSource: MatTableDataSource<IProfession> = new MatTableDataSource<IProfession>([]);
  private readonly taskProfessions$: Observable<IProfession[]> = this.tasksService.task3ProfessionsSub$.asObservable();
  public readonly taskProfessionsAsMatTableDataSource$: Observable<MatTableDataSource<IProfession>> =
    this.taskProfessions$
      .pipe(
        map(professions => {
          this.dataSource.data = professions;
          return  this.dataSource;
        }),
        catchError(() => {
          this.dataSource.data = [];
          return of(this.dataSource);
        })
      )

  constructor(private readonly tasksService: TasksService) { }

  ngOnInit(): void {
    this.tasksService.loadProfessions();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
  }

}
