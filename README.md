AsyncBlockOperation-Swift
===================

Forked from https://github.com/devxoul/AsyncBlockOperation

NSOperation subclass for async block

At a Glance
-----------

**Swift**

```swift

let operation = AsyncBlockOperation { op in
    doSomeAsyncTaskWithCompletionBlock {
        op.complete() // complete operation
    }
}
queue.addOperation(operation)
```

Short-hand Method Extension
---------------------------

As `NSBlockOperation` does, `AsyncBlockOperation` supports `NSOperationQueue` extension to add async block operations quickly.

**Swift**

```swift
queue.addOperationWithAsyncBlock { op in
    op.complete()
}
```

License
-------

**AsyncBlockOperation** is under MIT license. See the LICENSE file for more info.
