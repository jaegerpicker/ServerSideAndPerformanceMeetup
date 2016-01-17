var fft = require('fft-js').fft;
var fftutil = require('fft-js').util;
var fs = require('fs');

fs.readFileSync(process.argv[2]).toString().split('\n').forEach(function(line) {
  if(line != "") {
    var stringLine = line.split(' ');
    var signal = stringLine.map(Number);
    var phasors = fft(signal);
    var frequencies = fftutil.fftFreq(phasors, 2000), magnitudes = fftutil.fftMag(phasors);

    var both = frequencies.map(function(f, ix) {
      return {frequency: f, magnitude: magnitudes[ix]};
    });

    console.log(both);
  }
});
