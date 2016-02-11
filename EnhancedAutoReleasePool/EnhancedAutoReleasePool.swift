//
//  EnhancedAutoReleasePool.swift
//  EnhancedAutoReleasePool
//
//  Created by Suguru Kishimoto on 2016/02/11.
//
//

import Foundation


public func autoreleasepool(@noescape code: () throws -> ()) rethrows {
    try {
        var error: ErrorType?
        autoreleasepool {
            do {
                try code()
            } catch (let e) {
                error = e
            }
        }
        if let error = error {
            throw error
        }
    }()
}

public func autoreleasepool<V>(@noescape code: () throws -> V?) rethrows -> V? {
    return try {
        var value: V?
        var error: ErrorType?
        autoreleasepool {
            do {
                value = try code()
            } catch (let e) {
                error = e
            }
        }
        if let error = error {
            throw error
        }
        return value
    }()
}

public func autoreleasepool<V>(@noescape code: () throws -> V) rethrows -> V {
    return try autoreleasepool(code)!
}

