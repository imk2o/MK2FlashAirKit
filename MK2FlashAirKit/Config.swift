//
//  Config.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/21.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct ConfigRequest: ConfigAPIRequestType {
    public typealias Response = ConfigResponse
    
    public struct Values {
        public var timeout: NSTimeInterval?
        public var appInfo: String?
        public var wlanAwakeningMode: WLANAwakeningMode?
        public var networkKey: String?
        public var ssid: String?
        public var networkKeyForBridgeMode: String?
        public var ssidForBridgeMode: String?
        public var ciPath: String?
        //public var masterCode: String?
        
        public init(
            timeout: NSTimeInterval? = nil,
            appInfo: String? = nil,
            wlanAwakeningMode: WLANAwakeningMode? = nil,
            networkKey: String? = nil,
            ssid: String? = nil,
            networkKeyForBridgeMode: String? = nil,
            ssidForBridgeMode: String? = nil,
            ciPath: String? = nil
        ) {
            self.timeout = timeout
            self.appInfo = appInfo
            self.wlanAwakeningMode = wlanAwakeningMode
            self.networkKey = networkKey
            self.ssid = ssid
            self.networkKeyForBridgeMode = networkKeyForBridgeMode
            self.ssidForBridgeMode = ssidForBridgeMode
            self.ciPath = ciPath
        }
    }

    public let masterCode: String
    public let values: Values

    public var parameters: AnyObject? {
        var parameters = [String: AnyObject]()
        parameters["MASTERCODE"] = self.masterCode
        if let timeout = self.values.timeout {
            let msecTimeout = Int(timeout * 1000)
            parameters.updateValue(msecTimeout, forKey: "APPAUTOTIME")
        }
        parameters.updateValue(ifExists: self.values.appInfo, forKey: "APPINFO")
        parameters.updateValue(ifExists: self.values.wlanAwakeningMode?.rawValue, forKey: "APPMODE")
        parameters.updateValue(ifExists: self.values.networkKey, forKey: "APPNETWORKKEY")
        parameters.updateValue(ifExists: self.values.ssid, forKey: "APPSSID")
        parameters.updateValue(ifExists: self.values.networkKeyForBridgeMode, forKey: "BRGNETWORKKEY")
        parameters.updateValue(ifExists: self.values.ssidForBridgeMode, forKey: "BRGSSID")
        parameters.updateValue(ifExists: self.values.ciPath, forKey: "CIPATH")
        
        return parameters
    }
    
    public init(masterCode: String, values: Values) {
        self.masterCode = masterCode
        self.values = values
    }
}

public struct ConfigResponse: ResponseStringDecodable {
    public enum StatusCode: String {
        case Success = "SUCCESS"
        case Error = "ERROR"
    }
    public let statusCode: StatusCode
    
    public init(responseString: String) throws {
        self.statusCode = StatusCode(rawValue: responseString) ?? .Error
    }
}

private extension Dictionary {
    mutating func updateValue(ifExists value: Value?, forKey key: Key) {
        if let value = value {
            self.updateValue(value, forKey: key)
        }
    }
}