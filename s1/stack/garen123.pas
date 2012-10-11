uses sysutils;
Var m:array [1..10000] of integer;
i,j,k,n,s:LongInt;com:string[4];
begin
assign (input, 'stack.in');reset (input);
assign (output, 'stack.out');rewrite (output);
readln (n);
k:=0;
For i:=1 to n do
begin
read (com);
If (com='PUSH') Then begin
k:=k+1;
readln (m[k]);
If k=0 Then
writeln ('[]')
else
begin
Write ('[');
For j:=1 to k do
If j<>k then
Write (m[j],', ')
else
writeln (m[j],']');
end;
end
else begin
s:=m[k];
k:=k-1;
Write (s,' ');
If k=0 Then
writeln ('[]')
else
begin
Write ('[');
For j:=1 to k do
If j<>k then
Write (m[j],', ')
else
writeln (m[j],']');
end;
readln;
end;
end;
end.

