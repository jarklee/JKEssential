//
//  Optional+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 3/28/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public protocol OptionalTypeProtocol {
    associatedtype Wrapped
    
    init(reconstructing value: Wrapped?)
    
    var optional: Wrapped? { get }
}

extension Optional: OptionalTypeProtocol {
    public var optional: Wrapped? {
        return self
    }
    
    public init(reconstructing value: Wrapped?) {
        self = value
    }
}
