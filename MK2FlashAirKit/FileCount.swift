//
//  FileCount.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct FileCountRequest: CommandAPIRequestType {
    public typealias Response = FileCountResponse
    
    public let directory: String
    
    public var parameters: AnyObject? {
        return [
            "op": 101,
            "DIR": self.directory
        ]
    }

    public init(directory: String) {
        self.directory = directory
    }
}

public struct FileCountResponse: ResponseStringDecodable {
    public let count: Int
    
    public init(responseString: String) throws {
        self.count = Int(responseString) ?? 0
    }
}
