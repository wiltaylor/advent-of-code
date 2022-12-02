mod day1;
mod day2;
use std::fs;



fn main() {

    let day1 = fs::read_to_string("../input/day1").expect("Unable to read day 1 file");
    let day2 = fs::read_to_string("../input/day2").expect("Unable to read day 2 file");

    println!("--- [ Day 1 ] ---");
    let day1part1 = day1::part1(&day1);
    let day1part2 = day1::part2(&day1);

    println!("Part 1: {}", day1part1);
    println!("Part 2: {}", day1part2);

    println!("--- [ Day 2 ] ---");
    let day2part1 = day2::part1(&day2);
    let day2part2 = day2::part2(&day2);

    println!("Part 1: {}", day2part1);
    println!("Part 2: {}", day2part2);

}
