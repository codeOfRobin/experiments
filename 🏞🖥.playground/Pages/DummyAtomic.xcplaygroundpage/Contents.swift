//: [Previous](@previous)

import Foundation


class DummyAtomic<Value> {
    var value: Value

    init(_ value: Value) {
        self.value = value
    }

    func modify<Result>(_ action: (inout Value) -> Result) -> Result {
        return action(&value)
    }
}

//// Suppose we're trying to use a closure that takes a string and "doubles" it. We also need to log how many characters we "process" by adding the number of characters in the string to the counter. Now, since DummyAtomic(0) is being captured in the closure, we can't mess with it outside of the closure.


//// One problem tho: 🤔. How tf do you access teh counter outside of the closure?

let closure: (String) -> String = { [counter = DummyAtomic(0)]
    string in
    return counter.modify({ (count) in
        count += string.count
        print(counter.value)
        return string + string
    })
}

print(closure("something"))
print(closure("robin"))

print("something".count + "robin".count)

//: [Next](@next)

