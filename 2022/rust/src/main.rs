mod day1;
use std::fs;



fn main() {

    let day1 = fs::read_to_string("../input/day1").expect("Unable to read day 1 file");

    println!("--- [ Day 1 ] ---");
    let day1part1 = day1::part1(&day1);
    let day1part2 = day1::part2(&day1);

    println!("Part 1: {}", day1part1);
    println!("Part 2: {}", day1part2);

}
