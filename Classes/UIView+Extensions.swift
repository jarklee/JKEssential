//
//  UIView+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 2/6/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    @objc public class func fromNib(_ name: String) -> UIView? {
        return fromNib(name, owner: nil)
    }
    
    @objc public class func fromNib(_ name: String, owner: Any?, options: [AnyHashable : Any]? = nil) -> UIView? {
        return Bundle.main.loadNibNamed(name, owner: owner, options: options)?.first as? UIView
    }
}
