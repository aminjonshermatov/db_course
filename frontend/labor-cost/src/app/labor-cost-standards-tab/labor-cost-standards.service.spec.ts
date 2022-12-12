import { TestBed } from '@angular/core/testing';

import { LaborCostStandardsService } from './labor-cost-standards.service';

describe('LaborCostStandardsService', () => {
  let service: LaborCostStandardsService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(LaborCostStandardsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
