{$APPTYPE CONSOLE}
var 
  N : int64;
  i : longint;
begin
  Assign(Input,'factor.in'); Reset(Input);
  Assign(Output,'factor.out'); Rewrite(Output);
  Read(N);
  Write(N,' =');
  for i:=2 to trunc(sqrt(N)) do { Перебираем все числа до корня из N }
    while N mod i = 0 do begin { Пока N делится на i }
      write(' ',i); { Выводим множитель i }
      N := N div i; { Делим на i }
      if N <> 1 then write(' *'); { Если ещё будут множители, то выводим знак умножения }
    end;
  if N<>1 then write(' ',N); { Оставшийся множитель }
end.