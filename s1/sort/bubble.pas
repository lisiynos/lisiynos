program bubble;
var n, i, j, c: Integer;
  a: array [1..5000] of Int64;
begin
  assign(Input, 'bubble.in');
  assign(Output, 'bubble.out');
  reset(Input);
  rewrite(Output);
  readln(n);
  for i := 1 to n do
    read(a[i]);
  close(Input);
  for i := 1 to n do
    for j := (n - 1) downto i do
      if a[j] > a[j + 1] then
      begin
        c := a[j];
        a[j] := a[j + 1];
        a[j + 1] := c;
      end;
  for j := 1 to n do
    write(a[j], ' ');

  close(Output);
end.
