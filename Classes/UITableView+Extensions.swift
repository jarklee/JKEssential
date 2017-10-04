//
//  UITableView+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 2/7/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    @objc public func registerCellClass(cellClass: AnyClass) {
        let identifier = NSStringFromClass(cellClass).components(separatedBy: ".").last!
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    @objc public func registerCellNib(cellClass: AnyClass) {
        let identifier = NSStringFromClass(cellClass).components(separatedBy: ".").last!
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    @objc public func registerHeaderFooterViewClass(viewClass: AnyClass) {
        let identifier = NSStringFromClass(viewClass).components(separatedBy: ".").last!
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    @objc public func registerHeaderFooterViewNib(viewClass: AnyClass) {
        let identifier = NSStringFromClass(viewClass).components(separatedBy: ".").last!
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}
