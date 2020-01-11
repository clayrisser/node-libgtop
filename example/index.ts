import LibGTop from '../src';

const libGTop = new LibGTop();

console.log('netlist', libGTop.netlist);
console.log('netload (lo)', libGTop.getNetload('lo'));
console.log('procArgs (1)', libGTop.getProcArgs(1));
console.log('proclist', libGTop.proclist);
console.log('uptime', libGTop.uptime);

function getNodeProcesses(): number[] {
  const libGTop = new LibGTop();
  const pids: number[] = [];
  libGTop.proclist.forEach((pid: number) => {
    const args = libGTop.getProcArgs(pid);
    if (args.indexOf('node') > -1) pids.push(pid);
  });
  return pids;
}

console.log('Node Processes', getNodeProcesses());
