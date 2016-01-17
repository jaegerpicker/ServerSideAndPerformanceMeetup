#include <iostream>
#include <complex>
#include <valarray>
#include <fstream>
#include <string>
#include <vector>


using namespace std;

const double PI = 3.141592653;
typedef complex<double> Complex;
typedef valarray<Complex> CArray;

void fft(CArray& x)
{
    const size_t N = x.size();
    if (N <= 1) return;

    // divide
    CArray even = x[std::slice(0, N/2, 2)];
    CArray  odd = x[std::slice(1, N/2, 2)];

    // conquer
    fft(even);
    fft(odd);

    // combine
    for (size_t k = 0; k < N/2; ++k)
    {
        Complex t = std::polar(1.0, -2 * PI * k / N) * odd[k];
        x[k    ] = even[k] + t;
        x[k+N/2] = even[k] - t;
    }
}

vector<string> &split(const string &s, char delim, vector<string> &elem) {
    stringstream ss(s);
    string item;
    while(getline(ss, item, delim)) {
        elem.push_back(item);
    }
    return elem;
}

vector<string> split(const string &s, char delim) {
    vector<string> elems;
    split(s, delim, elems);
    return elems;
}

int main() {
    const Complex test[] = { 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0 };
    string line;
    ifstream infile;
    infile.open("examples.txt");
    while(getline(infile, line)) {
        vector<string> x = split(line, ' ');
        vector<double> xd;
        for(int i =0; i < x.size(); i++) {

            xd.push_back(stod(x[i]));
            //cout<<xd[i];
        }
        //cout<<endl;
        Complex *test2 = new Complex[xd.size()];
        copy(xd.begin(), xd.end(), test2);
        //cout<<line << endl;
        CArray data(test2, xd.size());
        fft(data);
        //cout << "fft " << endl;
        for (int i = 0; i < xd.size(); ++i) {
            //cout << data[i] << endl;
        }
        int sd = data.size();
        double s = 20000 / data[sd - 1].imag();
        double freq = (sd - 1) * s;
        double freq2 = ((sd - 1) - (sd - 2)) * 20000/data[sd - 1].real();
        cout << "Freq " << freq << " s " << s << " data " << data[sd - 1].imag() << endl;
        cout << freq2;
        double fs = 20000;
        double N = xd.size();
        double peak = 0.0;
        double valley = 0.0;
        for(int j = 0; j < data.size(); j++) {
            if(data[j].real() > peak) {
                peak = data[j].real();
            }
            if(data[j].imag() > peak) {
                peak = data[j].imag();
            }
            if(data[j].imag() < valley) {
                valley = data[j].imag();
            }
            if(data[j].real() < valley) {
                valley = data[j].real();
            }
        }
        double freq3 = fs*valley/peak;
        cout<<endl<<freq3<<endl;
    }


    return 0;
}