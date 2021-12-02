package main

import (
  "fmt"
  "bufio"
  "os"
  "log"
  "strconv"
  "strings"
)

type Direction int

const (
  Up Direction = iota + 1
  Down
  Forward
  Unknown
)

type movement struct {
  direction Direction
  ammount int
}

func getDirections() []movement {
  result := make([]movement, 0)

  f, err := os.Open("../../input/day02.data")
  if err != nil {
    log.Fatal(err)
  }

  defer f.Close()

  scanner := bufio.NewScanner(f)

  for scanner.Scan() {
    splitTxt := strings.Split(scanner.Text(), " ")

    dir := Unknown
    ammount, _ :=  strconv.Atoi(splitTxt[1])


    if splitTxt[0] == "forward" {
      dir = Forward
    }

    if splitTxt[0] == "up" {
      dir = Up
    }

    if splitTxt[0] == "down" {
      dir = Down
    }

    result = append(result, movement{dir, ammount})
  }


  return result
}

func calcPosition(lst []movement) (int, int) {
  depth := 0
  horizontal := 0

  for _, item := range lst{
    switch(item.direction){
      case Up:
        depth -= item.ammount
        break
      case Down:
        depth += item.ammount
        break
      case Forward:
        horizontal += item.ammount
        break
    }
  }

  return depth, horizontal
}

func part1() int{
  d, h := calcPosition(getDirections())
  return d * h;
}

func part2() int{
  return 0;
}

func main(){
  fmt.Printf("Part 1: %d\n", part1())
  fmt.Printf("Part 2: %d\n", part2())
}
