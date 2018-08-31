//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
let calendar = Calendar.init(identifier: .gregorian)
let date = Date()

let df = DateFormatter()
df.locale = Locale.init(identifier: "in_ID")
df.dateStyle = .short
df.timeStyle = .full
print(df.string(from: date))
/// 31/08/18 21.47.32 Waktu India

//: [Next](@next)
