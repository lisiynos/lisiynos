{$APPTYPE CONSOLE}
var 
  N : integer; { ���������� ����� }
  i : integer; { ������� ����� }
  X : int64; { ������� ����� }
  Res : int64; { ��������� }
begin
  Reset(Input,'repeat.in');
  Rewrite(Output,'repeat.out');
  Read(N); { ������ ���������� ����� �� �������� ����� }
  Res := 0;
  for i:=1 to N do begin
    Read(X);
    Res := Res XOR X;
  end;
  Writeln(Res); { ���������� ��������� � �������� ���� }
end.