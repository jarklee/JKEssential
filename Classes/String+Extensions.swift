//
//  String+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 2/9/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation
import UIKit

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
    
    public var utf8Length: Int {
        return self.utf8.count
    }
    
    public var utf16Length: Int {
        return self.utf16.count
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

extension String: Mapable{
    
}

extension String {
    
    public func chars() -> [String] {
        return self.characters.map { "\($0)" }
    }
    
    public func charsAppear() -> [String] {
        var currentStr = ""
        return self.chars().map{ char in
            let newStr = "\(currentStr)\(char)"
            currentStr = newStr
            return newStr
        }
    }
    
    public func charsAnimation(_ represent: StringReprentable) -> AnimationCollection {
        return String.toAnimations(represent, stringProducer: self.charsAppear)
    }
    
    public func charsAnimation(_ charConsumer: @escaping (String) -> Void) -> AnimationCollection {
        return String.toAnimations(charConsumer, stringProducer: self.charsAppear)
    }
    
    public func words() -> [String] {
        return self.components(separatedBy: " ")
    }
    
    public func wordsAppear() -> [String] {
        let words = self.words()
        var currentWord = ""
        return words.map { word in
            let newLine = currentWord.utf8Length == 0 ? word : "\(currentWord) \(word)"
            currentWord = newLine
            return newLine
        }
    }
    
    public func wordsAnimation(_ represent: StringReprentable) -> AnimationCollection {
        return String.toAnimations(represent, stringProducer: self.wordsAppear)
    }
    
    public func wordsAnimation(_ wordConsumer: @escaping (String) -> Void) -> AnimationCollection {
        return String.toAnimations(wordConsumer, stringProducer: self.wordsAppear)
    }
    
    public static func toAnimations(_ represent: StringReprentable,
                                    stringProducer: @escaping () -> [String]) -> AnimationCollection {
        return toAnimations({ (str) in
            represent.representText = str
        }, stringProducer: stringProducer)
    }
    
    public static func toAnimations(_ stringConsumer: @escaping (String) -> Void,
                                    stringProducer: @escaping () -> [String]) -> AnimationCollection {
        return stringProducer().map{ word -> AnimationBlock in
            return {
                stringConsumer(word)
            }
        }
    }
}

public protocol StringReprentable: class {
    var representText: String? {get set}
}

public protocol StringAssignable: StringReprentable {
    
    var text: String? {get set}
}

public extension StringAssignable {
    
    public var representText: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue
        }
    }
}

extension UILabel: StringAssignable {
}

extension UITextView: StringReprentable {
    @objc public var representText: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue
        }
    }
}

extension UITextField: StringAssignable {
    
}

