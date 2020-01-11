import getAddon from 'bindings';
import { Netload } from './types';

const addon = getAddon('gtop');

export function getProclist(): number[] {
  return addon.getProclist();
}

export function getNetload(): Netload {
  return addon.getNetload();
}
