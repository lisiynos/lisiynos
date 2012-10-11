program Bomb;

uses Flash8Ext,Math;

type
  TBomb = class(MovieClip)
    constructor Create;
    procedure IsDown(color:integer);
    procedure Circle(radius:integer);
  end;

  TMatrix = class
    constructor Create;
  end;

constructor TMatrix.Create;
begin
end;

var
 Matrix :TMatrix;

constructor TBomb.Create;
begin
 inherited Create(nil, 'bomb', 0);
 _x := 128;
 _y := 128;

 _xscale := 1000;
 _yscale := 1000;

 IsDown($00ff00);
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

 lineStyle(5, 0);
 moveTo(0, 0);
 lineTo(8, 8);
 moveTo(0, 0);
 curveTo(-8, -8, -3, -9);
end;

procedure TBomb.IsDown(color:integer);
begin
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

procedure TBomb.Circle(radius: integer);
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

begin
  TBomb.Create;
 {$FRAME_WIDTH 255}
 {$FRAME_HEIGHT 255}
end.
