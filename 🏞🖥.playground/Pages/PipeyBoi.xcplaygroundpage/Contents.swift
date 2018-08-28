//: [Previous](@previous)

import Foundation

infix operator |> : MultiplicationPrecedence
func |> <T, U>(value: T, function: ((T) -> U)) -> U {
    return function(value)
}


func increment(x: Int) -> Int {
    return x + 1
}

func square(x: Int) -> Int {
    return x * x
}

let value = 5
let transformed = value |> increment |> square

protocol Pipeable {
    func pipe<U>(_ function: ((Int) -> U)) -> U
}

extension Pipeable {
    func pipe<U>(_ function: ((Pipeable) -> U)) -> U {
        return function(self)
    }
}

value.pipe(increment).pipe(square)
//: [Next](@next)
