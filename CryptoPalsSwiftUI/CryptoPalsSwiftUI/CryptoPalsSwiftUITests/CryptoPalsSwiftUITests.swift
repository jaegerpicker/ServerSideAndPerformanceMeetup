//
//  CryptoPalsSwiftUITests.swift
//  CryptoPalsSwiftUITests
//
//  Created by Shawn Campbell on 9/6/15.
//  Copyright © 2015 Vets First Choice. All rights reserved.
//

import XCTest
@testable import CryptoPalsSwiftUI

class CryptoPalsSwiftUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testXorString() {
        let base = "1c0111001f010100061a024b53535009181c"
        let key = "686974207468652062756c6c277320657965"
        let test_res = "746865206b696420646f6e277420706c6179"
        let res = xorString(base, key: key)
        XCTAssert(test_res == res)
    }
    
    func testPerformanceXorString() {
        self.measureBlock {
            let base = "1c0111001f010100061a024b53535009181c"
            let key = "686974207468652062756c6c277320657965"
            let res = xorString(base, key: key)
            print("\(res)")
        }
    }
    
    func testSingleCharXor() {
        let hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
        let res = singleCharXORCipher(hex)
        let res_test = "Cooking MC's like a pound of bacon"
        XCTAssert(res.0 == res_test)
    }
    
    func testPerformanceSingleCharXor() {
        self.measureBlock{
            let hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
            let res = singleCharXORCipher(hex)
            print("\(res.0)")
        }
    }
    
    func testHexToBase64() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let hexstring = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
        let resultstring_test = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
        let res = hexToBase64(hexstring, base64_test: resultstring_test)
        XCTAssert(res == resultstring_test)
    }
    
    func testPerformanceHexToBase64() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            let hexstring = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
            let resultstring_test = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
            let res = hexToBase64(hexstring, base64_test: resultstring_test)
            print("\(res)")
        }
    }
    
    func testPerformanceFindSingleCharacterXor() {
        self.measureBlock {
            
        }
    }
    
    func testSingleCharacterXor() {
        
    }
    
}
