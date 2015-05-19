//
//  main.swift
//  CashRegister
//
//  Created by Shawn Campbell on 5/18/15.
//  Copyright (c) 2015 Team Awesome McPants. All rights reserved.
//

import Foundation

extension Dictionary {
    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }

    func sortedKeys(isOrderedBefore:(Key, Key) -> Bool) -> [Key] {
        var array = Array(self.keys)
        sort(&array, isOrderedBefore)
        return array
    }
}

func buildDemon_list() -> Dictionary<Int, Denomination<String, Int>> {
    var ret = Dictionary<Int, Denomination<String, Int>>()
    var penny = Denomination<String, Int>()
    var nickel = Denomination<String, Int>()
    var dime = Denomination<String, Int>()
    var quarter = Denomination<String, Int>()
    var half_dollar = Denomination<String, Int>()
    var one = Denomination<String, Int>()
    var two = Denomination<String, Int>()
    var five = Denomination<String, Int>()
    var ten = Denomination<String, Int>()
    var twenty = Denomination<String, Int>()
    var fifty = Denomination<String, Int>()
    var one_hundred = Denomination<String, Int>()
    penny.insert(1, forKey: "PENNY")
    nickel.insert(5, forKey: "NICKEL")
    dime.insert(10, forKey: "DIME")
    quarter.insert(25, forKey: "QUARTER")
    half_dollar.insert(50, forKey: "HALF DOLLAR")
    one.insert(100, forKey: "ONE")
    two.insert(200, forKey: "TWO")
    five.insert(500, forKey: "FIVE")
    ten.insert(1000, forKey: "TEN")
    twenty.insert(2000, forKey: "TWENTY")
    fifty.insert(5000, forKey: "FIFTY")
    one_hundred.insert(10000, forKey: "ONE HUNDRED")
    ret.updateValue(penny, forKey: penny.get()!)
    ret.updateValue(nickel, forKey: nickel.get()!)
    ret.updateValue(dime, forKey: dime.get()!)
    ret.updateValue(quarter, forKey: quarter.get()!)
    ret.updateValue(half_dollar, forKey: half_dollar.get()!)
    ret.updateValue(one, forKey: one.get()!)
    ret.updateValue(two, forKey: two.get()!)
    ret.updateValue(five, forKey: five.get()!)
    ret.updateValue(ten, forKey: ten.get()!)
    ret.updateValue(twenty, forKey: twenty.get()!)
    ret.updateValue(fifty, forKey: fifty.get()!)
    ret.updateValue(one_hundred, forKey: one_hundred.get()!)
    return ret
}


var denom_list  = Dictionary<Int, Denomination<String, Int>>()
denom_list = buildDemon_list()
let file = "/Users/scampbell/CODE/ServerSideMeetup/CashRegister-May2015/ShawnCampbellCPP/test_data.txt"
let text = String(contentsOfFile: file, encoding: NSUTF8StringEncoding, error: nil)
//println(text)
var lines = NSString(string: text!).componentsSeparatedByString("\n")
//println(lines)
for (index, line) in enumerate(lines) {
    //println(line)
    var vals: [String] = NSString(string: line as! String).componentsSeparatedByString(";") as! [String]
    //println(vals)
    var val1 = Int((vals[0] as NSString?)!.floatValue * 100)
    println(val1)
    var val2 = Int((vals[1] as NSString?)!.floatValue * 100)
    println(val2)
    var output: String = ""
    if val1 < val2 {
        while(val2 - val1 >= 1 ) {
            for (key, value) in enumerate(denom_list.sortedKeys(>)) {
                let v : Int = value as Int
                if denom_list[v]!.get() < val2 {
                    if output != "" {
                        output = output + "," + String(value)
                    } else {
                        output = String(value)
                    }
                    val2 = val2 - denom_list[v]!.get()!
                }
            }
        }
    } else if val1 == val2 {
        output = "ZERO"
    } else {
        output = "ERROR"
    }
    println(output)
}
//println("Hello, World!")
//println(denom_list)


