using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Cryptopals_Shawn_CSharp.Tests
{
    [TestClass]
    public class ProblemSet1
    {
        [TestMethod]
        public void TestProblem1()
        {
            Cryptopals cp = new Cryptopals();
            var hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";
            var bytes = Util.HexToBytes(hex);
            var expected = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t";
            var base64 = cp.BytesToBase64(bytes);
            Assert.AreEqual(expected, base64);
        }

        [TestMethod]
        public void TestProblem2()
        {
            var hex = "1c0111001f010100061a024b53535009181c";
            var key = "686974207468652062756c6c277320657965";
            var expected = "746865206b696420646f6e277420706c6179";
            Cryptopals cp = new Cryptopals();
            var actual = Util.ToHex(cp.Xor(Util.HexToBytes(hex), Util.HexToBytes(key)));
            Assert.AreEqual(expected, actual);
        }

        [TestMethod]
        public void TestProblem3()
        {
            var cp = new Cryptopals();
            var results = cp.BreakXor();
            Assert.AreEqual("Cooking MC's like a pound of bacon", results);
        }

    }
}
