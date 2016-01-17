// Learn more about F# at http://fsharp.org
// See the 'F# Tutorial' project for more help.
open cryptopals.Encoding

[<EntryPoint>]
let main argv =
    // Problem set 1
    let bufferToEncode = hexStringToByteBuffer "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    let expectedEncodedString = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    let actual = hexToBase64 bufferToEncode
    printfn "1: Hex String to convert %A" (BytesToString bufferToEncode)
    printfn "1: Expected value %A" expectedEncodedString
    printfn "1: Actual Value %A" actual
    //Problem set 2
    let a = hexStringToByteBuffer "1c0111001f010100061a024b53535009181c"
    let b = hexStringToByteBuffer "686974207468652062756c6c277320657965"
    let expectedFixedXOR = hexStringToByteBuffer "746865206b696420646f6e277420706c6179"
    printfn "2: Hex val: %A" (BytesToString a)
    printfn "2: Key val: %A" (BytesToString b)
    printfn "2: expectedFixedXOR %A" (BytesToString expectedFixedXOR)
    printfn "2: actual %A" (BytesToString (xor a b))
    //Problem set 3
    let encodedSingleByteXor = hexStringToByteBuffer "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    let expectedDecodedSingleByteXor = "Cooking MC's like a pound of bacon"
    let actual = crackSingleByteXor encodedSingleByteXor
    printfn "3: Hex val: %A" (BytesToString encodedSingleByteXor)
    printfn "3: Expected Val: %A" expectedDecodedSingleByteXor
    printfn "3: actual val: %A" actual
    System.Console.Read()
    0 // return an integer exit code
