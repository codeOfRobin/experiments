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

let tokens = matchingURL.map {
    subPart -> Token in
    if subPart.last == ":" {
        return Token.string(String(subPart)[0..<(subPart.count - 1)])
    }
    if subPart.first == "{" && subPart.last == "}" {
        let result = tokenizePathParam(String(subPart)[1..<(subPart.count - 1)])
        return Token.pathParams(result.0, result.1)
    } else {
        return Token.string(String(subPart))
    }
}

print(tokens)




let url = URL(string: "customscheme://customers/123/orders/456")!

url.host
url.scheme
url.pathComponents


let stringsToMatch = [url.scheme, url.host].compactMap{ $0 } + url.pathComponents.filter{ $0 != "/" }
stringsToMatch

var result = false
for (token, string) in zip(tokens, stringsToMatch) {
    switch token {
    case .string(let patternString):
        if patternString != string {
            result = true
            break
        }
    case .pathParams(let argName, let type):
        switch type {
        case .Int:
            if let int = Int(string) {
            }
        case .String:
            string
        case .Float:
            if let float = Float(string) {

            }
        case .Bool:
            if string == "false" {

            }
            if string == "true" {

            }
        }
    }
}

struct LazyScanIterator<Base : IteratorProtocol, ResultElement>: IteratorProtocol {
    mutating func next() -> LazyScanIterator<Base, ResultElement>.Element? {
        return 
    }
}
///       : IteratorProtocol {
///       mutating func next() -> ResultElement? {
///         return nextElement.map { result in
///           nextElement = base.next().map { nextPartialResult(result, $0) }
///           return result
///         }
///       }
///       private var nextElement: ResultElement? // The next result of next().
///       private var base: Base                  // The underlying iterator.
///       private let nextPartialResult: (ResultElement, Base.Element) -> ResultElement
///     }
///
///     struct LazyScanSequence<Base: Sequence, ResultElement>
///       : LazySequenceProtocol // Chained operations on self are lazy, too
///     {
///       func makeIterator() -> LazyScanIterator<Base.Iterator, ResultElement> {
///         return LazyScanIterator(
///           nextElement: initial, base: base.makeIterator(), nextPartialResult)
///       }
///       private let initial: ResultElement
///       private let base: Base
///       private let nextPartialResult:
///         (ResultElement, Base.Element) -> ResultElement
///     }
///
/// and finally, we can give all lazy sequences a lazy `scan` method:
///
///     extension LazySequenceProtocol {
///       /// Returns a sequence containing the results of
///       ///
///       ///   p.reduce(initial, nextPartialResult)
///       ///
///       /// for each prefix `p` of `self`, in order from shortest to
///       /// longest.  For example:
///       ///
///       ///     Array((1..<6).lazy.scan(0, +)) // [0, 1, 3, 6, 10, 15]
///       ///
///       /// - Complexity: O(1)
///       func scan<ResultElement>(
///         _ initial: ResultElement,
///         _ nextPartialResult: (ResultElement, Element) -> ResultElement
///       ) -> LazyScanSequence<Self, ResultElement> {
///         return LazyScanSequence(
///           initial: initial, base: self, nextPartialResult)
///       }
///     }


//: [Next](@next)

