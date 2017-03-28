//
//  Error.swift
//  JKEssential
//
//  Created by Trịnh Quân on 3/27/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public enum ErrorType: Error{
    case error(String)
    case errorWithCode(Int, String)
}

public enum NoError: Error{
    
}
