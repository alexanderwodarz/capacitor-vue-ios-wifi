import type { removeSSID, wifiSettings } from './web';

export interface WifiPluginPlugin {
  connectWifi(filter: wifiSettings): Promise<{results: any[]}>;
  list(): Promise<{results: any[]}>;
  remove(filter: removeSSID): Promise<{results: any[]}>;
}

export {};