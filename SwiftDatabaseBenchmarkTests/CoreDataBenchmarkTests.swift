//
//  SwiftDatabaseBenchmarkTests.swift
//  SwiftDatabaseBenchmarkTests
//
//  Created by Kenji Tayama on 2016/03/14.
//  Copyright © 2016年 Kenji Tayama. All rights reserved.
//

import XCTest
import CoreData
@testable import SwiftDatabaseBenchmark

class CoreDataBenchmarkTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let context = self.context

        for i in 1...Consts.total {
            self.insertNewMessage(context, timeIntervalSince1970: NSTimeInterval(i))
        }
        
        try! context.save()
    }
    
    override func tearDown() {
        
        let dbFileURL = self.appDelegate.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        try! NSFileManager.defaultManager().removeItemAtURL(dbFileURL)
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testPerformFetch() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//      
//        
//        let context = self.context
//        let request = NSFetchRequest(entityName: "Message")
//        request.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: true)]
//        
//        let fetchedRequestController = NSFetchedResultsController(
//            fetchRequest: request,
//            managedObjectContext: context,
//            sectionNameKeyPath: nil,
//            cacheName: nil)
//
//        self.measureBlock {
//            try! fetchedRequestController.performFetch()
//        }
//    }
//
//    func testGetFirst() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        
//        let context = self.context
//        let request = NSFetchRequest(entityName: "Message")
//        request.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: true)]
//        
//        let fetchedRequestController = NSFetchedResultsController(
//            fetchRequest: request,
//            managedObjectContext: context,
//            sectionNameKeyPath: nil,
//            cacheName: nil)
//
//        try! fetchedRequestController.performFetch()
//
//        self.measureBlock {
//            fetchedRequestController.fetchedObjects?.first
//        }
//    }
//    
//    
    func testAll() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let context = self.context
        let request = NSFetchRequest(entityName: "Message")
//        request.predicate = NSPredicate(format: "SELF.removed == %@", false)
        request.sortDescriptors = [NSSortDescriptor(key: "identifierDate", ascending: true)]
        
        let fetchedRequestController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        self.measureBlock {
            try! fetchedRequestController.performFetch()
            let messages = fetchedRequestController.fetchedObjects
            _ = messages?.first
        }
    }
    
    
    private let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    private var context: NSManagedObjectContext {
        return self.appDelegate.managedObjectContext
    }
    
    private func insertNewMessage(context: NSManagedObjectContext, timeIntervalSince1970: NSTimeInterval) {
        
        let object = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context)
        
        let date = NSDate(timeIntervalSince1970: timeIntervalSince1970)
        object.setValue(NSNumber(longLong: Int64(timeIntervalSince1970)), forKey: "identifier")
        object.setValue(date, forKey: "identifierDate")
        object.setValue("\(timeIntervalSince1970)", forKey: "text")
        object.setValue(timeIntervalSince1970 % 2 == 0, forKey: "removed")
    }
    
}
