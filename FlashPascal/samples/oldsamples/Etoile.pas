(*
 Flash Pascal sample based on ...

http://www.zoneflash.net/tutoriaux/t033.php

MovieClip.prototype.tracerUneEtoile = function(r1, r2, n, c1, c2) {
var da = Math.PI/n;
this.lineStyle(0, c1, 100);
this.moveTo(r2, 0);
this.beginFill(c2, 100);
for(var i = 1; i < 2*n + 1; i++) {
var a = da*i;
var r = (i % 2 == 0) ? r2 : r1;
var x = r*Math.cos(a);
var y = r*Math.sin(a);
this.lineTo(x, y);
}
this.endFill();
}

this.createEmptyMovieClip("etoile", 0);
etoile._x = 150;
etoile._y = 150;
etoile.tracerUneEtoile(75, 140, 8, "0x336600", "0x66CC00");

*)
program Etoile;

{$FRAME_WIDTH  300}
{$FRAME_HEIGHT 300}

uses
  Flash8;

type
 TEtoile=class(MovieClip)
  procedure tracerUneEtoile(r1,r2,n,c1,c2:integer);
 end;


procedure TEtoile.tracerUneEtoile(r1,r2,n,c1,c2:integer);
var
 da:double;
  i:integer;
  a:double;
  r:integer;
 x,y:double;
begin
 da:=Math.PI/n;
 lineStyle(0, c1);
 moveTo(r2, 0);
 beginFill(c2);
 for i:=1 to 2*n do begin
  a:=da*i;
  if (i mod 2)=0 then r:=r2 else r:=r1;
  x := r*cos(a);
  y := r*sin(a);
  lineTo(x, y);
 end;
 endFill();
end;

var
 Etoile:TEtoile;
begin
 Etoile:=TEtoile.Create(nil,'',0);
 Etoile._x:=150;
 Etoile._y:=150;
 Etoile.tracerUneEtoile(75,140,8,$336600,$66cc00);
end.

(*
function TEtoile$tracerUneEtoile(r1, r2, n, c1, c2) {
 var da;
 var i;
 var a;
 var r;
 var y;
 var x;
 var da = Math.PI / n;
 this.lineStyle(0, c1, 100);
 this.moveTo(r2, 0);
 this.beginFill(c2, 100);
 for (i = 1; i<=2 * n; i++) {
  var a = da * i;
  if (i % 2 == 0) {
   var r = r2;
  } else {
   var r = r1;
  }
  var x = r * Math.cos(a);
  var y = r * Math.sin(a);
  this.lineTo(x, y);
 } // end of for
 this.endFill();
 return (null);
}

function TEtoile$Create(Parent, Depth) {
 this = (Parent == 0 ? (_root) : (Parent)).createEmptyMovieClip(undefined, Depth);
 this.tracerUneEtoile = TEtoile$tracerUneEtoile;
 return (this);
}

Etoile = TEtoile$Create(0, 0);
Etoile._x = 150;
Etoile._y = 150;
Etoile.tracerUneEtoile(75, 140, 8, 3368448, 6736896);

*)
