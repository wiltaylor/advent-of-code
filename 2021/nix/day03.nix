with builtins;

let 
  input1 = readFile ../input/day03.data;
  splitLines = text: filter (item: (isString item && item != "")) (split "\n" text);
  toInt = str: fromJSON str; # Very hacky but is actually how nixpkgs does it too.

  str2bin = txt: let
    value = genList (x: if ((substring x 1 txt) == "1") then 1 else 0) (stringLength txt);
  in value;

  #Looks for most common bit. If they are both as common returns 1.
  findMostCommonBit = idx: lst: let
    counts = foldl' (left: right: let
      v = elemAt right idx;
    in {
      ones = if (v == 1) then (left.ones + 1) else left.ones;
      zeros = if (v == 0) then (left.zeros + 1) else left.zeros;
    }) { ones = 0; zeros = 0; } lst;

    result = if (counts.zeros > counts.ones) then 0 else 1;
  in result;

  findLeastCommonBit = idx: lst: let
    counts = foldl' (left: right: let
      v = elemAt right idx;
    in {
      ones = if (v == 1) then (left.ones + 1) else left.ones;
      zeros = if (v == 0) then (left.zeros + 1) else left.zeros;
    }) { ones = 0; zeros = 0; } lst;

    result = if (counts.ones >= counts.zeros) then 0 else 1;
  in result;

  filterListBasedOnBit = idx: bitValue: lst: filter (v: (elemAt v idx) == bitValue) lst;

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

  allValuesBinary = let 
    lineData = splitLines input1;
    values = map(line: str2bin line) lineData;
  in values;

  gammaBin = let
    lst = genList (idx: elemAt allData idx) (length allData);
    values = map (x: if(x.one > x.zero) then 1 else 0) lst;
  in values;

  epsilonBin = let
    lst = genList (idx: elemAt allData idx) (length allData);
    values = map (x: if(x.one < x.zero) then 1 else 0) lst;
  in values;

  oxygenGenerationBin = let
    calc = idx: lst: let
      bitVal = findMostCommonBit idx lst;
      filterLst = filterListBasedOnBit idx bitVal lst;

      val = if (length filterLst == 1) then (head filterLst) else (calc (idx + 1) filterLst);
    in val;

    values = calc 0 allValuesBinary;
  in values;

  co2ScrubberBin = let 
    calc = idx: lst: let
      bitValue = findLeastCommonBit idx lst;
      filterLst = filterListBasedOnBit idx bitValue lst;

      val = if (length filterLst == 1) then (head filterLst) else (calc (idx + 1) filterLst);
    in val;

    values = calc 0 allValuesBinary;
  in values;

  gamma = bin2dec gammaBin;
  epsilon = bin2dec epsilonBin;
  oxygenGeneration = bin2dec oxygenGenerationBin;
  co2Scrubber = bin2dec co2ScrubberBin;
  
  data1 = gamma * epsilon;
  data2 = oxygenGeneration * co2Scrubber;
in ''
  Gamma: ${toJSON gammaBin} -> ${toString gamma}
  epsilon: ${toJSON epsilonBin} -> ${toString epsilon}
  oxygenGeneration: ${toJSON oxygenGenerationBin} -> ${toString oxygenGeneration}
  co2Scrubber: ${toJSON co2ScrubberBin} -> ${toString co2Scrubber}

  Part 1: ${toString data1}
  Part 2: ${toString data2}
''
