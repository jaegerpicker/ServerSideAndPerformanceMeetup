//
//  ViewController.swift
//  CryptoPalsSwiftUI
//
//  Created by Shawn Campbell on 9/6/15.
//  Copyright © 2015 Vets First Choice. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet var hex2base64 : NSButton?
    @IBOutlet var resText : NSTextView?
    @IBOutlet weak var xor: NSButton!
    @IBOutlet weak var singleCharXor: NSButton!
    @IBOutlet weak var detectSingle: NSButton!
    
    
    
    /*
    *
    *   Test Data here!
    *
    *
    */
    let hexstring = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    let resultstring_test = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    
    let base = "1c0111001f010100061a024b53535009181c"
    let key = "686974207468652062756c6c277320657965"
    let xor_test = "746865206b696420646f6e277420706c6179"
    let single_xor = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    let single_xor_test = "Cooking MC's like a pound of bacon"
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func detectSingleClick(sender: NSButton) {
    }
    
    @IBAction func xorClick(sender: NSButton) {
        let res = xorString(base, key: key)
        resText!.insertText("xor result: \(res!)")
        resText!.insertNewline(sender)
        resText!.insertText("expected results: \(xor_test)")
        resText!.insertNewline(sender)
    }
    
    @IBAction func singleCharXorClick(sender: AnyObject) {
        let res = singleCharXORCipher(single_xor)
        resText!.insertText("single xor decrypted: \(res.0!)")
        resText!.insertNewline(sender)
        resText!.insertText("single xor expected: \(single_xor_test)")
        resText!.insertNewline(sender)
    }
    
    @IBAction func hex2base64Click(sender: NSButton) {
        let res = hexToBase64(hexstring, base64_test: resultstring_test)
        resText!.insertText("Resulting base 64: \(res!)")
        resText!.insertNewline(sender)
        resText!.insertText("Expected base 64: \(resultstring_test)")
        resText!.insertNewline(sender)
    }
}

