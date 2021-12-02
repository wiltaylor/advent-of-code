with builtins;

let 
  input1 = readFile ../input/day1.1;
  splitLines = text: filter (item: (isString item && item != "")) (split "\n" text);
  data1 = map (f: toInt f) (splitLines input1);
  toInt = str: fromJSON str; # Very hacky but is actually how nixpkgs does it too.

  countIncreases = {last ? null, lst}: let
    current = head lst;
    remaining = tail lst;
    result = if (last == null) then 0 else (if (last < current) then 1 else 0);
    next = if (remaining == []) then 0 else (countIncreases { last = current; lst = remaining; });
  in result + next; 
in {
  part1 = ''${toString (countIncreases {lst = data1;})}'';
  part2 = ''test2'';
}
