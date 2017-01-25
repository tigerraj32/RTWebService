//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



enum Result<T> {
    case Success(Box<T>)
    case Failure(NSError)
}

class Box<T> {
    let value: T
    
    init(value: T) {
        self.value = value
    }
}

func handleResult(result: Result<String>) {
    switch result {
    case .Success(let box):
        print(box.value)
    case .Failure(let error):
        print(error.description)
    }
}

let result = Result.Success(Box(value: "hello"))
handleResult(result: result)

let err: NSError? = NSError(domain: "goog", code: 100, userInfo: nil)
handleResult(result: Result.Failure(err!))




