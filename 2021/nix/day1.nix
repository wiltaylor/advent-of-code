with builtins;

let 
  input1 = readFile ../input/day1.1;
  splitLines = text: filter (item: (isString item && item != "")) (split "\n" text);
  data1 = map (f: toInt f) (splitLines input1);
  data2 = buildWindow data1;
  toInt = str: fromJSON str; # Very hacky but is actually how nixpkgs does it too.

  buildWindow = lst: let
    canNext = if canWork then (length (tail lst) >= 3) else false;
    canWork = if (isList lst && (length lst >= 3)) then true else false;
    a = head lst;
    b = head (tail lst);
    c = head (tail (tail lst));
    result = if canWork then ([(a + b + c)]) else [];
    extra = if canWork then (if canNext then (buildWindow (tail lst)) else []) else [];
  in result ++ extra;

  countIncreases = {last ? null, lst}: let
    current = head lst;
    remaining = tail lst;
    result = if (last == null) then 0 else (if (last < current) then 1 else 0);
    next = if (remaining == []) then 0 else (countIncreases { last = current; lst = remaining; });
  in result + next; 
in {
  part1 = ''${toString (countIncreases {lst = data1;})}'';
  part2 = ''${toString (countIncreases {lst = data2;})}'';
}
