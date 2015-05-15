package main

import (
	"bufio"
	"bytes"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"
)

var denoms = map[int]string{
	10000: "ONE HUNDRED",
	5000:  "FIFTY",
	2000:  "TWENTY",
	1000:  "TEN",
	500:   "FIVE",
	100:   "ONE",
	50:    "HALF DOLLAR",
	25:    "QUARTER",
	10:    "DIME",
	5:     "NICKEL",
	1:     "PENNY",
	0:     "ZERO",
}

type Transaction struct {
	PurchasePrice int
	Cash          int
}

func (t *Transaction) calculateChange() string {
	if t.Cash < t.PurchasePrice {
		return "ERROR"
	}

	if t.Cash == t.PurchasePrice {
		return "ZERO"
	}

	keys := make([]int, 0, len(denoms))
	for k := range denoms {
		keys = append(keys, k)
	}
	sort.Sort(sort.Reverse(sort.IntSlice(keys)))

	diff := t.Cash - t.PurchasePrice

	var buf bytes.Buffer
	for _, i := range keys {
		j := diff / i
		if j > 0 {
			for k := 0; k < j; k++ {
				buf.WriteString(denoms[i])
				diff = diff - i
				if diff > 0 {
					buf.WriteString(",")
				}
			}
			if diff == 0 {
				break
			}
		}
	}
	return buf.String()
}

func main() {
	args := os.Args[1:]

	file, err := os.Open(args[0])
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		parts := strings.Split(scanner.Text(), ";")
		if len(parts) != 2 {
			log.Printf("Found more than two parts!")
			continue
		}
		pp, err := strconv.ParseFloat(parts[0], 64)
		if err != nil {
			log.Printf("Failed to parse %s", parts[0])
			continue
		}
		c, err := strconv.ParseFloat(parts[1], 64)
		if err != nil {
			log.Printf("Failed to parse %s", parts[0])
			continue
		}
		t := &Transaction{
			PurchasePrice: int(pp * 100),
			Cash:          int(c * 100),
		}
		log.Print(t.calculateChange())
	}
}
