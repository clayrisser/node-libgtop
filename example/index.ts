import LibGTop from '../src';

const libGTop = new LibGTop();

console.log('netlist', libGTop.netlist);
console.log('netload (lo)', libGTop.getNetload('lo'));
console.log('procArgs (1)', libGTop.getProcArgs(1));
console.log('proclist', libGTop.proclist);
console.log('uptime', libGTop.uptime);
