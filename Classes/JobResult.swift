//
//  HandlerResult.swift
//  JKEssential
//
//  Created by Trịnh Quân on 2/25/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public enum JobResult<T> {
    case failed(Error)
    case success(T)
    
    public var val: T? {
        switch self {
        case .failed(_):
            return nil
        case .success(let val):
            return val
        }
    }
    
    public var error: Error? {
        switch self {
        case .failed(let error):
            return error
        case .success(_):
            return nil
        }
    }
    
    public func map<U>(_ transform: (T) throws -> U) -> JobResult<U> {
        switch self {
        case .success(let value):
            do {
                return .success(try transform(value))
            } catch let error {
                return .failed(error)
            }
        case .failed(let error):
            return .failed(error)
        }
    }
    
    public func map<U>(_ transform: (T) throws -> U, errorTransfrom: (Error) -> Error) -> JobResult<U>{
        switch self {
        case .success(let value):
            do{
                return .success(try transform(value))
            } catch let error {
                return .failed(errorTransfrom(error))
            }
        case .failed(let error):
            return .failed(errorTransfrom(error))
        }
    }
    
    public init(attempt f: @escaping () throws -> T) {
        do {
            self = .success(try f())
        } catch let error {
            self = .failed(error)
        }
    }
    
    public static func attempt(_ f: @escaping () throws -> T) -> JobResult<T> {
        return JobResult(attempt: f)
    }
}

extension JobResult: Mapable{
    
}
