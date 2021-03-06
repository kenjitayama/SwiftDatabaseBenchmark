//
//  RealmBenchmarkTests.swift
//  SwiftDatabaseBenchmark
//
//  Created by Kenji Tayama on 2016/03/14.
//  Copyright © 2016年 Kenji Tayama. All rights reserved.
//

import XCTest
import RealmSwift

class RealmBenchmarkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let path = "\(RealmBenchmarkTests.documentsDirectory)/message.realm"
        let configuration = Realm.Configuration(
            path: path,
            schemaVersion: 0,
            migrationBlock: { (migration, oldSchemaVersion) -> Void in
                
            },
            objectTypes: [
                RLMMessage.self
            ]
        )
        
        self.realm = try! Realm(configuration: configuration)

        
        try! self.realm.write {
            
            for i in 1...Consts.total {
                autoreleasepool {
                    self.insertNewMessage(timeIntervalSince1970: NSTimeInterval(i))
                }
            }
        }
    }
    
    override func tearDown() {
        
        try! NSFileManager.defaultManager().removeItemAtPath(RealmBenchmarkTests.dbFilePath)
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testGetObjects() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//
//        self.measureBlock {
//           _ = self.realm.objects(RLMMessage).sorted("identifierDate")
//        }
//    }
//
//    
//    func testGetFirst() {
//        
//        let messages = self.realm.objects(RLMMessage).sorted("identifierDate")
//        self.measureBlock {
//            _ = messages.first
//        }
//    }
//    
//    
    func testAll() {
        
        self.measureBlock {
            let messages = self.realm.objects(RLMMessage).sorted("identifierDate")
//            let messages = self.realm.objects(RLMMessage).filter("removed == false").sorted("identifierDate")
            _ = messages.first
        }
    }

    
    private var realm: Realm!
    
    private static let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    
    private static let dbFilePath = "\(documentsDirectory)/message.realm"
    

    private func insertNewMessage(timeIntervalSince1970 timeIntervalSince1970: NSTimeInterval) {
        
        let message = RLMMessage()
        
        let date = NSDate(timeIntervalSince1970: timeIntervalSince1970)
        message.identifier = Int64(timeIntervalSince1970)
        message.identifierDate = date
        message.text = "\(timeIntervalSince1970)"
        message.removed = timeIntervalSince1970 % 2 == 0
        
        self.realm.add(message, update: true)
    }
    
}
