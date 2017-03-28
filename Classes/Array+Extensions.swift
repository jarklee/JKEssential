//
//  Array+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 3/13/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public extension Array where Element : Any {
    
    public  func takeFirst(_ num: Int) -> ArraySlice<Element> {
        return self.prefix(num)
    }
    
    public  func takeLast(_ num: Int) -> ArraySlice<Element> {
        return self.suffix(num)
    }
}

public extension Array where Element : OptionalTypeProtocol {
    
    public var firstReal: Element.Wrapped? {
        return self.firstRealOrNil()
    }
    
    public var lastReal: Element.Wrapped? {
        return self.lastRealOrNil()
    }
    
    public func takeNotNil() -> [Element.Wrapped] {
        return self.filter({ $0.optional != nil })
            .map({ $0.optional! })
    }
    
    public func firstRealOrNil() -> Element.Wrapped? {
        return self.filter({ $0.optional != nil }).first?.optional
    }
    
    public func lastRealOrNil() -> Element.Wrapped? {
        return self.filter({ $0.optional != nil }).last?.optional
    }
    
    public  func countNotNil() -> Int {
        return self.takeNotNil().count
    }
    
    public  func countNil() -> Int {
        return self.count - countNotNil()
    }
    
}
