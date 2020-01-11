import getAddon from 'bindings';

const addon = getAddon('nodejs-ps');

export default function ps(): number[] {
  return addon.list();
}

export function psCount(): number {
  return addon.count();
}
