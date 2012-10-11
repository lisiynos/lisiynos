{$APPTYPE CONSOLE}
var 
  i,k,period : integer;
  a,b,c,d,x : int64;
  v : array [0..999999] of integer; { На какой позиции было это значение, -1 - ещё не было }
begin
  Assign(Input,'sequence.in'); Reset(Input);
  Assign(Output,'sequence.out'); ReWrite(Output);
  { Чтение входных данных }
  read(a, b, c, d, k);
  { Решение }
  for i:=low(v) to high(v) do v[i] := -1; { Ни одного значения не было }
  x := a; v[x] := 0;
  i := 1;
  while i<=k do begin
    x := (((b*x) mod c)+x+d) mod 1000000;
    if v[x]<>-1 then begin { Такой элемент уже был => мы нашли период последовательности }
      period := i-v[x];
      k := i + (k-i) mod period;
    end;
    v[x] := i;
    inc(i);    
  end;
  { Вывод ответа }
  writeln(x);
end.