import sun.misc.BASE64Encoder

/**
 * Created by scampbell on 9/23/15.
 */
object Set1 {
  def main(args: Array[String]) {
    println("Starting CryptoPals set1.....")
    println(hexToBase64())
    val i = "1c0111001f010100061a024b53535009181c"
    val x = "686974207468652062756c6c277320657965"
    println(fixedXOR(i, x))
    println(fixedXORLowLevel(i, x))
    println(new String(hexStringToByteArray(fixedXOR(i, x)), "UTF-8"))
    println(singleByteXORCipher())
  }

  def hexToBase64(): String = {
    val hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    val hex_bytes = hexStringToByteArray(hex)
    val ret = new BASE64Encoder().encode(hex_bytes)
    return ret
  }

  def fixedXOR(input: String, xorin: String): String = {
    val iterator1 = input.sliding(2, 2)
    val iterator2 = xorin.sliding(2, 2)
    val result = new StringBuilder
    while (iterator1.hasNext) {
      scala.util.control.Exception.ignoring(classOf[NumberFormatException]) {
        val i = Integer.toString(Integer.parseInt(iterator1.next(), 16) ^ Integer.parseInt(iterator2.next(), 16), 16)
        result.append(i)
      }
    }
    return result.toString()
  }

  def fixedXORLowLevel(i: String, x: String): String = {
    val i_bytes = hexStringToByteArray(i)
    val x_bytes = hexStringToByteArray(x)
    val buf : Array[Byte] = new Array[Byte](i_bytes.length)
    for(ix <- 0 until i_bytes.length) {
      buf(ix) = (i_bytes(ix) ^ x_bytes(ix % x_bytes.length)).toByte
    }
    val res = new String(buf)
    return res
  }


  def singleByteXORCipher(): (Int, String) = {
    val hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    val min = 0
    val max = 255
    val hex_size = hex.length
    var res_count = 0
    var res_char = 0
    var res = ""
    for( guess <- min to max) {
      //println(guess)
      var guess_str = ""
      for(g <- 0 until hex_size) {
        guess_str = guess_str + s"$guess"
      }
      //println(guess_str)
      //println(hex)
      val xor_res = fixedXORLowLevel(hex, guess_str)
      //println(xor_res)
      val chars = xor_res.toCharArray()
      var char_count = 0
      for(c <- 0 until chars.length) {
        if(isEnglishCharacter(chars(c))) {
          char_count += 1
        }
      }
      if(char_count > res_count) {
        res_count = char_count
        res_char = guess
        res = xor_res
      }

    }

    return (res_char, res)
  }

  def isEnglishCharacter(c: Char): Boolean = {
    val s = "abcdefghijklmnopqurstwxyzABCDEFGHIJKLMNOPQURSTWXYZ0123456789"
    if(s.count(_ == c) > 0) {
      return true
    }  else {
      return false
    }

  }

  def hexStringToByteArray(s: String) = {
    augmentString(s).grouped(2).map(cc => {
      if(cc.length == 1) {
        (Character.digit(cc(0),16) << 4).toByte
      } else {
        (Character.digit(cc(0),16) << 4 | Character.digit(cc(1),16)).toByte
      }
    }).toArray
  }
}
