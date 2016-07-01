//
//  Uplodable.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct IsUploadableRequest: CommandAPIRequestType {
    public typealias Response = IsUploadableResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 118
        ]
    }

    public init() {
    }
}

public struct IsUploadableResponse: ResponseStringDecodable {
    public let uploadable: Bool
    
    public init(responseString: String) throws {
        self.uploadable = (Int(responseString) ?? 0) == 1
    }
}
