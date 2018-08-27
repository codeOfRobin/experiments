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

enum PathArgType: String {
    case Int
    case String
    case Float
    case Bool
}

PathArgType(rawValue: "Bool")

let matchingURL = "customScheme://customers/{custID:Int}/orders/{orderID:Int}".split(separator: "/")

enum Token {
    case string(String)
    case pathParams(String, PathArgType)
}

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

func tokenizePathParam(_ element: String) -> (String, PathArgType) {
    let splits = element.split(separator: ":")
    //TODO: Add check to make sure `splits` has exactly 2 elements and that paramType is not nil
    assert(splits.count == 2)
    let paramName = splits[0]
    guard let paramType = PathArgType(rawValue: String(splits[1])) else {
        fatalError()
    }
    return (String(paramName), paramType)
}

let pathArgs = matchingURL.map {
    subPart -> Token in
    if subPart.first == "{" && subPart.last == "}" {
        let result = tokenizePathParam(String(subPart)[1..<(subPart.count - 1)])
        return Token.pathParams(result.0, result.1)
    } else {
        return Token.string(String(subPart))
    }
}

print(pathArgs)




let url = URL(string: "customscheme://customers/123/orders/456")!

url.host
url.scheme
url.pathComponents





//: [Next](@next)

