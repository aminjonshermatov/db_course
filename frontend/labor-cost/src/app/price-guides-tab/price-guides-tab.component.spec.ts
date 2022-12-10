import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PriceGuidesTabComponent } from './price-guides-tab.component';

describe('PriceGuidesTabComponent', () => {
  let component: PriceGuidesTabComponent;
  let fixture: ComponentFixture<PriceGuidesTabComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PriceGuidesTabComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PriceGuidesTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
