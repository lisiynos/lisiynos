program Test;

uses
  Flash8Ext;

type
  MyClass = class(MovieClip)
    constructor Create;
  end;

constructor MyClass.Create;
begin
  inherited Create(nil, '', 0);
  beginFill($ff0000);
  moveTo(10,10);
  lineTo(40,5);
  lineTo(50,25);
  lineTo(5,20);
  moveTo(100,100);
  lineTo(140,100);
  lineTo(140,140);
  lineTo(100,140);
end;

begin
  MyClass.Create;
end.
