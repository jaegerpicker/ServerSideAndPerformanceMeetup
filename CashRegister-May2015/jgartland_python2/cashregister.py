import sys
# import numpy

denominations = [
    10000, 5000, 2000, 1000, 500, 100, 50, 25, 10, 5, 1, 0
]

denom_dict = {
    0: "ZERO",
    1: "PENNY",
    5: "NICKEL",
    10: "DIME",
    25: "QUARTER",
    50: "HALF DOLLAR",
    100: "ONE",
    500: "FIVE",
    1000: "TEN",
    2000: "TWENTY",
    5000: "FIFTY",
    10000: "ONE HUNDRED"
}


# ---------------------------------------------------------------------
def calculate_transaction(in_cost, in_payment):
    cost = float(in_cost) * 100.00
    payment = float(in_payment) * 100.00
    if cost > payment:
        print "ERROR"
    else:
        make_you_some_change(payment - cost, [], 0)

# ---------------------------------------------------------------------
def approx_equal(a, b, tol):
    return (abs(a-b) < tol)

# ---------------------------------------------------------------------
def make_you_some_change(in_amount, val_list, index_denom):
    if approx_equal(in_amount, 0.00, 0.00001):
        print (
            ','.join(['%s' % denom_dict[v] for v in val_list])
            if len(val_list) > 1
            else denom_dict[len(val_list)] if not val_list
            else denom_dict[val_list[0]]
        )
    else:
        #if (in_amount - denominations[index_denom]) < 0.001
        if approx_equal(in_amount, denominations[index_denom], 0.001) or (in_amount > denominations[index_denom]):
        #if numpy.greater_equal(in_amount, denominations[index_denom]):
            val_list.append(denominations[index_denom])
            make_you_some_change(
                in_amount - denominations[index_denom], val_list, index_denom
            )
            val_list.pop(len(val_list) - 1)
            return  # add the return to get the list off the first pop, this is our optimized change list
        if index_denom + 1 < len(denominations):
            make_you_some_change(in_amount, val_list, index_denom + 1)


# ---------------------------------------------------------------------
def read_in_data_from_file(infile):
    with open(infile, 'r') as f:
        data = f.read()
        return data

# ---------------------------------------------------------------------
if __name__ == "__main__":
    for lines in read_in_data_from_file(sys.argv[1]).split('\n'):
        x, y = lines.split(';')
        calculate_transaction(x, y)