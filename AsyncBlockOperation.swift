//
//  AsyncBlockOperation.swift
//
//  Created by Satish Mahalingam on 12/26/15.
//  Swift fork Copyright © 2015 Satish Maha Software. All rights reserved.
//  Original Copyright (c) 2015 Suyeol Jeon (xoul.kr)
//  MIT License, see license file in repository


import Foundation

class AsyncBlockOperation: NSOperation {
    
    typealias AsyncBlock = (AsyncBlockOperation) -> Void
    
    var block: AsyncBlock?

    init(block: AsyncBlock) {
        super.init()
        self.block = block
    }
    
    override func start() {
        executing = true
        if let executingBlock = self.block {
            executingBlock(self)
        } else {
            complete()
        }
    }
    
    func complete() {
        executing = false
        finished = true
    }
    
    private var _executing: Bool = false
    override var executing: Bool {
        get {
            return _executing
        }
        set {
            if _executing != newValue {
                willChangeValueForKey("isExecuting")
                _executing = newValue
                didChangeValueForKey("isExecuting")
            }
        }
    }
    
    private var _finished: Bool = false;
    override var finished: Bool {
        get {
            return _finished
        }
        set {
            if _finished != newValue {
                willChangeValueForKey("isFinished")
                _finished = newValue
                didChangeValueForKey("isFinished")
            }
        }
    }
}

extension NSOperationQueue {
    
    func addOperationWithAsyncBlock(block: AsyncBlockOperation) {
        self.addOperation(block)
    }
}