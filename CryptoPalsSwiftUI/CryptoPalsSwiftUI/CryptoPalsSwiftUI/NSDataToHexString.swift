//
//  NSDataToHexString.swift
//  CryptoPalsSwiftUI
//
//  Created by Shawn Campbell on 9/6/15.
//  Copyright © 2015 Vets First Choice. All rights reserved.
//

import Foundation

extension NSData {
    func toHexString() -> String {
        var string = NSMutableString(capacity: length * 2)
        var byte: UInt8 = 0
        
        for i in 0..<length {
            getBytes(&byte, range: NSMakeRange(i, 1))
            string.appendFormat("%02x", byte)
        }
        return string as String
    }
}
