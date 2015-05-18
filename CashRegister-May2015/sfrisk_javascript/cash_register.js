const cash = {
  'ONE HUNDRED': 100.00,
  'FIFTY': 50.00,
  'TWENTY': 20.00,
  'TEN': 10.00,
  'FIVE': 5.00,
  'TWO': 2.00,
  'ONE': 1.00,
  'HALF DOLLAR': .50,
  'QUARTER': .25,
  'DIME': .10,
  'NICKEL': .05,
  'PENNY': .01
}
var fs  = require("fs");
fs.readFileSync(process.argv[2]).toString().split('\n').forEach(function (line) {
     if (line != "") {
     //do something here
     var money = line.split(";");
      if (money.length == 2) {
          if (money[1] < money[0]) {
              console.log("ERROR");
          } else if (money[1] == money[0]) {
              console.log("ZERO");
          }
          else {
              var difference = (money[1] - money[0]).toFixed(2);
              var change = [];
              for (var key in cash) {
                var t = Math.floor(difference/cash[key]);
                if( t >= 1 ) {
                  difference = (difference - t*cash[key]).toFixed(2);
                  for(i = 0; i < t; i ++) {
                    change.push(key);
                  }
                }
              }
              console.log(change.toString());
          }
      } else {
        console.log("ERROR");
      }
 }
});
