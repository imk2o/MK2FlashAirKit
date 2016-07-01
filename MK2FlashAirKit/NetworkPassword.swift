//
//  NetworkPassword.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct GetNetworkPasswordRequest: CommandAPIRequestType {
    public typealias Response = GetNetworkPasswordResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 105
        ]
    }
    
    public init() {
    }
}

public struct GetNetworkPasswordResponse: ResponseStringDecodable {
    public let password: String
    
    public init(responseString: String) throws {
        self.password = responseString
    }
}
