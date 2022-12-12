import { TestBed } from '@angular/core/testing';

import { ProfessionsService } from './professions.service';

describe('ProfessionsService', () => {
  let service: ProfessionsService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ProfessionsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
