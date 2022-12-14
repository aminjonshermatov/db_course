import {AfterViewInit, Component, OnInit, ViewChild} from '@angular/core';
import {MatSort} from "@angular/material/sort";
import {BehaviorSubject, catchError, flatMap, map, Observable, of} from "rxjs";
import {LaborCostStandardsService} from "./labor-cost-standards.service";
import {MatDialog} from "@angular/material/dialog";
import {MatTableDataSource} from "@angular/material/table";
import {ILaborCostStandard, ILaborCostStandardPropagate, LaborCostStandard} from "./labor-cost-standard.model";
import {MatSlideToggleChange} from "@angular/material/slide-toggle";
import {
  EditCreateLaborCostStandardComponent
} from "./edit-create-labor-cost-standard/edit-create-labor-cost-standard.component";

interface IColumn {
  key: string;
  label: string;
  withPropagate: boolean;
}

@Component({
  selector: 'app-labor-cost-standards-tab',
  templateUrl: './labor-cost-standards-tab.component.html',
  styleUrls: ['./labor-cost-standards-tab.component.scss']
})
export class LaborCostStandardsTabComponent implements OnInit, AfterViewInit {

  static make_column = (key: string, label: string, withPropagate: boolean): IColumn => ({ key, label, withPropagate });

  @ViewChild(MatSort) sort: MatSort = new MatSort();

  private static readonly columns: IColumn[] = [
    LaborCostStandardsTabComponent.make_column('operationId', 'Operation Id', false),
    LaborCostStandardsTabComponent.make_column('detailId', 'Detail Id', false),
    LaborCostStandardsTabComponent.make_column('detailType', 'Detail Type', true),
    LaborCostStandardsTabComponent.make_column('detailName', 'Detail Name', true),
    LaborCostStandardsTabComponent.make_column('detailMeasureUnit', 'Detail measure unit', true),
    LaborCostStandardsTabComponent.make_column('detailPrice', 'Detail price', true),
    LaborCostStandardsTabComponent.make_column('professionId', 'Profession Id', false),
    LaborCostStandardsTabComponent.make_column('professionName', 'Profession Name', true),
    LaborCostStandardsTabComponent.make_column('priceGuideId', 'Price Guide Id', false),
    LaborCostStandardsTabComponent.make_column('priceGuideHourlyRate', 'Price Guide Hourly Rate', true),
    LaborCostStandardsTabComponent.make_column('qualification', 'Qualification', false),
    LaborCostStandardsTabComponent.make_column('preparatoryTime', 'Preparatory Time', false),
    LaborCostStandardsTabComponent.make_column('pieceTime', 'Piece Time', false),
  ];

  private readonly withPropagateSub$: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);
  public readonly withPropagate$: Observable<boolean> = this.withPropagateSub$.asObservable();

  public readonly columns$ = this.withPropagateSub$.pipe(
    map(withPropagate => LaborCostStandardsTabComponent.columns.filter(column => !column.withPropagate || column.withPropagate == withPropagate))
  );
  public readonly columnsKey$: Observable<string[]> = this.columns$.pipe(
    map(columns => [...columns.map(column => column.key), 'edit', 'delete'])
  )

  public readonly dataSource: MatTableDataSource<ILaborCostStandard | ILaborCostStandardPropagate> = new MatTableDataSource<ILaborCostStandard | ILaborCostStandardPropagate>([]);

  public readonly laborCostStandards$: Observable<ILaborCostStandard[]> = this.laborCostStandardsService.laborCostStandardsSub$.asObservable();
  public readonly laborCostStandardsPropagate$: Observable<ILaborCostStandardPropagate[]> = this.laborCostStandardsService.laborCostStandardsPropagateSub$.asObservable();

  public readonly laborCostStandardsAsMatTableDataSource$: Observable<MatTableDataSource<ILaborCostStandard | ILaborCostStandardPropagate>> =
    this.withPropagateSub$.pipe(
      flatMap(withPropagate => withPropagate ? this.laborCostStandardsPropagate$ : this.laborCostStandards$),
      map(laborCostStandards => {
        this.dataSource.data = laborCostStandards;
        return this.dataSource;
      }),
      catchError(() => {
        this.dataSource.data = [];
        return of(this.dataSource);
      })
    )

  constructor(private readonly laborCostStandardsService: LaborCostStandardsService,
              private readonly dialog: MatDialog) { }

  ngOnInit(): void {
    this.laborCostStandardsService.loadLaborCostStandards();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
  }

  public editLaborCostStandard(laborCostStandard: ILaborCostStandard | ILaborCostStandardPropagate): void {
    this.dialog.open(EditCreateLaborCostStandardComponent, {
      data: { laborCostStandard, isEdit: true }
    }).afterClosed()
      .subscribe(data => data.isEdit && this.laborCostStandardsService.editLaborCostStandard(data.laborCostStandard));
  }

  public createLaborCostStandard(): void {
    this.dialog.open(EditCreateLaborCostStandardComponent, {
      data: { laborCostStandard: new LaborCostStandard(1, 1, 1, -1, 1, 0, 0), isEdit: false }
    }).afterClosed()
      .subscribe(data => {
        if (data.isEdit) {
          this.laborCostStandardsService.createLaborCostStandard(data.laborCostStandard);
          if (this.withPropagateSub$.value) this.laborCostStandardsService.loadLaborCostStandardsPropagate();
        }
      })
  }

  public deleteLaborCostStandard(operationId: number): void {
    this.laborCostStandardsService.deleteLaborCostStandard(operationId);
  }

  public onToggle(ev: MatSlideToggleChange): void {
    this.withPropagateSub$.next(ev.checked);
    if (ev.checked) this.laborCostStandardsService.loadLaborCostStandardsPropagate();
    else this.laborCostStandardsService.loadLaborCostStandards();
  }
}
