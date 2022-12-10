import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LaborCostStandardsTabComponent } from './labor-cost-standards-tab.component';

describe('LaborCostStandardsTabComponent', () => {
  let component: LaborCostStandardsTabComponent;
  let fixture: ComponentFixture<LaborCostStandardsTabComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LaborCostStandardsTabComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LaborCostStandardsTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
