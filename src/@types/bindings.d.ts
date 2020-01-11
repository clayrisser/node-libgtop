declare interface Addon {
  getProclist(): number[];
  getNetload(): import('../types').Netload;
}

declare module 'bindings' {
  export default function getAddon(addonName: string): Addon;
}
