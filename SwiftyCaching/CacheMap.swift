//
//  CacheMap.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import CoreData

public class CacheMap<T: NSManagedObject> {
    let proxy = ManagedObjectProxy<T>()
    let managedObject: T
    var fill = false
    
    init(managedObject: T) {
        self.managedObject = managedObject
    }
    
    public func bind<U>(_ bind: @escaping (T) -> U?) -> Binder<T, U> {
        return Binder(cacheMap: self, bind: bind)
    }
    
    public func bind(_ bind: @escaping (T) -> NSSet?) -> Binder<T, NSSet> {
        return Binder(cacheMap: self, bind: bind)
    }
}

extension CacheMap {
    func bind<U>(_ from: inout U?, _ to: (T) -> U?) {
        _ = to(proxy.asObjectType())
        guard let key = proxy.key else { return }
        
        if fill {
            managedObject.setValue(from, forKey: key)
        } else {
            from = managedObject.value(forKey: key) as? U
        }
    }
    
    func bind<U: Integer, V: Integer>(_ from: inout U?, _ to: (T) -> V?) {
        _ = to(proxy.asObjectType())
        guard let key = proxy.key else { return }
        
        if fill {
            managedObject.setValue(from, forKey: key)
        } else {
            from = managedObject.value(forKey: key) as? U
        }
    }
    
    func bind<U: ReferenceConvertible>(_ from: inout U?, _ to: (T) -> U.ReferenceType?) {
        _ = to(proxy.asObjectType())
        guard let key = proxy.key else { return }
        
        if fill {
            managedObject.setValue(from as? U.ReferenceType, forKey: key)
        } else {
            from = managedObject.value(forKey: key) as? U
        }
    }
    
    func bind<U: Cached>(_ from: inout U?, _ to: (T) -> U.T?) {
        _ = to(proxy.asObjectType())
        guard let key = proxy.key else { return }
        guard let object = managedObject.value(forKey: key) as? U.T else { return }
        
        if fill {
            from?.cache(managedObject: object)
        } else {
            from = U.init(managedObject: object)
        }
    }
    
    func bindCollection<U: Cached>(_ from: inout [U]?, _ to: (T) -> NSSet?) {
        _ = to(proxy.asObjectType())
        guard let key = proxy.key else { return }
        guard let set = managedObject.value(forKey: key) as? NSSet else { return }
        guard let array = set.allObjects as? [U.T] else { return }
        
        if fill {
            guard let from = from, set.count > 0, set.count == array.count else { return }
            
            for (index, item) in from.enumerated() {
                item.cache(managedObject: array[index])
            }
        } else {
            from = array.flatMap { U.init(managedObject: $0) }
        }
    }
    
    func bindCollection<U: Cached>(_ from: inout [U]?, _ to: (T) -> NSSet?, _ sorted: (U, U) -> Bool) {
        _ = to(proxy.asObjectType())
        guard let key = proxy.key else { return }
        guard let set = managedObject.value(forKey: key) as? NSSet else { return }
        guard let array = set.allObjects as? [U.T] else { return }
        
        if fill {
            guard let from = from, set.count > 0, set.count == array.count else { return }
            
            for (index, item) in from.enumerated() {
                item.cache(managedObject: array[index])
            }
        } else {
            from = array
                .flatMap { U.init(managedObject: $0) }
                .sorted(by: sorted)
        }
    }
}
