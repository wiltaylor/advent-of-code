package main

import (
  "fmt"
  "bufio"
  "os"
  "log"
  "strconv"
)

func windowBuilder(lst []int) []int {
  result := make([]int, 0)

  for index := range lst {
    if len(lst) - index < 3 {
      break
    }

    result = append(result, lst[index] + lst[index + 1] + lst[index + 2])
  }

  return result
}

func getListOfNumbers() []int {
  result := make([]int, 0)

  f, err := os.Open("../../input/day1.1")
  if err != nil {
    log.Fatal(err)
  }

  defer f.Close()
  
  scanner := bufio.NewScanner(f)

  for scanner.Scan() {
    current, _ := strconv.Atoi(scanner.Text())
    result = append(result, current)
  }

  return result
}

func countIncreaseInList(lst []int) int {
  last := 0
  first := true
  count := 0;

  for _, val := range lst {
    if !first {
      if last < val {
        count++
      }
    }else{
      first = false;
    }

    last = val
  }

  return count
}

func part1() int{
  return countIncreaseInList(getListOfNumbers())
}

func part2() int{
  lst := windowBuilder(getListOfNumbers())
  return countIncreaseInList(lst)
}

func main(){
  fmt.Printf("Part 1: %d\n", part1())
  fmt.Printf("Part 2: %d\n", part2())
}
