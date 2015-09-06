//
//  StringHexToNSData.swift
//  CryptoPalsSwiftUI
//
//  Created by Shawn Campbell on 9/6/15.
//  Copyright © 2015 Vets First Choice. All rights reserved.
//

import Foundation

extension String {
    
    func dataFromHexString() -> NSData? {
        let trimmed = self.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<> ")).stringByReplacingOccurrencesOfString(" ", withString: "")
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9a-f]*$", options: .CaseInsensitive)
            let r = NSMakeRange(0, trimmed.characters.count)
            let found = regex.firstMatchInString(trimmed, options: NSMatchingOptions.WithTransparentBounds, range: r)
            if found == nil || found?.range.location == NSNotFound || trimmed.characters.count % 2 != 0 {
                return nil
            }
        } catch let err as NSError {
            NSLog("\(err)")
            return nil
        }
        
        let data = NSMutableData(capacity: trimmed.characters.count / 2 )
        for var index = trimmed.startIndex; index < trimmed.endIndex; index = index.successor().successor() {
            let byteString = trimmed.substringWithRange(Range<String.Index>(start: index, end: index.successor().successor()))
            let num = UInt8(byteString.withCString { strtoul($0, nil, 16) })
            data?.appendBytes([num] as [UInt8], length: 1)
        }
        return data
    }
}