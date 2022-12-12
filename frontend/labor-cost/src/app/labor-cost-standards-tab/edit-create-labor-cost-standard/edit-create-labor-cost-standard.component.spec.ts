import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditCreateLaborCostStandardComponent } from './edit-create-labor-cost-standard.component';

describe('EditCreateLaborCostStandardComponent', () => {
  let component: EditCreateLaborCostStandardComponent;
  let fixture: ComponentFixture<EditCreateLaborCostStandardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EditCreateLaborCostStandardComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EditCreateLaborCostStandardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
