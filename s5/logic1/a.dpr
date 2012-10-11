{$APPTYPE CONSOLE}
var 
  N : integer; { Количество чисел }
  i : integer; { Счётчик цикла }
  X : int64; { Текущее число }
  Res : int64; { Результат }
begin
  Reset(Input,'repeat.in');
  Rewrite(Output,'repeat.out');
  Read(N); { Читаем количество чисел из входного файла }
  Res := 0;
  for i:=1 to N do begin
    Read(X);
    Res := Res XOR X;
  end;
  Writeln(Res); { Записываем результат в выходной файл }
end.