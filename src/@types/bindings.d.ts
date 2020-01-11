declare interface Addon {
  getNetload(iface: string): import('../types').Netload;
  getProclist(): number[];
  getUptime(): import('../types').Uptime;
}

declare module 'bindings' {
  export default function getAddon(addonName: string): Addon;
}
