//
//  AppMode.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public enum WLANAwakeningMode: Int {
    case APModeOnUnlock = 0
    case STAModeOnUnlock = 2
    case BridgeModeOnUnlock = 3
    case APModeOnBoot = 4
    case STAModeOnBoot = 5
    case BridgeModeOnBoot = 6
}

public struct GetWLANAwakeningModeRequest: CommandAPIRequestType {
    public typealias Response = GetWLANAwakeningModeResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 110
        ]
    }

    public init() {
    }
}

public struct GetWLANAwakeningModeResponse: ResponseStringDecodable {
    public let wlanAwakeningMode: WLANAwakeningMode
    
    public init(responseString: String) throws {
        self.wlanAwakeningMode = WLANAwakeningMode(rawValue: Int(responseString) ?? 0)!
    }
}
