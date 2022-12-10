import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProfessionsTabComponent } from './professions-tab.component';

describe('ProfessionsTabComponent', () => {
  let component: ProfessionsTabComponent;
  let fixture: ComponentFixture<ProfessionsTabComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ProfessionsTabComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ProfessionsTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
