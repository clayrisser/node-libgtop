declare interface Addon {
  getProclist(): number[];
  getNetload(iface: string): import('../types').Netload;
}

declare module 'bindings' {
  export default function getAddon(addonName: string): Addon;
}
