import {AfterViewInit, Component, OnInit, ViewChild} from '@angular/core';
import {MatSort} from "@angular/material/sort";
import {MatTableDataSource} from "@angular/material/table";
import {IDetail} from "../details-tab/detail.model";
import {IProfession, Profession} from "./profession.model";
import {catchError, map, Observable, of} from "rxjs";
import {ProfessionsService} from "./professions.service";
import {MatDialog} from "@angular/material/dialog";
import {EditCreateProfessionComponent} from "./edit-create-profession/edit-create-profession.component";

@Component({
  selector: 'app-professions-tab',
  templateUrl: './professions-tab.component.html',
  styleUrls: ['./professions-tab.component.scss']
})
export class ProfessionsTabComponent implements OnInit, AfterViewInit {

  @ViewChild(MatSort) sort: MatSort = new MatSort();

  public readonly columns: string[] = ['professionId', 'name', 'edit', 'delete']
  public readonly dataSource: MatTableDataSource<IProfession> = new MatTableDataSource<IProfession>([]);

  public readonly professions$: Observable<IProfession[]> = this.professionsService.professionsSub$.asObservable();

  public readonly professionsAsMatTableDataSource$: Observable<MatTableDataSource<IProfession>> =
    this.professions$.pipe(
      map(professions => {
        this.dataSource.data = professions;
        return this.dataSource;
      }),
      catchError(() => {
        this.dataSource.data = [];
        return of(this.dataSource);
      })
    )

  constructor(private readonly professionsService: ProfessionsService,
              private readonly dialog: MatDialog) { }

  ngOnInit(): void {
    this.professionsService.loadProfessions();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
  }

  public editProfession(profession: IProfession): void {
    this.dialog.open(EditCreateProfessionComponent, {
      data: { profession, isEdit: true }
    }).afterClosed()
      .subscribe(data => data.isEdit && this.professionsService.editProfession(data.profession))
  }

  public createProfession(): void {
    this.dialog.open(EditCreateProfessionComponent, {
      data: { profession: new Profession(-1, ''), isEdit: false }
    }).afterClosed()
      .subscribe(data => data.isEdit && this.professionsService.createProfession(data.profession))
  }

  public deleteProfession(professionId: number): void {
    this.professionsService.deleteProfession(professionId);
  }

}
