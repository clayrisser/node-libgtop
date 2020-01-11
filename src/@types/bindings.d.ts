declare interface HelloAddon {
  count(): number;
  list(): number[];
}

declare module 'bindings' {
  export default function getAddon(addonName: string): HelloAddon;
}
