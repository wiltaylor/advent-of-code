pub fn part1(input: &String) -> u64 {
    let mut max_elf = 0;
    let mut current_elf = 0;

    let input = input.split("\n");


    for line in input {
        if line.trim() == "" {
            if current_elf > max_elf {
                max_elf = current_elf
            }

            current_elf = 0;
            continue;
        }

        let value: u64 = line.parse().unwrap();
        current_elf += value;
    }

    if current_elf > max_elf {
        max_elf = current_elf
    }

    max_elf
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_highest_cal() {
        let input = "1000
2000
3000

4000

5000
6000

7000
8000
9000

10000".to_string();

        let result =part1(&input);

        assert_eq!(result, 24000);
        
    }
}
