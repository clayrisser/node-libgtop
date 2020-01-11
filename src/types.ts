export interface Netload {
  address: number;
  address6: number;
  bytesIn: number;
  bytesOut: number;
  bytesTotal: number;
  collisions: number;
  errorsIn: number;
  errorsOut: number;
  errorsTotal: number;
  hwaddress: number;
  mtu: number;
  packetsIn: number;
  packetsOut: number;
  packetsTotal: number;
  prefix6: number;
  scope6: number;
  subnet: number;
}

export interface Uptime {
  bootTime: number;
  idletime: number;
  uptime: number;
}
