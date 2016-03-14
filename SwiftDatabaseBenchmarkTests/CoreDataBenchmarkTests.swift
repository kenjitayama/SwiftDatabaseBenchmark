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
        for i in 1...100000 {
            self.insertNewMessage(context, timeIntervalSince1970: NSTimeInterval(i))
        }
        
        try! context.save()
    }
    
    override func tearDown() {
        
        let context = self.context
        
        let request = NSFetchRequest(entityName: "Message")
        let messages = try! context.executeFetchRequest(request)
        
        
        messages.forEach { message in
            
            context.deleteObject(message as! NSManagedObject)
        }
        
        try! context.save()
        
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
        self.measureBlock {
            
            let context = self.context
            let request = NSFetchRequest(entityName: "Message")
            request.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: true)]
            
            let fetchedRequestController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
            do {
                try fetchedRequestController.performFetch()
                fetchedRequestController.fetchedObjects?.first
                
            }
            catch (let error) {
                XCTFail("error : \(error)")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    private let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    private var context: NSManagedObjectContext {
        return self.appDelegate.managedObjectContext
    }
    
    private func insertNewMessage(context: NSManagedObjectContext, timeIntervalSince1970: NSTimeInterval) {
        
        guard let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as? Message else {
            return
        }
        
        let date = NSDate(timeIntervalSince1970: timeIntervalSince1970)
        message.identifier = date
        message.text = "\(timeIntervalSince1970)"
        message.removed = timeIntervalSince1970 % 2 == 0
    }
    
}
