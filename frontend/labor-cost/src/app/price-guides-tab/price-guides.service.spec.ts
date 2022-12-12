import { TestBed } from '@angular/core/testing';

import { PriceGuidesService } from './price-guides.service';

describe('PriceGuidesService', () => {
  let service: PriceGuidesService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PriceGuidesService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
