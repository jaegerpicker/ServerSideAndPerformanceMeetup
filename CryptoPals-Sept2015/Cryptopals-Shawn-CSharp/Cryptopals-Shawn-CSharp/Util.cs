using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cryptopals_Shawn_CSharp
{
    public static class Util
    {
        public static byte[] HexToBytes(string hex)
        {
            var bytes = new List<byte>();
            for (int i = 0; i < hex.Length; i += 2)
            {
                var v = byte.Parse(hex.Substring(i, 2), System.Globalization.NumberStyles.HexNumber);
                bytes.Add(v);
            }
            return bytes.ToArray();
        }

        public static string ToHex(byte[] bytes)
        {
            var sb = new StringBuilder(bytes.Length * 2);
            foreach(var b in bytes)
            {
                sb.Append(b.ToString("x2"));
            }
            return sb.ToString();
        }
    }
}
