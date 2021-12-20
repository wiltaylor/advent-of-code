package main

import (
  "fmt"
  "bufio"
  "os"
  "log"
)

type binCount struct {
  one int
  zero int
}

func parseInput()[]binCount {
  result := make([]binCount, 12)

  f, err := os.Open("../../input/day03.data")
  if err != nil {
    log.Fatal(err)
  }

  defer f.Close()

  scanner := bufio.NewScanner(f)

  for scanner.Scan() {
    txt := scanner.Text()

    for i := 0; i < 12; i++ {
      if txt[i] == '0' {
        result[i].zero++
      } else {
        result[i].one++
      }
    }
  }

  return result
}

func bin2dec(txt string) int {
  result := 0;

  rate := 1

  for i := 11; i >= 0; i-- {
    if txt[i] == '1' {
      result += rate
    }

    rate = rate * 2
  }
  
  return result
}

func getBinFromList(lst []binCount, greater bool) string {
  result := "";

  for i := 0; i < 12; i++ {
    if lst[i].one > lst[i].zero {
      if greater {
        result += "1"
      }else{
        result += "0"
      }
    }else{
      if greater {
        result += "0"
      }else{
        result += "1" 
      }
    }
  }

  return result
}

func part1() int{
  data := parseInput()
  gammaBin := getBinFromList(data, true)
  epsilonBin := getBinFromList(data, false)

  gamma := bin2dec(gammaBin)
  epsilon := bin2dec(epsilonBin)

  return gamma * epsilon;
}

func part2() int{
  return 0;
}

func main(){
  fmt.Printf("Part 1: %d\n", part1())
  fmt.Printf("Part 2: %d\n", part2())
}
