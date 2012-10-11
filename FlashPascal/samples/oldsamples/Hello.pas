program Hello;

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
{$FRAME_WIDTH  320}
{$FRAME_HEIGHT 200}
{$FRAME_RATE    32}
{$BACKGROUND $7f7fff} // $rrggbb

uses
  Flash8;
  
// Flash Pascal request typed declared variable like any Pascal language
var
 fmt    :TextFormat;
 button1:MovieClip;
 edit1  :TextField;

begin
// this release support only one constructor per class with a fixed number of parameters :(
 fmt:=TextFormat.Create('Tahoma',9);
 fmt.color:=$1f1fff;
 fmt.align:='center';
 fmt.bold:=True;

// this syntaxe build a flash code like "_root.createEmptyMovieClip('button1',0)"
// when the parent class is nil, the compiler use "_root" instead
 button1:=MovieClip.Create(nil,'button1',0);
 button1.beginFill($c0c0c0);
 button1.lineStyle(1,$e0e0e0);
 button1.moveTo(  0, 20);
 button1.lineTo(  0,  0);
 button1.lineTo(120,  0);
 button1.lineStyle(1,$808080);
 button1.lineTo(120, 20);
 button1.lineTo(  0, 20);
 button1._x:=10;
 button1._y:=10;

// when the parent isn't nil/_root, a public variable is created also :
//  button1.createTextField('edit1',0,0,0,120,20)
//  edit1=button1.edit1;

 edit1:=TextField.Create(button1,'edit1',0,0,0,120,20);
 edit1.text:='Hello World !';
 edit1.setTextFormat(fmt);
end.

