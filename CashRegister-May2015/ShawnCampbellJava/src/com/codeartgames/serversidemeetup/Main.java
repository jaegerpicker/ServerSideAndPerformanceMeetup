import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

class Denomination {
    private Float value;
    private String name;
    public float getValue() {
        return this.value;
    }
    public void setValue(float value) {
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Denomination(String name, Float value) {
        this.setName(name);
        this.setValue(value);
    }
}


public class Main {

    public static void main(String[] args) throws IOException{
	// write your code here
        HashMap<Float, Denomination> denom_list = new HashMap<Float, Denomination>();
        denom_list.put(0.01f, new Denomination("PENNY", 0.01f));
        denom_list.put(0.05f, new Denomination("NICKEL", 0.05f));
        denom_list.put(0.10f, new Denomination("DIME", 0.10f));
        denom_list.put(0.25f, new Denomination("QUARTER", 0.25f));
        denom_list.put(0.50f, new Denomination("HALF DOLLAR", 0.50f));
        denom_list.put(1.00f, new Denomination("ONE", 1.00f));
        denom_list.put(2.00f, new Denomination("TWO", 2.00f));
        denom_list.put(5.00f, new Denomination("FIVE", 5.00f));
        denom_list.put(10.00f, new Denomination("TEN", 10.00f));
        denom_list.put(20.00f, new Denomination("TWENTY", 20.00f));
        denom_list.put(50.00f, new Denomination("FIFTY", 50.00f));
        denom_list.put(100.00f, new Denomination("ONE HUNDRED", 100.00f));
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while((line = buffer.readLine()) != null) {
            line = line.trim();
            String[] vals = line.split(";");
            Float price = Float.parseFloat(vals[0]);
            Float cash = Float.parseFloat(vals[1]);
            //System.out.println(price);
            //System.out.println(cash);
            //System.out.println(cash - price);
            if(price > cash) {
                System.out.println("ERROR");
            } else if(price.equals(cash)) {
                System.out.println("ZERO");
            } else {
                String output = "";
                Float diff = cash - price;
                SortedSet<Float> keys = new TreeSet<Float>(Collections.reverseOrder());
                keys.addAll(denom_list.keySet());
                for(Float f : keys) {
                    if(f < diff) {
                        diff -= f;
                        output += denom_list.get(f).getName();
                        while(diff > f) {
                            diff -= f;
                            output += "," + denom_list.get(f).getName();
                        }
                        //System.out.println(diff);
                        if (diff > keys.last()) {
                            output += ",";
                        } else {
                            break;
                        }
                    }
                }
                System.out.println(output);
            }
        }

    }
}
