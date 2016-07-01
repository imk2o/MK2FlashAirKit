//
//  SSID.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct GetSSIDRequest: CommandAPIRequestType {
    public typealias Response = GetSSIDResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 104
        ]
    }

    public init() {
    }
}

public struct GetSSIDResponse: ResponseStringDecodable {
    public let ssid: String
    
    public init(responseString: String) throws {
        self.ssid = responseString
    }
}
