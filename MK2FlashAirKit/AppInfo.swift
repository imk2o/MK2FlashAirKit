//
//  AppInfo.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct GetAppInfoRequest: CommandAPIRequestType {
    public typealias Response = GetAppInfoResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 117
        ]
    }

    public init() {
    }
}

public struct GetAppInfoResponse: ResponseStringDecodable {
    public let appInfo: String
    
    public init(responseString: String) throws {
        self.appInfo = responseString
    }
}
