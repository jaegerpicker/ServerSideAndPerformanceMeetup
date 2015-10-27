using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Cryptopals_Shawn_CSharp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            Cryptopals cp = new Cryptopals();
            var hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";
            var bytes = Util.HexToBytes(hex);
            var expected = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t";
            var base64 = cp.BytesToBase64(bytes);
            textBox.AppendText($"1: hex: {hex}\n");
            textBox.AppendText($"1: expected: {expected}\n");
            textBox.AppendText($"1: actual: {base64}\n");
        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
            var hex = "1c0111001f010100061a024b53535009181c";
            var key = "686974207468652062756c6c277320657965";
            var expected = "746865206b696420646f6e277420706c6179";
            Cryptopals cp = new Cryptopals();
            var actual = Util.ToHex(cp.Xor(Util.HexToBytes(hex), Util.HexToBytes(key)));
            textBox.AppendText($"2: hex: {hex}\n");
            textBox.AppendText($"2: key: {key}\n");
            textBox.AppendText($"2: expected: {expected}\n");
            textBox.AppendText($"2: actual: {actual}\n");
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            var cp = new Cryptopals();
            var results = cp.BreakXor();
            textBox.AppendText("3: expected: Cooking MC's like a pound of bacon\n");
            textBox.AppendText($"3: actual: {results}\n");
        }
    }
}
