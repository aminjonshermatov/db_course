import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditCreatePriceGuideComponent } from './edit-create-price-guide.component';

describe('EditCreatePriceGuideComponent', () => {
  let component: EditCreatePriceGuideComponent;
  let fixture: ComponentFixture<EditCreatePriceGuideComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EditCreatePriceGuideComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EditCreatePriceGuideComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
