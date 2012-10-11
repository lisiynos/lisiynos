program Calc;

{ Flash Pascal sample (c)2008 by Paul TOTH <tothpaul@free.fr> }

{
This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}


// Frame size and rate
{$FRAME_WIDTH  200}
{$FRAME_HEIGHT 150}
{$FRAME_RATE    32}
{$BACKGROUND $7f7fff} // $rrggbb

// this first release support only "external class"
// basic types are String, Integer and Boolean

// v0.2
//  added for loop
//  added array

uses
 Flash8;

type
// user defined class !
 TMovieClip=class(MovieClip)
  edit :TextField;
  item :integer;
  constructor Create(Depth,Deux:integer);
 // user static method are defined like this
 // function TMovieClip$Create(Depth:integer) {
 //  this=_root.createEmptyMovieClip(undefined,Depth);
 //  this.doRelease=TMovieClip$doRelease;
 // }
 // function TMovieClip$doRelease() {
 // }
  procedure doRelease;
  procedure Add(number:integer);
  procedure SetAction(number:integer);
  procedure DoAction();
 end;

 TDisplay=class(MovieClip)
  edit : TextField;
  fmt  : TextFormat;
  constructor Create(Depth:integer);
  procedure SetValue(number:integer);
  procedure SetAccum(number:integer);
 end;

// Flash Pascal request typed declared variable like any Pascal language
var
 fmt    :TextFormat;
// static arrays are mapped to an Array class
 buttons:array[0..23] of TMovieClip;
 i      :integer;
 display:TDisplay;

 MC     :integer;
 Value  :integer;
 Accum  :integer;
 Action :integer;
 Todo   :integer;

// this build a global function :
// function TMovieClip$Create(Depth) {
//  this=_root.createEmptyMovieClip(undefined,Depth)
//  ...
//  this.edit=this.createTextField(undefined,0,0,0,120,20);
//  ...
//  return this;
// }
constructor TMovieClip.Create(Depth,Deux:integer);
var
 s:string;
begin
 inherited Create(nil,'',Depth+1);
 item:=Depth;
 beginFill($c0c0c0);
 lineStyle(1,$e0e0e0);
 moveTo(  0, 20);
 lineTo(  0,  0);
 lineTo( 25,  0);
 lineStyle(1,$808080);
 lineTo( 25, 20);
 lineTo(  0, 20);
 _x:=10+30*(item mod 6);
 _y:=35+25*(item div 6);
 edit:=TextField.Create(Self,'',0,0,0,25,20);
 s:='c789/Rr456*%s123-xm0?,+=';
 s:=copy(s,item+1,1);
// string case...cause I don't want to deal with CHAR for now :D
// the code look like this
// if (s=="c") { s="MC"; } else if (s=="r")...
 case s of
  'c' : s:='MC';
  'r' : s:='MR';
  's' : s:='MS';
  'm' : s:='M+';
  'R' : s:='Sqrt';
  'x' : s:='1/x';
  '?' : s:='+/-';
 end;

 edit.Text:=s;
 edit.setTextFormat(fmt);
 onRelease:=doRelease;
end;

procedure TMovieClip.doRelease;
begin
 case item of
  0 : MC:=0;
  1 : Add(7);
  2 : Add(8);
  3 : Add(9);
  4 : SetAction(4); // div
  7 : Add(4);
  8 : Add(5);
  9 : Add(6);
 10 : SetAction(3); // *
 13 : Add(1);
 14 : Add(2);
 15 : Add(3);
 19 : Add(0);
 16 : SetAction(2); // -
 22 : SetAction(1); // +
 23 : begin
       DoAction();
      // display.SetValue(Accum);
      end;
 else display.edit.text:=edit.text+' not yet implemented';     
 end;
 edit.setTextFormat(fmt);
end;

procedure TMovieClip.Add(Number:integer);
begin
 //DoAction();
 Todo:=Action;
 display.SetValue(10*Value+Number);
end;

procedure TMovieClip.SetAction(number:integer);
begin
 DoAction();
 Action:=number;
 Value:=0;
end;

procedure TMovieClip.DoAction();
begin
 case Todo of
  0 : display.SetAccum(Value);
  1 : display.SetAccum(Accum+Value);
  2 : display.SetAccum(Accum-Value);
  3 : display.SetAccum(Accum*Value);
  4 : display.SetAccum(Accum div Value);
 end;
 Todo:=0;
end;

constructor TDisplay.Create(Depth:integer);
begin
 inherited Create(nil,'',Depth);
 beginFill($ffffff);
 lineStyle(1,$e0e0e0);
 moveTo(  0, 20);
 lineTo(  0,  0);
 lineTo(175,  0);
 lineStyle(1,$808080);
 lineTo(175, 20);
 lineTo(  0, 20);
 _x:=10;
 _y:=10;
 edit:=TextField.Create(Self,'',0,0,0,175,20);
 edit.Text:='0';
 fmt:=TextFormat.Create('Tahoma',9);
 fmt.align:='right';
 fmt.bold:=true;
 edit.setTextFormat(fmt);
end;

procedure TDisplay.SetValue(number:integer);
begin
 Value:=number;
 edit.text:=IntToStr(Value);
 edit.setTextFormat(fmt);
end;

procedure TDisplay.SetAccum(number:integer);
begin
 Accum:=Number;
 SetValue(Accum);
 Value:=0;
 Action:=0;
end;

begin
 fmt:=TextFormat.Create('Tahoma',9);
 fmt.color:=$1f1fff;
 fmt.align:='center';
 fmt.bold:=True;

 display:=TDisplay.Create(0);
{ todo: array index range checking ... }
 for i:=0 to 23 do begin
  buttons[i]:=TMovieClip.Create(i,50+i);
 end;

 Value:=0;
 Accum:=0;
 Action:=0; // no action
end.

