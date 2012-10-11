program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  N : integer;
  A : array [1..10000] of int64;
  size: Integer;

procedure Swap( i,j : integer );
var T : int64;
begin
  T := A[i];
  A[i] := A[j];
  A[j] := T;
end;

procedure Heapify( i:integer );
var r,l : integer;
begin
  l := i*2;
  r := i*2+1;
  if l <= N then
    if A[l] > A[i] then begin
      Swap(l,i);
      Heapify(l);
    end;
  if r <= N then
    if A[r] > A[i] then begin
      Swap(r,i);
      Heapify(r);
    end;
end;

procedure BuildHeap;
var
  i: Integer;
begin
  for i := N downto 1 do
    Heapify(i);
end;

procedure HeapSort;
begin
  BuildHeap;
  size := n;
  for n := size downto 1 do begin
    Swap(n,1);
    Heapify(1);
  end;
end;

var i : Integer;
begin
  try
    Reset(Input,'heapsort.in');
    Rewrite(Output,'heapsort.out');
    { Чтение исходных данных }
    Read(N);
    for i := 1 to N do
      Read(A[i]);
    { Вызов сортировки }
    HeapSort;
    { Запись отсортированного массива }
    for i := 1 to size do
      Write(A[i],' ');

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
