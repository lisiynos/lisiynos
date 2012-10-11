{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit State; // Stage - access and manipulate the boundaries of the SWF file

interface

procedure addStageListener(listener:object) external Stage.addListener; // :S
function removeStageListener(listener:object):Boolean external Stage.removeListener; // :S

type

  TStage=external class(Stage)
    property align:String; // "T", "B", "L", "R", "TL", "TR", "BL", "BR" -> Top Bottom Left Right
    property height:Integer;
    property scaleMode:String; // "exactFit", "showAll", "noBorder", "noScale", nothing else
    property showMenu:Boolean; // show or hide the default items in the context menu
    property width:Integer;
  // methods
    procedure addListener(listener:object);
    function removeListener(listener:object):Boolean;
  end;

  // a stage listener class must have these methods - TEMPLATE ONLY!
  StageListener=external class(object)
    procedure onResize; // called when TStage.scaleMode changes to noScale
  end;

var
  Stage:TStage;

implementation

end.
