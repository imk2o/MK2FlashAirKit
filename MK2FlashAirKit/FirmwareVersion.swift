//
//  FirmwareVersion.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct GetFirmwareVersionRequest: CommandAPIRequestType {
    public typealias Response = GetFirmwareVersionResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 108
        ]
    }

    public init() {
    }
}

public struct GetFirmwareVersionResponse: ResponseStringDecodable {
    public let version: String
    
    public init(responseString: String) throws {
        self.version = responseString
    }
}
