//
//  Updated.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct IsUpdatedRequest: CommandAPIRequestType {
    public typealias Response = IsUpdatedResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 102
        ]
    }

    public init() {
    }
}

public struct IsUpdatedResponse: ResponseStringDecodable {
    public let updated: Bool
    
    public init(responseString: String) throws {
        self.updated = (Int(responseString) ?? 0) == 1
    }
}

public struct GetUpdatedTimeRequest: CommandAPIRequestType {
    public typealias Response = GetUpdatedTimeResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 121
        ]
    }

    public init() {
    }
}

public struct GetUpdatedTimeResponse: ResponseStringDecodable {
    public let timeIntervalSinceBoot: NSTimeInterval

    public init(responseString: String) throws {
        self.timeIntervalSinceBoot = NSTimeInterval(Int(responseString) ?? 0) / 1000.0
    }
}
