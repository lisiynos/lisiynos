program FlashMine;

{ Flash Pascal Mines game (c) 2008 by Paul TOTH <tothpaul@free.fr> }

{$FRAME_WIDTH  240}
{$FRAME_HEIGHT 270}

uses
 Flash8;

type
 TCell=class(MovieClip)
  State:integer;
  Text :TextField;
  Count:integer;
  cx,cy:integer;
  constructor Create(Name:string; x,y:integer);
  procedure doRelease;
  procedure Circle(radius:integer);
  procedure Reset;
  procedure DoFlag;
  procedure IsUp(NewState:integer);
  procedure IsDown(color:integer);
  procedure IsBomb(color:integer);
  procedure IsFlag(NewState:integer);
  procedure IsWrong;
 end;

 TLink=class(MovieClip)
  constructor Create;
  procedure doRelease;
 end;

 TMatrix=class
  matrixType:string;
  x,y,w,h:double;
  r:double;
  constructor Create;
 end;

var
 Cells  :array[0..15,0..15] of TCell;
 Mines  :integer;
 Flags  :integer;
 x,y,i  :integer;
 link   :TLink;
 format :TextFormat;
 Matrix :TMatrix;
 Restart:boolean;
 Bombs  :TextField;

procedure CheckEmpty(x,y:integer);
begin
 if (x>=0)and(y>=0)and(x<16)and(y<16) then begin
  if (Cells[x,y].State=0) then
   Cells[x,y].doRelease;
 end;
end;

function GetState(x,y:integer):integer;
begin
 if (x<0)or(y<0)or(x>15)or(y>15) then Result:=0 else Result:=Cells[x,y].State;
end;

procedure NewGame;
var
 x,y,i:integer;
begin
 for x:=0 to 15 do
  for y:=0 to 15 do
   Cells[x,y].Reset;
 i:=40;
 Bombs.text:=IntToStr(i);
 format.color:=$00ff00;
 Bombs.setTextFormat(format);
 Mines:=16*16;
 Flags:=0;
 while i>0 do begin
  x:=floor(random()*16);
  y:=floor(random()*16);
  if Cells[x,y].State=0 then begin
   Cells[x,y].State:=1;
   i:=i-1;
  end;
 end;
 for x:=0 to 15 do
  for y:=0 to 15 do begin
   Cells[x,y].Count:=GetState(x-1,y-1)
                    +GetState(x-1,y  )
                    +GetState(x-1,y+1)
                    +GetState(x  ,y-1)
                  //+GetState(x  ,y  )
                    +GetState(x  ,y+1)
                    +GetState(x+1,y-1)
                    +GetState(x+1,y  )
                    +GetState(x+1,y+1);
  end;
 Restart:=False;
end;

constructor TLink.Create;
var
 t:TextField;
begin
 inherited Create(nil,'title',-1);
 beginFill($000080);
 moveTo(0,0);
 lineTo(240,0);
 lineTo(240,15);
 lineTo(0,15);
 endFill;
 t:=TextField.Create(Self,'title_caption',0,0,0,240,15);
 t.text:='MineSweeper (c)2008 by Paul TOTH';
 format.color:=$ffffff;
 t.setTextFormat(format);
 onRelease:=doRelease;
end;

procedure TLink.doRelease;
begin
 getURL('http://sourceforge.net/projects/flashpascal','_blank');
end;

constructor TCell.Create(Name:string; x,y:integer);
begin
 inherited Create(nil,Name,x+16*y);
 cx:=x;
 cy:=y;
 _x:=x*15+7;
 _y:=y*15+7+30;
 onRelease:=doRelease;
end;

procedure TCell.doRelease;
var
 x,y:integer;
begin
 if Restart then begin
  NewGame;
 end else begin
  if KeyDown(SHIFT) then begin
   DoFlag;
  end else begin
   if State=0 then begin
    Mines:=Mines-1;
    IsDown($a0a0a0);
    if Count>0 then begin
     Text:=TextField.Create(Self,IntToStr(cx)+'_'+IntToStr(cy),0,-7,-7,15,15);
     Text.text:=IntToStr(Count);
     case Count of
      1 : format.color:=$0000ff;
      2 : format.color:=$008000;
      3 : format.color:=$ff00ff;
      4 : format.color:=$000080;
      5 : format.color:=$800000;
      6 : format.color:=$008080;
      7 : format.color:=$ff00ff;
      8 : format.color:=$808000;
     end;
     Text.setTextFormat(format);
    end else begin
     for x:=-1 to +1 do
      for y:=-1 to +1 do
       CheckEmpty(x+cx,y+cy);
    end;
   end;
   if State=1 then begin
    Restart:=True;
    IsBomb($ff0000);
    for x:=0 to 15 do
     for y:=0 to 15 do
      case Cells[x,y].State of
       1: Cells[x,y].IsBomb($a0a0a0);
       2: Cells[x,y].IsWrong;
      end;
   end;
  end;
 end;
 if (Flags=40)and(Mines=40) then begin
  Bombs.text:='You WIN !';
  format.color:=$00ff00;
  Bombs.setTextFormat(format);
  Restart:=True;
 end;
end;

procedure TCell.Circle(Radius:integer);
var
 a:double;
 c1,s1:double;
 c2,s2:double;
 r2:double;
begin
 a:=3.14/4;
 c1:=cos(a);
 s1:=sin(a);
 a:=3.14/8;
 c2:=cos(a);
 s2:=sin(a);
 r2:=11*Radius/10;
 moveTo(0,Radius);
 curveTo( r2*s2, r2*c2, Radius*s1, Radius*c1);
 curveTo( r2*c2, r2*s2, Radius,0);
 curveTo( r2*c2,-r2*s2, Radius*s1,-Radius*c1);
 curveTo( r2*s2,-r2*c2, 0,-Radius);
 curveTo(-r2*s2,-r2*c2,-Radius*c1,-Radius*s1);
 curveTo(-r2*c2,-r2*s2, -Radius,0);
 curveTo(-r2*c2, r2*s2,-Radius*c1, Radius*s1);
 curveTo(-r2*s2, r2*c2, 0,Radius);
end;

procedure TCell.Reset;
begin
 if (State<0)and(Count>0) then Text.removeTextField();
 IsUp(0);
end;

procedure TCell.DoFlag;
begin
 if (State>=0)and(Flags<40) then begin
  case State of
   0: IsFlag(2);
   1: IsFlag(3);
   2: IsUp(0);
   3: IsUp(1);
  end;
  Flags:=Flags-1;
  Bombs.text:=IntToStr(40-Flags);
  format.color:=$00ff00;
  Bombs.setTextFormat(format);
 end;
end;

procedure TCell.IsUp(NewState:integer);
begin
 State:=NewState;
 clear;
 beginFill($c0c0c0);
 lineStyle(1,$ffffff);
 moveTo(-7, 7);
 lineTo(-7,-7);
 lineTo( 7,-7);
 lineStyle(1,$808080);
 lineTo( 7, 7);
 lineTo(-7, 7);
 endFill;
end;

procedure TCell.IsDown(color:integer);
begin
 State:=-1;
 clear;
 beginFill(color);
 lineStyle(1,$808080);
 moveTo(-7, 7);
 lineTo(-7,-7);
 lineTo( 7,-7);
 lineStyle(1,$c0c0c0);
 lineTo( 7, 7);
 lineTo(-7, 7);
 endFill;
end;

procedure TCell.IsBomb(color:integer);
begin
 IsDown(color);
 lineStyle(0,0);
 beginGradientFill('radial',[$ffffff,0],[100,100],[0,255],Matrix);
 circle(5);
 endFill;

 lineStyle(2,0);
 moveTo(0, 5); lineTo(0, 6);
 moveTo(0,-5); lineTo(0,-6);
 moveTo( 5,0); lineTo( 6,0);
 moveTo(-5,0); lineTo(-6,0);

 lineStyle(1,0);
 moveTo( 3.5, 3.5); lineTo( 4.5, 4.5);
 moveTo( 3.5,-3.5); lineTo( 4.5,-4.5);
 moveTo(-3.5,-3.5); lineTo(-4.5,-4.5);
 moveTo(-3.5, 3.5); lineTo(-4.5, 4.5);
end;

procedure TCell.IsFlag(NewState:integer);
begin
 if NewState=2 then Mines:=Mines-1;
 Flags:=Flags+2;
 State:=NewState;
 lineStyle(1,0);
 beginFill(0);
 moveTo(0,3);
 lineTo(-5,+5);
 lineTo(+5,+5);
 lineTo(0,3);
 lineTo(0,-2);
 endFill;
 lineStyle(1,$ff0000);
 beginFill($ff0000);
 moveTo(0,-1);
 lineTo(0,-5);
 lineTo(-5,-3);
 lineTo(0,-1);
 endFill;
end;

procedure TCell.IsWrong;
begin
 IsDown($a0a0a0);
 lineStyle(2,$ff0000);
 moveTo(-5,-5);
 lineTo(+5,+5);
 moveTo(-5,+5);
 lineTo(+5,-5);
end;

constructor TMatrix.Create;
begin
 matrixType:='box';
 x:=-4.5;
 y:=-4.5;
 w:=6;
 h:=6;
 r:=0;
end;

function AddCaption(name,text:string; depth,left,top,width,height,color,background:integer):TextField;
begin
 Result:=TextField.Create(nil,name,depth,left,top,width,height);
 Result.backgroundcolor:=background;
 Result.background:=true;
 Result.Text:=text;
 format.color:=color;
 Result.setTextFormat(format);
end;

begin
 format:=TextFormat.Create('Tahoma',9);
 format.bold:=true;
 format.align:='center';
 link:=TLink.Create;
 Bombs:=AddCaption('bombs','40',-2,0,16,120,15,$00ff00,0);
 AddCaption('help','Shift+Click for Flags',-3,120,16,120,15,0,$e0e0f0);

 Matrix:=TMatrix.Create;
 for x:=0 to 15 do
  for y:=0 to 15 do
   Cells[x,y]:=TCell.Create('cell_'+IntToStr(x)+'_'+IntToStr(y),x,y);
 NewGame;
end.
