(*

 Flash Pascal sample based on :

 http://www.zoneflash.net/tutoriaux/t035.php

nbr = 10;
cote = 6;
cx = 150;
cy = 150;
rayon = 100;
xmax = 275;
xmin = 25;
ymin = 25;
ymax = 275;

this.createEmptyMovieClip("zone", 0);
zone.lineStyle(0, 0, 100);
zone.beginFill("0x999999", 15);
zone.moveTo(xmin, ymin);
zone.lineTo(xmax, ymin);
zone.lineTo(xmax, ymax);
zone.lineTo(xmin, ymax);
zone.lineTo(xmin, ymin);
zone.endFill();

this.createEmptyMovieClip("polygone", 1);

for (var i = 0; i<nbr; i++) {
var sommet = this.createEmptyMovieClip("sommet"+i, i+2);
var angle = i*2*Math.PI/nbr;

with (sommet) {
beginFill(0, 100);
moveTo(-0.5*cote, -0.5*cote);
lineTo(-0.5*cote, 0.5*cote);
lineTo(0.5*cote, 0.5*cote);
lineTo(0.5*cote, -0.5*cote);
lineTo(-0.5*cote, -0.5*cote);
endFill();
_x = cx+rayon*Math.cos(angle);
_y = cy+rayon*Math.sin(angle);
}

sommet.onPress = function() {
this.startDrag(false, xmin, ymin, xmax, ymax);
this._parent.onEnterFrame = tracerLePolygone;
};

sommet.onRelease = sommet.onReleaseOutside=function () {
this.stopDrag();
delete this._parent.onEnterFrame;
tracerLePolygone();
};

}
 
tracerLePolygone = function () {
polygone.clear();
polygone.lineStyle(0, "0x999999", 100);
polygone.moveTo(sommet0._x, sommet0._y);
 
for (var i = 1; i<nbr; i++) {
polygone.lineTo(this["sommet"+i]._x, this["sommet"+i]._y);
}
 
polygone.lineTo(sommet0._x, sommet0._y);
};
 
tracerLePolygone();

*)

program DragPoly;

{$FRAME_WIDTH  300}
{$FRAME_HEIGHT 300}
{-$FRAME_RATE    32}

uses
 Flash8;

const
 nbr=10;  // todo: make sure that const are...constant :D
 cote=6;
 cx=150;
 cy=150;
 rayon=100;
 xmin=25;
 ymin=25;
 xmax=275;
 ymax=275;
 PI=3.14159265;

type
 TSommet=class(MovieClip)
  constructor Create(Index:integer);
  procedure doPress;
  procedure doRelease;
  procedure tracerLePolygone;
 end;

constructor TSommet.Create(Index:integer);
var
 angle:double;
begin
 inherited Create(nil,'',Index+2);
 angle:=Index*2*PI/nbr;
 beginFill(0);
 moveTo(-0.5*cote, -0.5*cote);
 lineTo(-0.5*cote,  0.5*cote);
 lineTo( 0.5*cote,  0.5*cote);
 lineTo( 0.5*cote, -0.5*cote);
 lineTo(-0.5*cote, -0.5*cote);
 endFill();
 _x := cx+rayon*cos(angle);
 _y := cy+rayon*sin(angle);
 onPress:=doPress;
 onRelease:=doRelease;
 onReleaseOutside:=doRelease;
end;

procedure TSommet.doPress;
begin
 startDrag(False, xmin, ymin, xmax, ymax);
 _parent.onEnterFrame := tracerLePolygone; // todo: strange assignment !!!
end;

procedure TSommet.doRelease;
begin
 stopDrag();
 //delete _parent.onEnterFrame;
 _parent.onEnterFrame:=nil;
 tracerLePolygone();
end;

var
 zone:MovieClip;
 polygone:MovieClip;
 i:integer;
 sommet:array[0..9] of TSommet;
 angle:double;
 
procedure TSommet.tracerLePolygone;   // todo: what is "this" when onEnterFrame fire this event ?
begin
 polygone.clear();
 polygone.lineStyle(1, $999999);
 polygone.moveTo(sommet[0]._x, sommet[0]._y);
 for i := 1 to nbr-1 do begin
  polygone.lineTo(sommet[i]._x, sommet[i]._y);
 end;
 polygone.lineTo(sommet[0]._x, sommet[0]._y);
end;

begin
 zone:=MovieClip.Create(nil,'',0);
 zone.lineStyle(0,0);
 zone.beginFill($DDDDDD);
 zone.moveTo(xmin, ymin);
 zone.lineTo(xmax, ymin);
 zone.lineTo(xmax, ymax);
 zone.lineTo(xmin, ymax);
 zone.lineTo(xmin, ymin);
 zone.endFill();

 polygone:=MovieClip.Create(nil,'',1);

 for i := 0 to nbr-1 do begin
  sommet[i]:=TSommet.Create(i+2);
 end;
 sommet[0].tracerLePolygone;

end.