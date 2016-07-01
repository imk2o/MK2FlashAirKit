//
//  StorageInfo.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/21.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct GetStorageInfoRequest: CommandAPIRequestType {
    public typealias Response = GetStorageInfoResponse
    
    public var parameters: AnyObject? {
        return [
            "op": 140
        ]
    }

    public init() {
    }
}

public struct GetStorageInfoResponse: ResponseStringDecodable {
    public let estimatedFreeSize: UInt64
    public let estimatedMaxSize: UInt64
    
    public init(responseString: String) throws {
        let values = responseString.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "/,"))
        guard values.count >= 3 else {
            throw Error.InvalidValue
        }
        
        let nFreeSectors = UInt64(values[0]) ?? 0
        let nMaxSectors = UInt64(values[1]) ?? 0
        let sectorSize = UInt64(values[2]) ?? 0
        
        self.estimatedFreeSize = nFreeSectors * sectorSize
        self.estimatedMaxSize = nMaxSectors * sectorSize
    }
}
