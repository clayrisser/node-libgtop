import getAddon from 'bindings';
import { Netload, Uptime } from './types';

const addon = getAddon('gtop');

export default class LibGTop {
  get proclist(): number[] {
    return addon.getProclist();
  }

  get uptime(): Uptime {
    return addon.getUptime();
  }

  get netlist(): string[] {
    return addon.getNetlist();
  }

  getNetload(iface: string): Netload {
    return addon.getNetload(iface);
  }
}
