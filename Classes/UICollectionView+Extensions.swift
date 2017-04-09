//
//  UICollectionView+Extensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 3/28/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    public func registerCellClass(cellClass: AnyClass) {
        let identifier = NSStringFromClass(cellClass).components(separatedBy: ".").last!
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    public func registerCellNib(cellClass: AnyClass) {
        let identifier = NSStringFromClass(cellClass).components(separatedBy: ".").last!
        let nib = UINib(nibName: identifier, bundle: Bundle.main)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
