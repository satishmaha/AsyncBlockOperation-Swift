//
//  AsyncBlockOperation.swift
//
//  Created by Satish Mahalingam on 12/26/15.
//  Swift fork Copyright © 2015 Satish Maha Software. All rights reserved.
//  Original Copyright (c) 2015 Suyeol Jeon (xoul.kr)
//  MIT License, see license file in repository


import Foundation

class AsyncBlockOperation: Operation {
    
    typealias AsyncBlock = (AsyncBlockOperation) -> Void
    
    var block: AsyncBlock?
    
    init(block: @escaping AsyncBlock) {
        super.init()
        self.block = block
    }
    
    override func start() {
        isExecuting = true
        if let executingBlock = self.block {
            executingBlock(self)
        } else {
            complete()
        }
    }
    
    func complete() {
        isExecuting = false
        isFinished = true
    }
    
    private var _executing: Bool = false
    override var isExecuting: Bool {
        get {
            return _executing
        }
        set {
            if _executing != newValue {
                willChangeValue(forKey: "isExecuting")
                _executing = newValue
                didChangeValue(forKey: "isExecuting")
            }
        }
    }
    
    private var _finished: Bool = false;
    override var isFinished: Bool {
        get {
            return _finished
        }
        set {
            if _finished != newValue {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }
}

extension OperationQueue {
    
    func addOperationWithAsyncBlock(block: AsyncBlockOperation) {
        self.addOperation(block)
    }
}
