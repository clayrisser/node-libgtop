import ps, { psCount } from '../src';

describe('ps()', () => {
  it('should list all pids', async () => {
    expect(ps().length).toBe(psCount());
  });
});
