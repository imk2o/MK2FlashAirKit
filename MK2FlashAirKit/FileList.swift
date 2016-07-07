//
//  FileList.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/17.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

public struct FileListRequest: CommandAPIRequestType {
    public typealias Response = FileListResponse
    
    public let directory: String
    
    public var parameters: AnyObject? {
        return [
            "op": 100,
            "DIR": self.directory
        ]
    }
    
    public init(directory: String) {
        self.directory = directory
    }
}

public struct FileListResponse: ResponseStringDecodable {
    public let fileListItems: [FileListItem]

    public init(responseString: String) throws {
        let lines = responseString.componentsSeparatedByString("\r\n")
        //print(lines)
        
        var fileListItems = [FileListItem]()
        for line in lines.dropFirst() {
            guard
                !line.isEmpty,
                let fileListItem = try? FileListItem(responseString: line)
            else {
                continue
            }
            fileListItems.append(fileListItem)
        }
        self.fileListItems = fileListItems
    }
}

public struct FileListItem: ResponseStringDecodable {
    public struct Attributes: OptionSetType {
        public let rawValue: UInt8
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        public static let ReadOnly		= Attributes(rawValue: 0b00000001)
        public static let Hidden 		= Attributes(rawValue: 0b00000010)
        public static let System 		= Attributes(rawValue: 0b00000100)
        public static let Volume 		= Attributes(rawValue: 0b00001000)
        public static let Directory 	= Attributes(rawValue: 0b00010000)
        public static let Archive 		= Attributes(rawValue: 0b00100000)
    }
    
    public let directory: String
    public let fileName: String
    public let size: Int64
    public let attributes: Attributes
    public let date: NSDate

    public init(responseString: String) throws {
        let values = responseString.componentsSeparatedByString(",")
        guard values.count >= 6 else {
            throw Error.InvalidValue
        }
        
        self.directory = values[0]
        self.fileName = values[1]
        self.size = Int64(values[2]) ?? 0
        self.attributes = Attributes(rawValue: UInt8(values[3]) ?? 0)
        self.date = NSDate.from(
            dateValue: UInt16(values[4]) ?? 0,
            timeValue: UInt16(values[5]) ?? 0
        ) ?? NSDate()
    }
}

public extension FileListItem {
    public var isDirectory: Bool {
        return self.attributes.contains(.Directory)
    }
    
    public var path: String {
        return "\(self.directory)/\(self.fileName)"
    }

    public var fileURL: NSURL {
        return NSURL(string: "\(Constants.baseURL)\(self.path)")!
    }
    
    public var thumbnailURL: NSURL {
        return NSURL(string: "\(Constants.baseURL)\(Constants.thumbnailCGIPath)?\(self.path)")!
    }
}

private extension NSDate {
    static func from(dateValue dateValue: UInt16, timeValue: UInt16) -> NSDate? {
        let dateComponents = NSDateComponents()
        dateComponents.day = Int(dateValue & 0b0000000000011111)
        dateComponents.month = Int((dateValue >> 5) & 0b0000000000001111)
        dateComponents.year = Int((dateValue >> 9) & 0b0000000001111111) + 1980
        
        dateComponents.second = Int(timeValue & 0b0000000000011111) * 2
        dateComponents.minute = Int((timeValue >> 5) & 0b0000000000111111)
        dateComponents.hour = Int((timeValue >> 11) & 0b0000000000011111)
        //print(dateComponents)
        
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateFromComponents(dateComponents)
    }
}