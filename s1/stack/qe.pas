uses sysUntils;
var a:array[1..2000] of longint;
i,j,k,h,n,s:longint; com:string;
begin
        assign(input, 'queue.in'); reset(input);
        assign(output, 'queue.out'); rewrite(output);
        readln(n); s:=1;
        for i:=1 to n do
         begin
                read(com);
                if (com='PUT') then
                 begin
                        readln(a[i]);
                        write('[');
                        s:=i;
                        for j:=s to (i-1) do
                        write(a[j],', ');
                        write('[');
                        writeln(a[i]);
                        readln;
                 end
                else
                 begin
                        s:=s+1;
                        For k:=1 to (s-1)
                        write(a[k],' ');
                        write('[');
                        for h:=s to (i-1) do
                        write(a[h],', ');
                        write(a[i]);
                        write(']');
                 end;
         end;
end.
