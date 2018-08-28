//: [Previous](@previous)

import AppKit

print("sometjing")

let frame = CGRect(x: 0, y: 0, width: 375, height: 667)
frame.divided(atDistance: 100, from: .maxYEdge).slice.divided(atDistance: 100, from: .minYEdge)
//: [Next](@next)
