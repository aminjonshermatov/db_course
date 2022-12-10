import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditCreateDetailComponent } from './edit-create-detail.component';

describe('EditCreateDetailComponent', () => {
  let component: EditCreateDetailComponent;
  let fixture: ComponentFixture<EditCreateDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EditCreateDetailComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EditCreateDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
