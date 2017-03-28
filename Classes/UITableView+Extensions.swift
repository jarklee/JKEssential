//
//  UITableView+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 2/7/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import UIKit

public extension UITableView {
    
    public func registerCellClass(cellClass: AnyClass) {
        let identifier = NSStringFromClass(cellClass).components(separatedBy: ".").last!
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    public func registerCellNib(cellClass: AnyClass) {
        let identifier = NSStringFromClass(cellClass).components(separatedBy: ".").last!
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    public func registerHeaderFooterViewClass(viewClass: AnyClass) {
        let identifier = NSStringFromClass(viewClass).components(separatedBy: ".").last!
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    public func registerHeaderFooterViewNib(viewClass: AnyClass) {
        let identifier = NSStringFromClass(viewClass).components(separatedBy: ".").last!
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}
