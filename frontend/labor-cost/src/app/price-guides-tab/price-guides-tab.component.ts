import {AfterViewInit, Component, OnInit, ViewChild} from '@angular/core';
import {MatSort} from "@angular/material/sort";
import {MatTableDataSource} from "@angular/material/table";
import {IProfession} from "../professions-tab/profession.model";
import {IPriceGuide, PriceGuideModel} from "./price-guide.model";
import {catchError, map, Observable, of} from "rxjs";
import {PriceGuidesService} from "./price-guides.service";
import {MatDialog} from "@angular/material/dialog";
import {EditCreatePriceGuideComponent} from "./edit-create-price-guide/edit-create-price-guide.component";

@Component({
  selector: 'app-price-guides-tab',
  templateUrl: './price-guides-tab.component.html',
  styleUrls: ['./price-guides-tab.component.scss']
})
export class PriceGuidesTabComponent implements OnInit, AfterViewInit {

  @ViewChild(MatSort) sort: MatSort = new MatSort();

  public readonly columns: string[] = ['priceGuideId', 'hourlyRate', 'edit', 'delete']
  public readonly dataSource: MatTableDataSource<IPriceGuide> = new MatTableDataSource<IPriceGuide>([]);

  public readonly priceGuides$: Observable<IPriceGuide[]> = this.priceGuideService.priceGuidesSub$.asObservable();

  public readonly priceGuidesAsMatTableDataSource$: Observable<MatTableDataSource<IPriceGuide>> =
    this.priceGuides$.pipe(
      map(priceGuides => {
        this.dataSource.data = priceGuides;
        return this.dataSource;
      }),
      catchError(() => {
        this.dataSource.data = [];
        return of(this.dataSource);
      })
    )

  constructor(private readonly priceGuideService: PriceGuidesService,
              private readonly dialog: MatDialog) { }

  ngOnInit(): void {
    this.priceGuideService.loadPriceGuides();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
  }

  public editPriceGuide(priceGuide: IPriceGuide): void {
    this.dialog.open(EditCreatePriceGuideComponent, {
      data: { priceGuide, isEdit: true }
    }).afterClosed()
      .subscribe(data => data.isEdit && this.priceGuideService.editPriceGuide(data.priceGuide))
  }

  public createPriceGuide(): void {
    this.dialog.open(EditCreatePriceGuideComponent, {
      data: { priceGuide: new PriceGuideModel(-1, 0), isEdit: false }
    }).afterClosed()
      .subscribe(data => data.isEdit && this.priceGuideService.createPriceGuide(data.priceGuide))
  }

  public deletePriceGuide(priceGuideId: number): void {
    this.priceGuideService.deletePriceGuide(priceGuideId);
  }

}
