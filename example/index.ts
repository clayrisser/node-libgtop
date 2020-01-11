import LibGTop from '../src';

const libGTop = new LibGTop();

console.log('netload (lo)', libGTop.getNetload('lo'));
console.log('proclist', libGTop.proclist);
console.log('uptime', libGTop.uptime);
