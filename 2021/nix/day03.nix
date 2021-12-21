with builtins;

let 
  input1 = readFile ../input/day03.data;
  splitLines = text: filter (item: (isString item && item != "")) (split "\n" text);
  toInt = str: fromJSON str; # Very hacky but is actually how nixpkgs does it too.

  bin2dec = lst: let
    calc = idx: factor: let
      e = elemAt lst idx;
      v = e * factor;
      nextIdx = idx - 1;
      nextFactor = factor * 2;
      value = if (idx == 0) then v else v + (calc nextIdx nextFactor);
    in value;

    len = length lst;

    val = calc (len - 1) 1;
  in val;
      
   parseLine = txt: let 
    splitTxt = filter(item: (isString item)) (split " " txt);
    direction = head splitTxt;
    ammount = toInt (elemAt splitTxt 1);
  in { inherit direction ammount; };

  countPos = lines: idx: foldl' (left: right: let
    txt = substring idx 1 right;
  in {
    one = if (txt == "1") then (left.one + 1) else left.one;
    zero = if (txt == "0") then (left.zero + 1) else left.zero;
  }) { one = 0; zero = 0; } lines;

  allData = let
    lineData = splitLines input1;
    firstLine = elemAt lineData 0;
    values = genList (idx: countPos lineData idx) (stringLength firstLine);
  in values;

  gammaBin = let
    lst = genList (idx: elemAt allData idx) (length allData);
    values = map (x: if(x.one > x.zero) then 1 else 0) lst;
  in values;

  epsilonBin = let
    lst = genList (idx: elemAt allData idx) (length allData);
    values = map (x: if(x.one < x.zero) then 1 else 0) lst;
  in values;

  gamma = bin2dec gammaBin;
  epsilon = bin2dec epsilonBin;
  
  data1 = gamma * epsilon;
  data2 = 0;


in ''
  Gamma: ${toJSON gammaBin} -> ${toString gamma}
  epsilon: ${toJSON epsilonBin} -> ${toString epsilon}

  Part 1: ${toString data1}
  Part 2: ${toString data2}
''
