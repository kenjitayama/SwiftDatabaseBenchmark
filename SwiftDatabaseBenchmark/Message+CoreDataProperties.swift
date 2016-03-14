//
//  Message+CoreDataProperties.swift
//  SwiftDatabaseBenchmark
//
//  Created by Kenji Tayama on 2016/03/14.
//  Copyright © 2016年 Kenji Tayama. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Message {

    @NSManaged var identifier: NSDate?
    @NSManaged var text: String?
    @NSManaged var removed: NSNumber?

}
