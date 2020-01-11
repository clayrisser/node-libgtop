import { getNetload, getProclist } from '../src';

describe('getProclist()', () => {
  it('should list all pids', async () => {
    expect(getProclist()[0]).toBe(1);
  });
});

describe('getNetload()', () => {
  it('should get netload', async () => {
    expect(getNetload('lo')).toMatchObject({
      address6: expect.any(Number),
      address: expect.any(Number),
      bytesIn: expect.any(Number),
      bytesOut: expect.any(Number),
      bytesTotal: expect.any(Number),
      collisions: expect.any(Number),
      errorsIn: expect.any(Number),
      errorsOut: expect.any(Number),
      errorsTotal: expect.any(Number),
      hwaddress: expect.any(Number),
      mtu: expect.any(Number),
      packetsIn: expect.any(Number),
      packetsOut: expect.any(Number),
      packetsTotal: expect.any(Number),
      prefix6: expect.any(Number),
      scope6: expect.any(Number),
      subnet: expect.any(Number)
    });
  });
});
