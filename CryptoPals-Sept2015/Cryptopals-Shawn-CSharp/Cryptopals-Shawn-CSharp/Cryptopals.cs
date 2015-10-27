using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cryptopals_Shawn_CSharp
{
    public class Cryptopals
    {
        public string BytesToBase64(byte[] bytes)
        {
            return Convert.ToBase64String(bytes);
        }

        public byte[] Xor(byte[] val, byte[] key)
        {
            var res = new byte[val.Length];
            for(int i = 0; i < val.Length; i++)
            {
                res[i] = (byte)(val[i] ^ key[i]);
            }
            return res;
        }

        public string BreakXor()
        {
            byte[] bytes = null;
            int topScore = 0;
            var hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736";
            var h_bytes = Util.HexToBytes(hex);
            for(int i = 0; i < 256; i++)
            {
                var keyByte = (byte)i;
                var keyBytes = new byte[hex.Length];
                //Console.WriteLine(keyByte);
                for (int j = 0; j < keyBytes.Length; j++)
                {
                    keyBytes[j] = keyByte;
                }
                var res = Xor(h_bytes, keyBytes);
                //Console.WriteLine(res);
                var score = Score(res);
                //Console.WriteLine(score);
                if (i == 0)
                {
                    bytes = res;
                    topScore = score;
                }
                else if(score > topScore)
                {
                    bytes = res;
                    topScore = score;
                }
                //Console.WriteLine(new string(res.Select(x => (char)x).ToArray()));
            }
            string bytes_string = new string(bytes.Select(x => (char)x).ToArray());
            return bytes_string;
        }

        private int Score(byte[] bytes)
        {
            int total = 0;
            char[] lookup = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".ToArray();
            foreach (byte b in bytes)
            {
                if(lookup.Contains((char)b))
                {
                    total++;
                }
            }
            return total;
        }
    }
}
