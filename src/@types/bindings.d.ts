declare interface Addon {
  getNetlist(): string[];
  getNetload(iface: string): import('../types').Netload;
  getProcArgs(pid: number): string;
  getProclist(): number[];
  getUptime(): import('../types').Uptime;
}

declare module 'bindings' {
  export default function getAddon(addonName: string): Addon;
}
