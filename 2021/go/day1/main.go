package main

import (
  "fmt"
  "bufio"
  "os"
  "log"
  "strconv"
)

func part1(){
  f, err := os.Open("../../input/day1.1")

  if err != nil {
    log.Fatal(err)
  }

  defer f.Close()
  
  scanner := bufio.NewScanner(f)

  last := 0
  first := true
  count := 0;

  for scanner.Scan() {
    current, _ := strconv.Atoi(scanner.Text())
    text := "unknown"

    if !first {
      if last < current {
        count++
        text = "increase"
      }else if last == current {
        text = "same"
      }else{
        text = "decrease"
      }
    }else{
      first = false
    }

    fmt.Printf("%d -> %d - %s\n",last,current, text)

    last = current
  }

  fmt.Printf("Total Count: %d\n", count)
}

func main(){
  part1()
}
