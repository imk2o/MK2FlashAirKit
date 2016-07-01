//
//  Common.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/17.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation
import APIKit

internal class Constants {
    static let baseURL = "http://flashair"
    static let commandCGIPath = "/command.cgi"
    static let configCGIPath = "/config.cgi"
    static let thumbnailCGIPath = "/thumbnail.cgi"
}

public protocol FlashAirAPIRequestType: APIKit.RequestType {
    
}

public extension FlashAirAPIRequestType {
    var baseURL: NSURL {
        return NSURL(string: Constants.baseURL)!
    }
    
    var dataParser: APIKit.DataParserType {
        return StringDataParser()
    }
}

public extension FlashAirAPIRequestType where Response: ResponseStringDecodable {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Self.Response {
        return try Response(responseString: object as! String)
    }
}

public enum Error: ErrorType {
    case InvalidValue
}

public protocol ResponseStringDecodable {
    init(responseString: String) throws
}

public typealias Session = APIKit.Session
