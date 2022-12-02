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

fn push_top_elf(data: &mut Vec<u64>, value:u64) {
    
    let mut last_val = 0;
    let mut push_down = false;

    for i in 0..data.len() {
        if push_down {
            let val = data[i];
            data[i] = last_val;
            last_val = val;
            continue;
        }

        if data[i] < value {
            last_val = data[i];
            push_down = true;
            data[i] = value;
            continue;
        }
    }
}

pub fn part2(input: &String) -> u64 {
    let mut top_elves: Vec<u64> = vec![0,0,0];
    let mut current_elf = 0;

    let input = input.split("\n");


    for line in input {
        if line.trim() == "" {
            
            push_top_elf(&mut top_elves, current_elf);
            current_elf = 0;
            continue;
        }

        let value: u64 = line.parse().unwrap();
        current_elf += value;
    }

    push_top_elf(&mut top_elves, current_elf);

    let mut result = 0;

    for elf in top_elves {
        result += elf;
    }

    result
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
