with builtins;

let 
  input1 = readFile ../input/day02.data;
  splitLines = text: filter (item: (isString item && item != "")) (split "\n" text);
  toInt = str: fromJSON str; # Very hacky but is actually how nixpkgs does it too.

  parseLine = txt: let 
    splitTxt = filter(item: (isString item)) (split " " txt);
    direction = head splitTxt;
    ammount = toInt (elemAt splitTxt 1);
  in { inherit direction ammount; };

  calcDepth = lst: let
    line = head lst;
    remain = tail lst;
    depth = if (line.direction == "down") then line.ammount else
            if (line.direction == "up") then -line.ammount else 0;
    total = depth + (if (remain != []) then (calcDepth remain) else 0);
  in total;

  calcHorizontal = lst: let
    line = head lst;
    remain = tail lst;
    horizontal = if(line.direction == "forward") then line.ammount else 0;
    total = horizontal + (if (remain != []) then (calcHorizontal remain) else 0);
  in total;

  moveData = map (f: parseLine f) (splitLines input1);

  data1 = ((calcDepth moveData) * (calcHorizontal moveData));
  data2 = newLocation.depth * newLocation.horizontal;

  newLocation = foldl' (left: right: let 
    extraAim = if (right.direction == "down") then right.ammount else
               if (right.direction == "up") then -right.ammount else 0;
    extraHorizontal = if (right.direction == "forward") then right.ammount else 0;
    extraDepth = if (right.direction == "forward") then (right.ammount * left.aim) else 0;
    
    aim = left.aim + extraAim;
    horizontal = left.horizontal + extraHorizontal;
    depth = left.depth + extraDepth;

  in {inherit aim depth horizontal;}) { aim = 0; depth = 0; horizontal = 0;} moveData;

in ''
  Part 1: ${toString data1}
  Part 2: ${toString data2}
''
