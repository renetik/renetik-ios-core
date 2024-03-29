//
//  CSNetwork.swift
//  Renetik
//
//  Created by Rene Dohan on 2/21/19.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

public class CSNetwork: NSObject {
    @available(macCatalyst 14, *)
    @objc public class var SSID: String? {
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo =
                    CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    return interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                }
            }
        }
        return nil
    }
}
