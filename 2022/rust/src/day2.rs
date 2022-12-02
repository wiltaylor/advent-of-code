pub fn part1(input: &String) -> u64 {
    let input = input.split("\n");
    let mut result = 0;

    for line in input {
        if line == "" {
            continue;
        }
        let (op, player) = split_line(&line.to_string());
        let op = MoveType::parse_oponent(&op);
        let player = MoveType::parse_player(&player);

        result += score_row(&op, &player);
    }

    result
}

pub fn part2(input: &String) -> u64 {
    let input = input.split("\n");
    let mut result = 0;

    for line in input {
        if line == "" {
            continue;
        }
        let (op, player) = split_line(&line.to_string());
        let op = MoveType::parse_oponent(&op);
        let player = RequiredAction::parse(&player);
        let player_move = get_player_move(&op, &player);
        result += score_row(&op, &player_move);
    }

    result

}

fn split_line(text: &String) -> (String, String) {
    let mut parts = text.split(" ");

    let lhs = parts.next().expect("Expected lhs");
    let rhs = parts.next().expect("Expected rhs");

    (lhs.to_string(), rhs.to_string())
}

#[derive(Debug, PartialEq, Clone)]
enum MoveType {
    Rock,
    Paper,
    Scissors
}

impl MoveType {
    fn parse_oponent(text: &String) -> MoveType {
        if text == "A" {
            return MoveType::Rock;
        } else if text == "B" {
            return MoveType::Paper;
        } else if text == "C" {
            return MoveType::Scissors;
        }

        panic!("Unexpected type");
    }

    fn parse_player(text: &String) ->MoveType {
        if text == "X" {
            return MoveType::Rock;
        } else if text == "Y" {
            return MoveType::Paper;
        } else if text == "Z" {
            return MoveType::Scissors;
        }

        panic!("Unexpected type");
    }
}

#[derive(Debug, PartialEq)]
enum RequiredAction {
    Win,
    Lose,
    Draw,
}

impl RequiredAction {
    fn parse(text: &String) -> RequiredAction {
        if text == "X" {
            return RequiredAction::Lose;
        } else if text == "Y" {
            return RequiredAction::Draw;
        } else if text == "Z" {
            return RequiredAction::Win;
        }

        panic!("Unexpected type");

    }
}

fn get_player_move(opponent: &MoveType, player: &RequiredAction) -> MoveType {

    match player {
        RequiredAction::Win => {
            match opponent {
                MoveType::Rock => MoveType::Paper,
                MoveType::Paper => MoveType::Scissors,
                MoveType::Scissors => MoveType::Rock,
            }
        },
        RequiredAction::Lose => {
            match opponent {
                MoveType::Rock => MoveType::Scissors,
                MoveType::Paper => MoveType::Rock,
                MoveType::Scissors => MoveType::Paper,
            }
        },
        RequiredAction::Draw => {
            opponent.clone()
        },
    }
}

fn score_row(opponent: &MoveType, player: &MoveType) -> u64 {
    let mut score = 0;

    score += match player {
        MoveType::Rock => 1,
        MoveType::Paper => 2,
        MoveType::Scissors => 3,
    };

    if player == opponent {
        score += 3;
    }

    if player == &MoveType::Rock && opponent == &MoveType::Scissors {
        score += 6;
    }

    if player == &MoveType::Paper && opponent == &MoveType::Rock {
        score += 6;
    }

    if player == &MoveType::Scissors && opponent == &MoveType::Paper {
        score += 6;
    }    

    score
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_day2_part1() {
        let input = "A Y
B X
C Z".to_string();

        let result =part1(&input);

        assert_eq!(result, 15);
        
    }

    #[test]
    fn test_day2_part2() {
        let input = "A Y
B X
C Z".to_string();

        let result =part2(&input);

        assert_eq!(result, 12);
        
    }
}




