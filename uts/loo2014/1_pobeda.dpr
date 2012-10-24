uses Math;
var 
  a, b, c, d: int64;
	s : int64;
begin
  Assign(input, 'pobeda.in');
  Assign(output, 'pobeda.out');
  Reset(input);
  Rewrite(output);
  read(a, b, c, d);
  a := Min(a, b) + Min(c, d); 
  s := trunc(sqrt(1.0 * a));
  writeln(s);
end.