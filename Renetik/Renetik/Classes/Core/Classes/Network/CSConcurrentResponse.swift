//
//  CSConcurentResponse.swift
//  Renetik
//
//  Created by Rene Dohan on 3/14/19.
//

import RenetikObjc

public extension CSConcurrentResponse {
    @discardableResult
    @nonobjc public func add<T: AnyObject>(response: CSResponse<T>) -> CSResponse<T> {
        add(response as! CSResponse<AnyObject>)
        return response
    }

    @discardableResult
    @nonobjc public func add<T: AnyObject>(responses: [CSResponse<T>]) -> Self {
        addAll(responses as! [CSResponse<AnyObject>])
        return self
    }
}