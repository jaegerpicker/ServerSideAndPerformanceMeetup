//
// Created by Shawn Campbell on 5/18/15.
// Copyright (c) 2015 Team Awesome McPants. All rights reserved.
//
import Foundation

struct Denomination<T: Hashable, T2> {

    var denom = Dictionary<T, T2>()

    mutating func insert(value: T2, forKey key: T) -> Dictionary<T, T2>? {
        self.denom.removeAll()
        self.denom.updateValue(value, forKey: key)
        return denom
    }

    func get() -> T2? {
        return self.denom[self.denom.keys.array[0]]
    }
}

