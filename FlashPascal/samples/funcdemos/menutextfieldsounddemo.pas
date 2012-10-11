{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

{
Flash Pascal demo containing ContextMenu, Sound and TextField objects on the _root...
Right-click and select "Start the sound" or "Stop the sound" from the menu!
(c) 2011 by Péter Gábor
}

program menutextfieldsounddemo;

{$FRAME_WIDTH  400}
{$FRAME_HEIGHT 400}
{$BACKGROUND $efefff}

uses
  Flash8Ext,Sound;

var
  snd:Sound;
  c:ContextMenu;
  t:TextField;

type
  myContextMenu=class(ContextMenu)
    i,j:ContextMenuItem;
    constructor Create;
    procedure myOnStart(Item:TObject;Menu:ContextMenuItem);
    procedure myOnStop(Item:TObject;Menu:ContextMenuItem);
  end;

constructor myContextMenu.Create;
begin
  inherited Create(nil); // inherited, no callback before the popup
  i:=ContextMenuItem.Create('Start the sound',myOnStart); // a menu entry we are making
  j:=ContextMenuItem.Create('Stop the sound',myOnStop);
  customItems:=[i,j]; // add them to the menu
  hideBuiltInItems; // hide the built in items
end;

procedure myContextMenu.myOnStart(Item:TObject;Menu:ContextMenuItem);
begin
  snd.start(0,4); // start the sound and loop it four times
end;

procedure myContextMenu.myOnStop(Item:TObject;Menu:ContextMenuItem);
begin
  snd.stop; // stop all sounds
end;

begin
  c:=myContextMenu.Create;
  t:=TextField.Create(nil,'t',0,0,0,400,200);
  t.wordWrap:=True;
  t.html:=True; // content is a HTML text
  t.htmlText:='<b>Flash Pascal</b> demo containing <i>ContextMenu</i>, <i>Sound</i> '+
    'and <i>TextField</i> objects on the <i>_root</i>... Right-click and select '+
    '"Start the sound" or "Stop the sound" from the menu!'+#13+
    '(c) 2011 by Péter Gábor';
  _root.menu:=c;
  snd:=Sound.Create(_root);
  snd.loadSound('FlashPascal.mp3',false);
end.
