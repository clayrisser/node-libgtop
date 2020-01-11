import getAddon from 'bindings';

const addon = getAddon('node-ps-sync');

export default function ps(): number[] {
  return addon.list();
}

export function psCount(): number {
  return addon.count();
}
