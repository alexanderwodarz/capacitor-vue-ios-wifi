import { registerPlugin } from '@capacitor/core';

import type { WifiPluginPlugin } from './definitions';

const Wifi = registerPlugin<WifiPluginPlugin>('Wifi', {
  web: () => import('./web').then(m => new m.WifiPluginWeb()),
});


export * from './definitions';
export { Wifi };
