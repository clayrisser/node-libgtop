import { getNetload, getProclist } from '../src';

describe('getProclist()', () => {
  it('should list all pids', async () => {
    expect(getProclist()[0]).toBe(1);
  });
});

describe('getNetload()', () => {
  it('should get netload', async () => {
    expect(!!getNetload()).toBe(true);
  });
});
