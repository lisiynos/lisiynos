{
 Flash Pascal sample
 
 Depth sorting doesn't work ?!

 inspired by http://www.zoneflash.net
(http://www.zoneflash.net/fichiers/zoneflash.swf)

}
program ZoneFlash;

{$FRAME_WIDTH  250}
{$FRAME_HEIGHT 250}
{$FRAME_RATE    25}
{$VERSION        9}

uses
 Flash8;

type
 TCercle=class(MovieClip)
  x,y,z,zz:double;
  index:integer;
  constructor Create(Name:string; Depth:integer);
  procedure tourner;
 end;

 TCadre=class(MovieClip)
  constructor Create(Depth:integer);
  procedure doEnterFrame;
 end;

const
 x0=125;
 y0=125;
 df=130;

 n=3;
 largeur=80;
 dl=largeur/(n-1);
 vitesse = 0.01;

var
 Cadre:TCadre;
 Cercles:array[0..26] of TCercle;
 i,j,k:integer;
 depth:integer;
 mc:TCercle;

 anglex,angley:double;
 danglex,dangley:double;
 cosx,sinx,cosy,siny:double;

function aleatoire(vmin, vmax:double):double;
begin
 Result:=(vmin + (vmax - vmin) * random());
end;

constructor TCadre.Create(Depth:integer);
begin
 inherited Create(nil,'Cadre',Depth);
 onEnterFrame:=doEnterFrame;
 lineStyle(0,$808080);
 beginFill($e0e0e0);
 moveTo(5,5);
 lineTo(240,5);
 lineTo(240,240);
 lineTo(5,240);
 endFill();

 anglex := 0;
 angley := 1.5;
 danglex:=4*aleatoire(0.5 * vitesse, vitesse);
 dangley:=4*aleatoire(0.5 * vitesse, vitesse);
end;

procedure TCadre.doEnterFrame;
var
 i:integer;
begin
 anglex:=anglex+danglex;
 angley:=angley+dangley;

 cosx := cos(anglex);
 sinx := sin(anglex);
 cosy := cos(angley);
 siny := sin(angley);

 for i:=0 to 26 do Cercles[i].tourner;
end;

constructor TCercle.Create(Name:string; Depth:integer);
begin
 inherited Create(Cadre,Name,Depth);
 index:=Depth;
 lineStyle(0, 0);
 beginFill($ffffff);
 moveTo( 0,-17.5);
 curveTo(+16.0,-16.0,+17.5, 0);
 curveTo(+16.0,+16.0, 0,+17.5);
 curveTo(-16.0,+16.0,-17.5, 0);
 curveTo(-16.0,-16.0, 0,-17.5);
 endFill();
 zz:=0;
end;

procedure TCercle.tourner;
var
 tt,xx,yy:double;
 d,sc:double;
begin
 tt:=- x*sinx+ z*cosx;
 xx:=  x*cosx+ z*sinx;
 yy:=  y*cosy+tt*siny;
 zz:=- y*siny+tt*cosy;
 sc:=100*df/(df-zz);
 _xscale:=sc;
 _yscale:=sc;
 _x := x0 + sc * xx / 100;
 _y := y0 + sc * yy / 100;
 swapDepths(zz);
end;


begin
 cadre:=TCadre.Create(100);

 depth:=0;
 for i:=0 to 2 do begin
  for j:=0 to 2 do begin
   for k:=0 to 2 do begin
    mc:=TCercle.Create('c'+IntToStr(depth),depth);
    mc.x:=largeur/2-dl*j;
    mc.y:=largeur/2-dl*i;
    mc.z:=largeur/2-dl*k;
    cercles[depth]:=mc;
    depth:=depth+1;
   end;
  end;
 end;

end.