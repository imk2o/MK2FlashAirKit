//
//  MACAddress.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct GetMACAddressRequest: CommandAPIRequestType {
    public typealias Response = GetMACAddressResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 106
        ]
    }
    
    public init() {
    }
}

public struct GetMACAddressResponse: ResponseStringDecodable {
    public let macAddress: String
    
    public init(responseString: String) throws {
        self.macAddress = responseString
    }
}
