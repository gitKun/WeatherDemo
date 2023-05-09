//
//  TestAssociatedtypeSimeName.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/9.
//

import Foundation


// MARK: - associatedtype 同名冲突的解决办法

struct MyEquatableModel: Equatable {

    static func == (lhs: MyEquatableModel, rhs: MyEquatableModel) -> Bool {
        return lhs.value == rhs.value
    }

    let value: String

    init(value: String) {
        self.value = value
    }
}

protocol AssociatedtypeOne {
    associatedtype Element: Equatable

    func hasContent(_ content: Element) -> Bool
}


protocol AssociatedtypeTwo {
    associatedtype Element: Codable

//    func hasContent(_ content: Element) -> Bool
    func add(_ element: Element)
}


// MARK: - 解决办法 1

protocol WrappedOne: AssociatedtypeOne where Element == One {
    associatedtype One: Equatable
}

struct MyStruct<C>: WrappedOne {
    typealias One = MyEquatableModel

    func hasContent(_ content: MyEquatableModel) -> Bool {
        return true
    }
}

extension MyStruct: AssociatedtypeTwo where C == String {
    typealias Element = C

    func add(_ element: C) {}
}

// 'where' clause cannot be applied to a non-generic top-level declaration
// extension MyStruct: AssociatedtypeOne where Element == MyEquatableModel {}

// MARK: - 解决办法 2

struct MyStruct1<One: AssociatedtypeOne, Two: AssociatedtypeTwo> {}

// MARK: - 解决办法 3

struct MyStruct2<One, Two> {}

extension MyStruct2: AssociatedtypeOne where One: Equatable {
    func hasContent(_ content: One) -> Bool {
        return true
    }
}

extension MyStruct2: AssociatedtypeTwo where Two: Codable {
    func add(_ element: Two) {
        
    }
}

enum TestEnum {
    static func test() {
        let obj1 = MyStruct2<MyEquatableModel, String>()
        obj1.add("22")
        _ = obj1.hasContent(MyEquatableModel(value: "22"))
    }
}


// Type 'MyStruct3<One, Two>' does not conform to protocol 'AssociatedtypeTwo'
//struct MyStruct3<One: Equatable, Two: Codable>: AssociatedtypeOne, AssociatedtypeTwo {
//
//    func hasContent(_ content: One) -> Bool {
//        return true
//    }
//
//    func add(_ element: Two) {
//
//    }
//}

//struct MyStruct {}
//
//extension MyStruct: AssociatedtypeOne {
//
//    typealias Element = MyEquatableModel
//
//    func hasContent(_ content: MyEquatableModel) -> Bool {
//        return true
//    }
//}
//
//extension MyStruct: AssociatedtypeTwo {
//
//    typealias AssociatedtypeTwo.Element = String
//
//    func add(_ element: String) {
//        debugPrint("add: \(element)")
//    }
//}


//typealias CombinationProtocol = AssociatedtypeOne & AssociatedtypeTwo
//
//
//struct MyStruct: CombinationProtocol {
//
//    typealias Element = MyEquatableModel
//
//    func hasContent(_ content: MyEquatableModel) -> Bool {
//        return true
//    }
//
//    func hasContent(_ content: String) -> Bool {
//        return true
//    }
//}
