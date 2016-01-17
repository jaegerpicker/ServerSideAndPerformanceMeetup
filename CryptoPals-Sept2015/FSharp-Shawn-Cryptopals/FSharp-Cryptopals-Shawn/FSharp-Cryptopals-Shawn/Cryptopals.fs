namespace cryptopals

module Encoding = 
    open System
    open System.IO

    let hexStringToByteBuffer(input: string) : byte[] =
        let rec impl(input : string)(convertedSoFar : byte list) : byte[] =
            match input with
            | _ when input.Length >=2 ->
                let converted = Convert.ToByte(input.Substring(0, 2), 16)
                impl(input.Substring(2)) (converted::convertedSoFar)
            | "" -> convertedSoFar |> List.rev |> List.toArray
            | _ -> failwith "Malformed String"
        impl (input) List.Empty

    let hexToBase64(input : byte[]) : string =
        Convert.ToBase64String(input)

    let Base64ToBytes(input : string) : byte[]= 
        Convert.FromBase64String(input)

    let BytesToString(bytes: byte[]) : string =
        System.String.Concat(bytes |> Seq.map (fun b -> (char) b))

    let xor(a: byte[]) (b: byte[]) : byte[] =
        if(Array.length a <> Array.length b)
            then failwith "Input should have the same size"
        Array.zip a b |> Array.map (fun (x,y) -> x ^^^ y)

    let findBestSingleByteXorDecoding(encoded : byte[]) : (string * byte* double) =
        let frequencyTable = [('E',12.02);('T',9.10);('A',8.12);('O',7.68);('I',7.31);('N',6.95);
                              ('S',6.28);('R',6.02);('H',5.92);('D',4.32);('L',3.98);('U',2.88);
                              ('C',2.71);('M',2.61);('F',2.30);('Y',2.11);('W',2.09);('G',2.03);
                              ('P',1.82);('B',1.49);('V',1.11);('K',0.69);('X',0.17);('Q',0.11);
                              ('J',0.10);('Z',0.07)] |> Map.ofSeq
        let frequencies(letter : char) : double =
            let normalised = Char.ToUpper(letter)
            if Map.containsKey normalised frequencyTable
             then Map.find normalised frequencyTable
             else match letter with
                  | _ when Char.IsWhiteSpace(letter) -> 0.01
                  | _ when Char.IsDigit(letter) -> 0.01
                  | _ when Char.IsPunctuation(letter) -> 0.01
                  | _ -> 0.001
        let decode = (fun key -> (Array.map (fun i -> (char)(i ^^^ key)) encoded), key)
        let decoded = [0uy .. 255uy] |> List.map decode
        let score = Array.fold (fun (acc : double)(c : char) -> acc * frequencies c) 1.0
        let ranked = decoded |> List.map (fun (d,k) -> (System.String.Concat(d),k,score d))
        ranked |> List.sortBy (fun (d,k,s) -> s) |> List.rev |> List.head

    let crackSingleByteXor(encoded : byte[]) : string =
          let decoded,_, _ = findBestSingleByteXorDecoding encoded
          decoded

    let crackSingleByteXorKey(encoded : byte[]) : byte =
          let _,key, _ = findBestSingleByteXorDecoding encoded
          key

    let stringToBytes(s:string) = s |> Seq.toList |> List.map (fun c -> (byte) c)


