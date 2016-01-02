//
//  TestOperation.Swift
//
//  Created by Satish Mahalingam on 12/26/15.
//  Swift fork Copyright © 2015 Satish Maha Software. All rights reserved.
//  Original Copyright (c) 2015 Suyeol Jeon (xoul.kr)
//  MIT License, see license file in repository


import XCTest

class AsyncBlockOperationTests: XCTestCase {
    
    func delay(delay: Double, _ closure: () -> Void) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), closure)
    }
    
    func testAddOperationWithAsyncBlock() {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 0
        queue.addOperation(AsyncBlockOperation { _ in })
        queue.addOperationWithAsyncBlock(AsyncBlockOperation{ _ in })
        queue.addOperationWithAsyncBlock(AsyncBlockOperation{ _ in })
        XCTAssertEqual(queue.operationCount, 3)
    }
    
    func testCallComplete() {
        let expectation = self.expectationWithDescription("Test")
        var flag = false

        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        queue.addOperationWithAsyncBlock(AsyncBlockOperation{op in
            flag = true
            op.complete()
        })
        queue.addOperationWithAsyncBlock(AsyncBlockOperation{op in
            XCTAssertTrue(flag)
            expectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(0.5, handler: nil)
    }
    
    func testNotCallComplete() {
        let expectation = self.expectationWithDescription("Test")
        var flag = false
        
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperationWithAsyncBlock (AsyncBlockOperation{ op in
            // do not call op.complete()
        })
        queue.addOperationWithAsyncBlock (AsyncBlockOperation{ op in
            flag = true
        })
        self.delay(0.5) {
            XCTAssertFalse(flag)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(1, handler: nil)
    }
    
}
