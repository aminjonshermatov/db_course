import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditCreateProfessionComponent } from './edit-create-profession.component';

describe('EditCreateProfessionComponent', () => {
  let component: EditCreateProfessionComponent;
  let fixture: ComponentFixture<EditCreateProfessionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EditCreateProfessionComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EditCreateProfessionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
