//
//  ImutableArray.swift
//  JKEssential
//
//  Created by Trịnh Quân on 3/24/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public class ImmutableArray<T> {
    public typealias Element = T
    
    fileprivate let internalArray: [T]
    public let count:Int
    
    public init(_ array:[T]) {
        var copy = [T]()
        copy.append(contentsOf: array)
        count = copy.count
        internalArray = copy
    }
    
    public init(_ elements:T...) {
        var copy = [T]()
        copy.append(contentsOf: elements)
        count = elements.count
        internalArray = copy
    }
}

extension ImmutableArray: Collection {
    public func index(after i: Int) -> Int {
        return internalArray.index(after: i)
    }

    public var startIndex:Int { return internalArray.startIndex }
    
    public var endIndex:Int { return internalArray.endIndex }
    
    public subscript (index:Int) -> T {
        return internalArray[index]
    }
    
    public subscript (range:Range<Int>) -> ImmutableArray<T> {
        return ImmutableArray(Array(internalArray[range]))
    }
}

extension ImmutableArray : CustomStringConvertible {
    public var description:String {
        return internalArray.description
    }
}

public func ==<T: Equatable>(lhs:ImmutableArray<T>, rhs:ImmutableArray<T>)->Bool {
    return lhs.internalArray == rhs.internalArray
}

public extension ImmutableArray {
    public var isEmpty:Bool { return count == 0 }
    
    public func sort(block:(T,T)->Bool) -> ImmutableArray<T> {
        return ImmutableArray(internalArray.sorted(by: block))
    }
    
    public func filter(block:(T)->Bool) -> ImmutableArray<T> {
        return ImmutableArray(internalArray.filter(block))
    }
    public func map<U>(block:(T)->U) -> ImmutableArray<U> {
        return ImmutableArray<U>(internalArray.map(block))
    }
    public func reduce<U>(start:U, block:(U,T)->U) -> U {
        return internalArray.reduce(start,block)
    }
    public func reverse() -> ImmutableArray<T> {
        return ImmutableArray(internalArray.reversed())
    }
    
    public func forEach(_ body: (T) throws -> Void) rethrows {
        try internalArray.forEach(body)
    }
    
    public var last: T? {
        return internalArray.last
    }
    
    public var first: T? {
        return internalArray.first
    }
}

extension Array where Element: Any {
    
    public func immutable() -> ImmutableArray<Element> {
        return ImmutableArray(self)
    }
}

