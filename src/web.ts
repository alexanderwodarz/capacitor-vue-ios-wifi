import { WebPlugin,registerPlugin } from '@capacitor/core';

import type { WifiPluginPlugin } from './definitions';

export class WifiPluginWeb extends WebPlugin implements WifiPluginPlugin {


  connectWifi(filter: wifiSettings): Promise<{ results: any[] }> {
    console.log(filter)
    return Promise.resolve({ results: [] });
  }

  list(): Promise<{ results: any[] }> {
    return Promise.resolve({ results: [] });
  }

  remove(filter: removeSSID): Promise<{ results: any[] }> {
    console.log(filter)
    return Promise.resolve({ results: [] });
  }
}

export interface wifiSettings {
  ssid: string,
  password: string,
  isWEP: boolean,
  once: boolean
}

export interface removeSSID {
  ssid: string
}

const Wifi = registerPlugin('WifiPlugin', {
  web: () => import('./web').then(m => new m.WifiPluginWeb()),
});
export {Wifi}