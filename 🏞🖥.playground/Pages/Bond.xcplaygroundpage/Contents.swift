//: [Previous](@previous)

import Foundation

typealias Listener<T> = (T) -> Void

//Dynamic
class Observable<T> {

    var value: T {
        didSet {
            bonds.forEach{ $0.subscription?.listener(value) }
        }
    }

    var bonds: [DisposeBag<T>] = []

    init(_ v:T) {
        value = v
    }
}





//Bond
class Subscription<T> {
    var listener: Listener<T>

    init(_ listener: @escaping  Listener<T>) {
        self.listener = listener
    }

    func bind(observable: Observable<T>) {
        observable.bonds.append(DisposeBag(self))
    }
}




//BondBox
class DisposeBag<T> {
    weak var subscription: Subscription<T>?
    init(_ s: Subscription<T>) {
        self.subscription = s
    }
}

let nameBond = Subscription<String> { (name) in
    print(name)
}

let name = Observable("Steeve")

nameBond.bind(observable: name)

name.value = "something"


//: [Next](@next)
