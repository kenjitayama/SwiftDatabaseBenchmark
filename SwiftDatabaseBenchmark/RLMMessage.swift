//
//  RLMMessage.swift
//  SwiftDatabaseBenchmark
//
//  Created by Kenji Tayama on 2016/03/14.
//  Copyright © 2016年 Kenji Tayama. All rights reserved.
//

import Foundation
import RealmSwift

public final class RLMMessage: Object {
    
    public dynamic var identifier: Int64 = 0
    public dynamic var identifierDate: NSDate = NSDate(timeIntervalSince1970: 0)
    public dynamic var text: String?
    public dynamic var removed: Bool = false
    
    public override class func primaryKey() -> String? {
        return "identifier"
    }
    
    public override class func indexedProperties() -> [String] {
        return ["identifier", "identifierDate", "removed"]
    }
    
}