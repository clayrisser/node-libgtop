import LibGTop from '../src';

describe('new LibGTop().proclist', () => {
  it('should list all pids', async () => {
    expect(new LibGTop().proclist[0]).toBe(1);
  });
});

describe('new LibGTop().getNetload(interface)', () => {
  it('should get netload', async () => {
    expect(new LibGTop().getNetload('lo')).toMatchObject({
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

describe('new LibGTop().uptime', () => {
  it('should get netload', async () => {
    expect(new LibGTop().uptime).toMatchObject({
      bootTime: expect.any(Number),
      idletime: expect.any(Number),
      uptime: expect.any(Number)
    });
  });
});
