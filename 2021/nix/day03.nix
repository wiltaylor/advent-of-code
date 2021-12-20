with builtins;

let 
  input1 = readFile ../input/day03.data;
  splitLines = text: filter (item: (isString item && item != "")) (split "\n" text);
  toInt = str: fromJSON str; # Very hacky but is actually how nixpkgs does it too.
  bin2dec = lst: let
    e0 = elemAt lst 0;
    e1 = elemAt lst 1;
    e2 = elemAt lst 2;
    e3 = elemAt lst 3;
    e4 = elemAt lst 4;
    e5 = elemAt lst 5;
    e6 = elemAt lst 6;
    e7 = elemAt lst 7;
    e8 = elemAt lst 8;
    e9 = elemAt lst 9;
    e10 = elemAt lst 10;
    e11 = elemAt lst 11;
  in e11 + (e10 * 2) + (e9 * 4) + (e8 * 8) + (e7 * 16) + (e6 * 32) + (e5 * 64) + (e4 * 128) + (e3 * 256) + (e2 * 512) + (e1 * 1024) + (e0 * 2048);

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
  in [
    (countPos lineData 0)
    (countPos lineData 1)
    (countPos lineData 2)
    (countPos lineData 3)
    (countPos lineData 4)
    (countPos lineData 5)
    (countPos lineData 6)
    (countPos lineData 7)
    (countPos lineData 8)
    (countPos lineData 9)
    (countPos lineData 10)
    (countPos lineData 11)
  ];

  gammaBin = let
    e0 = elemAt allData 0;
    e1 = elemAt allData 1;
    e2 = elemAt allData 2;
    e3 = elemAt allData 3;
    e4 = elemAt allData 4;
    e5 = elemAt allData 5;
    e6 = elemAt allData 6;
    e7 = elemAt allData 7;
    e8 = elemAt allData 8;
    e9 = elemAt allData 9;
    e10 = elemAt allData 10;
    e11 = elemAt allData 11;
  in [
    (if (e0.one > e0.zero) then 1 else 0)
    (if (e1.one > e1.zero) then 1 else 0)
    (if (e2.one > e2.zero) then 1 else 0)
    (if (e3.one > e3.zero) then 1 else 0)
    (if (e4.one > e4.zero) then 1 else 0)
    (if (e5.one > e5.zero) then 1 else 0)
    (if (e6.one > e6.zero) then 1 else 0)
    (if (e7.one > e7.zero) then 1 else 0)
    (if (e8.one > e8.zero) then 1 else 0)
    (if (e9.one > e9.zero) then 1 else 0)
    (if (e10.one > e10.zero) then 1 else 0)
    (if (e11.one > e11.zero) then 1 else 0)
  ];

  epsilonBin = let
    e0 = elemAt allData 0;
    e1 = elemAt allData 1;
    e2 = elemAt allData 2;
    e3 = elemAt allData 3;
    e4 = elemAt allData 4;
    e5 = elemAt allData 5;
    e6 = elemAt allData 6;
    e7 = elemAt allData 7;
    e8 = elemAt allData 8;
    e9 = elemAt allData 9;
    e10 = elemAt allData 10;
    e11 = elemAt allData 11;
  in [
    (if (e0.one < e0.zero) then 1 else 0)
    (if (e1.one < e1.zero) then 1 else 0)
    (if (e2.one < e2.zero) then 1 else 0)
    (if (e3.one < e3.zero) then 1 else 0)
    (if (e4.one < e4.zero) then 1 else 0)
    (if (e5.one < e5.zero) then 1 else 0)
    (if (e6.one < e6.zero) then 1 else 0)
    (if (e7.one < e7.zero) then 1 else 0)
    (if (e8.one < e8.zero) then 1 else 0)
    (if (e9.one < e9.zero) then 1 else 0)
    (if (e10.one < e10.zero) then 1 else 0)
    (if (e11.one < e11.zero) then 1 else 0)
  ];
  
  gamma = bin2dec gammaBin;
  epsilon = bin2dec epsilonBin;
  
  data1 = gamma * epsilon;
  data2 = 0;


in ''
  Part 1: ${toString data1}
  Part 2: ${toString data2}
''
