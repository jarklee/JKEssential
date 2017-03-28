//
//  String+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 2/9/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public extension Character {
    
    public func toCharacterCode() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}

let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,6}"
let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)

public extension String {
    
    public func isEmail() -> Bool {
        return __emailPredicate.evaluate(with: self)
    }
    
    public static func plural(count: Int, _ single: String, _ plural: String) -> String {
        if count == 1 {
            return "\(count) \(single)"
        } else {
            return "\(count) \(plural)"
        }
    }
    
    public var intValue: Int? {
        return Int(self)
    }
    
    public var length: Int {
        return self.characters.count
    }
    
    public func htmlToText() -> String? {
        let scanner: Scanner = Scanner(string: self)
        var text: NSString? = ""
        var convertedString = self
        while !scanner.isAtEnd {
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo(">", into: &text)
            convertedString = convertedString.replacingOccurrences(of: "\(text!)>", with: "")
        }
        convertedString = convertedString.replacingOccurrences(of: "&nbsp;", with: " ")
        return convertedString
    }
    
    public func toUrl() -> URL? {
        return URL(string: self)
    }
    
    public func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
