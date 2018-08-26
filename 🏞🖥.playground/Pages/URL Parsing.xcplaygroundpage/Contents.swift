//: [Previous](@previous)

import Foundation
import XCTest


struct Directions {
    let pathArguments: [String: Any]
    let queryParams: [String: Any]
    let options: [String: Any]
}

struct MatchingScheme {
    let pattern: String

    enum MatchingError {
        case noHostMatch
    }

    enum Result {
        case success(Directions)
        case failure(MatchingError)
    }
}

extension URL {
    func match(with matchingScheme: MatchingScheme) -> MatchingScheme.Result {
        return .failure(.noHostMatch)
    }
}

class URLMatcherTests: XCTestCase {

    func testTestyFunction() {
        let url = URL(string: "customScheme://customers/123/orders/456")!
        let matchingScheme = MatchingScheme(pattern: "customScheme://customers/<custID:Int>/orders/<orderID:Int>")
        let result = url.match(with: matchingScheme)

        switch result {
        case .failure:
            XCTFail()
        case .success:
            XCTAssertTrue(true)
        }
    }
}

class TestObserver: NSObject, XCTestObservation {

    func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)


//URLMatcherTests.defaultTestSuite.run()

let parts = "customScheme://customers/{custID:Int}/orders/{orderID:Int}".split(separator: "/")

let pathArgs = parts.enumerated().filter{ $0.element.first == "{" && $0.element.last == "}" }

pathArgs


enum PathArgType: String {
    case Int
    case String
    case Float
    case Bool
}

PathArgType(rawValue: "Bool")

let pathArgs2 = pathArgs.map { (offset, element) in
    return (offset, String(element))
}

pathArgs2

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

let pathArgs3 = pathArgs2.map { (offset, element) in
    return (offset, element[1..<(element.count-1)])
}

pathArgs3


let pathArgs4 = pathArgs3.map { arg -> (String, PathArgType) in
    let (offset, element) = arg
    let splits = element.split(separator: ":")
    //TODO: Add check to make sure `splits` has exactly 2 elements and that paramType is not nil
    assert(splits.count == 2)


    let paramName = splits[0]
    guard let paramType = PathArgType(rawValue: String(splits[1])) else {
        fatalError()
    }
    return (String(paramName), paramType)
}

pathArgs4



//: [Next](@next)
