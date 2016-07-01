//
//  WLANTimeout.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct GetWLANTimeoutRequest: CommandAPIRequestType {
    public typealias Response = GetWLANTimeoutResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 111
        ]
    }

    public init() {
    }
}

public struct GetWLANTimeoutResponse: ResponseStringDecodable {
    public let timeout: NSTimeInterval
    
    public init(responseString: String) throws {
        let timeoutMilliSec = Int(responseString) ?? 0
        self.timeout = NSTimeInterval(timeoutMilliSec) / 1000.0
    }
}
