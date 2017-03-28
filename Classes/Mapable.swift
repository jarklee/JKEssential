//
//  Mapable.swift
//  JKEssential
//
//  Created by Trịnh Quân on 3/28/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public protocol Mapable {
    
    func mapTo<T>(_ transform: (Self) throws -> T) rethrows -> T
    
}

public extension Mapable where Self : Mapable {
    
    public func mapTo<T>(_ transform: (Self) throws -> T) rethrows -> T {
        return try transform(self)
    }
    
}
