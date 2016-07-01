//
//  ConfigAPIRequestType.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/21.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation
import APIKit

public protocol ConfigAPIRequestType: FlashAirAPIRequestType {
}

public extension ConfigAPIRequestType {
    public var method: APIKit.HTTPMethod {
        return .GET
    }
    
    public var path: String {
        return Constants.configCGIPath
    }
}
