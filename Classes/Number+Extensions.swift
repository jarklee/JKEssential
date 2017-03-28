//
//  Number+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 2/9/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public extension Decimal {
    
    public var nsdecimal: NSDecimalNumber {
        return NSDecimalNumber(decimal:self)
    }
    
     public var intValue: Int {
        return nsdecimal.intValue
    }
    
     public var floatValue: Float {
        return nsdecimal.floatValue
    }
    
     public var doubleValue: Double {
        return nsdecimal.doubleValue
    }
}

public extension Int {
    
     public var floatValue: Float {
        return Float(self)
    }
    
     public var doubleValue: Double{
        return Double(self)
    }
    
     public var cgFloatValue: CGFloat {
        return CGFloat(self)
    }
}

public extension Float {
    
    public var intValue: Int {
        return Int(self)
    }
    
    public var doubleValue: Double{
        return Double(self)
    }
    
    public var cgFloatValue: CGFloat {
        return CGFloat(self)
    }
}

public extension Double {
    
    public var intValue: Int {
        return Int(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var cgFloatValue: CGFloat {
        return CGFloat(self)
    }
}

public extension CGFloat {
    
    public var intValue: Int {
        return Int(self)
    }

    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double{
        return Double(self)
    }
}

extension Int: Mapable{
    
}

extension Float: Mapable{
    
}

extension Double: Mapable{
    
}

extension CGFloat: Mapable{
    
}

extension CGPoint: Mapable{
    
}

extension CGRect: Mapable{
    
}

extension CGSize: Mapable{
    
}



