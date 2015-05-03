package main

import (
    "os"
	"bufio"
	"bytes"
	"io"
	"fmt"
	"strings"
	"strconv"
)

func readLines(path string) (lines []string, err error) {
	var (
		file *os.File
		part []byte
		prefix bool
		)
	if file, err = os.Open(path); err != nil {
		return
	}
	defer file.Close()

	reader := bufio.NewReader(file)
	buffer := bytes.NewBuffer(make([]byte, 0))
	for {
		if part, prefix, err = reader.ReadLine(); err != nil {
			break
		}
		buffer.Write(part)
		if !prefix {
			lines = append(lines, buffer.String())
			buffer.Reset()
		}
	}
	if err == io.EOF {
		err = nil
	}
	return
}

func parseLine(line string) ([][]string) {
	arr := strings.Split(line, "")
	//err := nil
	width, err := strconv.Atoi(arr[2])
	height, err := strconv.Atoi(arr[0])
	if err != nil  {
		fmt.Println(err)
	}
	matrix := make([][]string, height)
	for i := range matrix {
		matrix[i] = make([]string, width)
		for j := range matrix[i] {
			matrix[i][j] = arr[4 + ((i * width) + j)]
		}

	}
	//fmt.Println(matrix)
	return matrix
}

func findNeighbors(matrix [][]string, x int, y int) int {
	ret := 0
	//fmt.Println(x)
	//fmt.Println(y)
	for i := -1; i <= 1; i++ {
		for j := -1; j <= 1; j++ {
			w := x + i
			h := j + y
			if w >= 0 && h >= 0 && w < len(matrix) && h < len(matrix[0]) {
				//fmt.Print(w)
				//fmt.Print(" ")
				//fmt.Print(h)
				//fmt.Print(matrix[w][h])
				if matrix[w][h] == "*" {
					ret++
				}
			}
			
			//if matrix[x + i][j + y] == "*" {
			//	ret++
			//}
		}
	}
	return ret
}


func main() {
	lines, err := readLines(os.Args[1])
	if err != nil {
		fmt.Println("Error: %s\n", err)
		return
	}
	for _, line := range lines {
		//fmt.Println(line)
		ma := parseLine(line)
		//fmt.Println(ma)
		for i := range ma {
			for j := range ma[i] {
				if ma[i][j] == "*" {
					fmt.Print("*")
				} else {
					fmt.Print(findNeighbors(ma, i, j))
				}
			}
		}
		fmt.Println()
	}

}