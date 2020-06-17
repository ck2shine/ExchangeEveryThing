//
//  Box.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class Box<T> {
    var key: String?
    
    public typealias LinsterType = (_ value: T?) -> ()
    
    public var _EventListeners: [LinsterType] = []
    
    public var value: T? = nil {
        didSet {
            self.execute(value: value)
        }
    }
    
    public init(_ value: T?, listener: [LinsterType]? = nil) {
        
        self.value = value
        self._EventListeners = listener ?? []
    }
    
    public func execute(value: T?) {
        for listener in self._EventListeners {
            listener(value)
        }
    }
    
    public func binding(trigger: Bool = true, _ index: Int? = nil, listener: @escaping LinsterType) {
        self.appendingBinding(trigger: trigger, index: index, listener: listener)
    }
    
    private func appendingBinding(trigger: Bool = true, index: Int? = nil, listener: @escaping LinsterType) {
        if let index = index, index <  self._EventListeners.count {
            self._EventListeners.insert(listener, at: index)
        } else {
            self._EventListeners.append(listener)
        }
        
        if trigger {
            listener(self.value)
        }
    }
    
    public func removeAllBinding() {
        self._EventListeners.removeAll()
    }
    
    
}
