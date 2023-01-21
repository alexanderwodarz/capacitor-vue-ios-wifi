import Foundation
import Capacitor
import NetworkExtension

@objc(WifiPlugin)
public class WifiPlugin: CAPPlugin {
    private let implementation = Wifi()
    
    @objc func list(_ call: CAPPluginCall) {
        NEHotspotConfigurationManager().getConfiguredSSIDs(){ ssids in
            call.resolve(["ssids": ssids])
        }
    }
    
    @objc func remove(_ call: CAPPluginCall) {
        let ssid = call.getString("ssid") ?? ""
        if(ssid.count == 0){
            call.reject("ssid is empty")
            return
        }
        NEHotspotConfigurationManager().removeConfiguration(forSSID: ssid)
    }
    
    @objc func connectWifi(_ call: CAPPluginCall) {
        let ssid = call.getString("ssid") ?? ""
        let password = call.getString("password") ?? ""
        let isWEP = call.getBool("isWEP") ?? false
        let once = call.getBool("once") ?? true
        if(ssid.count == 0){
            call.reject("ssid is empty")
            return
        }
        let config = NEHotspotConfiguration(ssid: ssid, passphrase: password, isWEP: isWEP)
        if(once){
            config.joinOnce = true
        }
        let manager = NEHotspotConfigurationManager()
        manager.apply(config) { (error) in
            if error != nil {
                if error?.localizedDescription == "already associated."{
                    print("Connected")
                    call.resolve(["connected":true])
                    return
                }else{
                    print("No Connected")
                    call.reject(error!.localizedDescription)
                    return
                }
            }
            else {
                print("Connected")
                call.resolve(["connected":true])
                return
            }
        }
    }
}
