//
//  Functions.swift
//  CryptoPalsSwiftUI
//
//  Created by Shawn Campbell on 9/6/15.
//  Copyright © 2015 Vets First Choice. All rights reserved.
//

import Foundation


public func hexToBase64(hex: String, base64_test: String) -> String? {
    let hex_data = hex.dataFromHexString()
    let base64String = hex_data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    print("hex: \(hex) base64: \(base64String!)", terminator: "")
    return base64String
}

public func xorString(base: String, key: String) -> String? {
    let hex_data = base.dataFromHexString()
    let key_data = key.dataFromHexString()
    let res_data = hex_data!.mutableCopy() as! NSMutableData
    let buf = UnsafeMutableBufferPointer<UInt8>(start: UnsafeMutablePointer(res_data.mutableBytes), count: hex_data!.length)
    let buf_key = UnsafeBufferPointer<UInt8>(start: UnsafePointer(key_data!.bytes), count: key_data!.length)
    for t in 0..<hex_data!.length {
        buf[t] ^= buf_key[t % key_data!.length]
    }
    return res_data.toHexString()
}

public func singleCharXORCipher(hex: String) -> (String?, String?) {
    let min : UInt8 = 0
    let max : UInt8 = 255
    let hex_size = hex.characters.count
    var res_char = ""
    var res = ""
    var res_count = 0
    for var guess = min; guess < max; guess++ {
        var guess_str = "\(guess)"
        for var j = 0; j < (hex_size - 1); j++ {
            guess_str += "\(guess)"
        }
        //print("\(guess_str)")
        let decoded = xorString(hex, key: guess_str)
        let d = decoded!.dataFromHexString()
        let d2 = NSString(data: d!, encoding: NSUTF8StringEncoding) as? String
        var decoded_count = 0;
        if d2 != nil {
            for t in d2!.characters {
                if isEnglishCharacter(t) {
                    decoded_count++
                }
            }
            if decoded_count > res_count {
                res_char = "\(guess)"
                res = d2!
                res_count = decoded_count
                decoded_count = 0
            }
            //print("Char: \(guess) Res: \(d2!) char count: \(decoded_count)")
        }
    }
    //print("Char: \(res_char) Res: \(res) char count: \(res_count)")
    return (res, res_char)
}

func detextSingleCharXor() -> (String?, String?) {
    let res = ""
    let res_char = ""
    
    return (res, res_char)
    
}

func isEnglishCharacter(ch: Character) -> Bool {
    let s = "abcdefghijklmnopqurstwxyzABCDEFGHIJKLMNOPQURSTWXYZ0123456789"
    let chars = [Character](s.characters)
    return chars.contains(ch)
}


