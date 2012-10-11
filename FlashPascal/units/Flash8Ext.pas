{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit Flash8Ext; // the most important classes of Flash

interface

// ContextMenu - manipulating the context sensitive menu

type

  TMethod_ContextMenu_onSelect=procedure(Item:object;Menu:object)of object; // Item is the object where the callback was indicated, MenuItem is the selected ContextMenu
  TMethod_ContextMenuItem_onSelect=procedure(Item:object;MenuItem:object)of object; // Item is the object where the callback was indicated, MenuMenu is the selected ContextMenuItem

  // setting the built-in context menu items visible or not
  BuiltInContextMenuItems=external class(Object)
    property forward_back:Boolean;
    property loop:Boolean;
    property play:Boolean;
    property print:Boolean;
    property quality:Boolean;
    property rewind:Boolean;
    property zoom:Boolean;
  end;

  // a context menu item
  ContextMenuItem=external class
    property caption:String;
    property enabled:Boolean;
    property separatorBefore:Boolean;
    property visible:Boolean;
    constructor Create(caption:String;callbackFunction:TMethod_ContextMenuItem_onSelect{;separatorBefore:Boolean;enabled:Boolean;visible:Boolean});
    property onSelect:TMethod_ContextMenuItem_onSelect;// onSelect is called when the specified menu item is selected from the context menu
  end;

  // the context menu
  ContextMenu=external class
    property customItems:array of ContextMenuItem; // use like this: customItems:=[customMenuItem1,customMenuItem2,...];
    property builtInItems:BuiltInContextMenuItems;
    constructor Create(callbackFunction:TMethod_ContextMenu_onSelect);
    procedure hideBuiltInItems; // hide built-in context menu items
    property onSelect:TMethod_ContextMenu_onSelect;// onSelect is called before the context menu appears, allows customization of the context menu as needed
  end;

// MovieClip -

const
  // for .blendMode
  bmNorma1='normal'; // 1
  bmLayer='layer'; // 2
  bmMultiply='multiply'; // 3
  bmScreen='screen'; // 4
  bmLighten='lighten'; // 5
  bmDarken='darken'; // 6
  bmDifference='difference'; // 7
  bmAdd='add'; // 8
  bmSubtract='subtract'; // 9
  bmInvert='invert'; // 10
  bmAlpha='alpha'; // 11
  bmErase='erase'; // 12
  bmOverlay='overlay'; // 13
  bmHardLight='hardlight'; // 14

type

  TMethod=procedure of object;
  TMethod_MovieClip_onFocus=procedure(Focus:object)of object;

  TBounds=external class(Object)
    property xMin:Integer;
    property xMax:Integer;
    property yMin:Integer;
    property yMax:Integer;
  end;

  TPoint=external class(Object)
    property x:Integer;
    property y:Integer;
  end;

  MovieClip=external class
    property _alpha:Integer;
    //property _currentframe:Integer;
    property _droptarget:String;
    property _focusrect:Boolean;
    //property _framesloaded:Integer;
    property _height:Integer;
    property _highquality:Integer;
    property _lockroot:Boolean;
    property _name:String;
    property _parent:MovieClip;
    property _quality:String;
    property _rotation:Integer;
    property _soundbuftime:Integer;
    property _target:String;
    //property _totalframes:Integer;
    property _url:String;
    property _visible:Boolean;
    property _width:Integer;
    property _x:Integer;
    property _xmouse:Integer;
    property _xscale:Double;
    property _y:Integer;
    property _ymouse:Integer;
    property _yscale:Double;
    property blendMode:string;
    property cacheAsBitmap:Boolean;
    property enabled:Boolean;
    property focusEnabled:Boolean;
    property hitArea:MovieClip;
    property menu:ContextMenu;
    property tabChildren:Boolean;
    property tabEnabled:Boolean;
    property tabIndex:Integer;
    property trackAsMenu:Boolean;
    property useHandCursor:Boolean;
  // methods
    constructor Create(Parent:MovieClip; Name:string; Depth:integer) as Parent.createEmptyMovieClip;
    function attachMovie(id:object;name:String;depth:Integer{;initTObject:object}):MovieClip;
    procedure attachAudio(id:object); // Microphone, NetStream (FLV), nil
    //procedure attachBitmap(bmp:BitmapData;depth:Integer;pixelSnapping:String;smoothing:Boolean); // ?
    procedure attachVideo(id:object); // Camera, NetStream (FLV), nil
    function createEmptyMovieClip(name:String;depth:Integer):MovieClip;
    function duplicateMovieClip(name:String;depth:Integer;initTObject:object):MovieClip;
    function getBounds(bounds:object):TBounds;
    function getBytesLoaded:Integer;
    function getBytesTotal:Integer;
    function getDepth:Integer;
    function getInstanceAtDepth(depth:Integer):MovieClip;
    function getNextHighestDepth:Integer;
    function getSWFVersion:Integer;
    //function getTextSnapshot:TextSnapshot; // see TextSnapShot.Create
    procedure globalToLocal(point:TPoint);
    function hitTestXY(x,y,shapeFlag:Integer):Boolean as hitTest;
    function hitTestTarget(target:object):Boolean as hitTest;
    procedure localToGlobal(point:TPoint);
    procedure swapDepths(target:double);
    procedure swapObjDepths(target:object) as SwapDepths;
    procedure beginFill(rgb:Integer);
    procedure beginFillA(rgb:Integer;alpha:Integer) as beginFill;
    procedure beginGradientFill(fillType:String;colors:array of Integer;alphas:array of Integer;ratios:array of Integer;matrix:object);
    procedure clear;
    //procedure createTextField(instanceName:String;depth:Integer;x:Integer;y:Integer;width:Integer;height:Integer); // see TextField.Create
    procedure curveTo(controlX:Double;controlY:Double;anchorX:Double;anchorY:Double);
    procedure endFill;
    procedure getURL(url:String;window:String);
    procedure getURLM(url:String;window:String;method:String) as getURL;
    //procedure callScript(url:String) as getURL; // to call JS or VB scripts: 'javascript:yourScriptFunctionInTheHtml(someParameters);'
    procedure lineStyle(thickness:Integer;rgb:Integer);
    procedure lineStyleA(thickness:Integer;rgb:Integer;alpha:Integer) as lineStyle;
    procedure lineTo(x:Double;y:Double);
    procedure loadMovie(url:String);
    procedure loadMovieM(url:String;method:String) as loadMovie;
    procedure loadVariables(url:String);
    procedure loadVariablesM(url:String;method:String) as loadVariables;
    procedure moveTo(x:Double;y:Double);
    procedure removeMovieClip;
    procedure setMask(mask:MovieClip);
    procedure startDrag(lockCenter:Boolean;left:Integer;top:Integer;right:Integer;bottom:Integer);
    procedure stopDrag;
    procedure unloadMovie;
  // callbacks
    property onData:TMethod;
    property onDragOut:TMethod;
    property onDragOver:TMethod;
    property onEnterFrame:TMethod;
    property onKeyDown:TMethod;
    property onKeyUp:TMethod;
    property onKillFocus:TMethod_MovieClip_onFocus;
    property onLoad:TMethod;
    property onMouseDown:TMethod;
    property onMouseMove:TMethod;
    property onMouseUp:TMethod;
    property onPress:TMethod;
    property onRelease:TMethod;
    property onReleaseOutside:TMethod;
    property onRollOut:TMethod;
    property onRollOver:TMethod;
    property onSetFocus:TMethod_MovieClip_onFocus;
    property onUnload:TMethod;
  end;

// MovieClipLoader - load files and check status of them

type

  MovieClipLoaderProgress=external class(Object)
    property bytesLoaded:Integer;
    property bytesTotal:Integer;
  end;

  MovieClipLoader=external class
    constructor Create;
    function getProgress(target:MovieClip):MovieClipLoaderProgress;
    function loadClip(url:String;target:MovieClip):Boolean;
    function unloadClip(target:MovieClip):Boolean;
    function addListener(listener:object):Boolean;
    function removeListener(listener:object):Boolean;
  end;

  // a MovieClipLoader listener class must have these methods - TEMPLATE ONLY! DON'T INHERIT!
  MovieClipLoaderListener=external class(object)
    constructor Create;
    procedure onLoadInit(target:MovieClip);
    procedure onLoadStart(target:MovieClip);
    procedure onLoadProgress(target:MovieClip;loadedBytes:Integer;totalBytes:Integer);
    procedure onLoadError(target:MovieClip;errorCode:String;httpStatus:Integer);
    procedure onLoadComplete(target:MovieClip;httpStatus:Integer);
  end;

// TextSnapshot - access (read-only) static text on a MovieClip

type

  TextSnapshot=external class
    constructor Create(Parent:MovieClip) as Parent.getTextSnapshot;
    function findText(startIndex:Integer;textToFind:String;caseSensitive:Boolean):Integer;
    function getCount:Integer;
    function getSelected(start:Integer;stop:Integer):Boolean;
    function getSelectedText(includeLineEndings:Boolean):String;
    function getText(start:Integer;stop:Integer;includeLineEndings:Boolean):String;
    function hitTestTextNearPos(x:Integer;y:Integer;closeDist:Integer):Integer;
    procedure setSelectColor(color:Integer);
    procedure setSelected(start:Integer;stop:Integer;select:Boolean);
  end;

// TextFormat, TextExtent - text formatting for static and dynamic text

type

  TextExtent=external class(Object)
    property width:Integer;
    property height:Integer;
    property ascent:Integer;
    property descent:Integer;
    property textFieldHeight:Integer;
    property textFieldWidth:Integer;
  end;

  TextFormat=external class
    property font:String;
    property size:Integer;
    property color:Integer;
    property url:String;
    property target:String;
    property bold:Boolean;
    property italic:Boolean;
    property underline:Boolean;
    property align:String;
    property leftMargin:Integer;
    property rightMargin:Integer;
    property indent:Integer;
    property leading:Integer;
    property blockIndent:Integer;
    property tabStops:array of Integer;
    property bullet:Boolean;
    constructor Create(font:String;size:Integer{;textColor:Integer;bold:Boolean;italic:Boolean;underline:Boolean});
    function getTextExtent(text:String):TextExtent;
  end;

// StyleSheet - style sheet (CSS) for TextField objects with HTML/XML content

type

  TMethod_styleSheet_onLoad=procedure(success:Boolean) of object;

  TStyle=external class(Object)
    property color:string; // hexadecimal: #FF0000.
    property display:string; // inline, block, none
    property fontFamily:string;// any font family name
    property fontSize:string; // pixels
    property fontStyle:string; // normal, italic
    property fontWeight:string; // normal, bold
    property kerning:string; // true or false
    property letterSpacing:string; // pixels
    property marginLeft:string; // pixels
    property marginRight:string; // pixels
    property textAlign:string; // left, center, right, justify
    property textDecoration:string; // none, underline
    property textIndent:string; // pixels
  end;

  TStyleSheet=external class(TextField.StyleSheet) // ?! ?! ?!
    constructor Create;
    function getStyle(name:String):TStyle;
    function getStyleNames:array of String;
    function load(url:String):Boolean;
    function parse(cssText:String):Boolean;
    function parseCSS(cssText:String):Boolean;
    function transform(style:TStyle):TextFormat; // style:TStyle can be nil
    procedure clear;
    procedure setStyle(name:String;style:TStyle);
  // callbacks
    property onLoad:TMethod_styleSheet_onLoad;
  end;

// TextField - input and display texts (normal/HTML/XML) with formatting and styles

const
  //valid values for TextFiled.type_
  tfInput='input'; // input field
  tfDynamic='dynamic'; // dynamic content eg. from a variable

type

  TMethod_TextField_onChange=procedure(changedField:object)of object; // changedField:TextField
  TMethod_TextField_onFocus=procedure(Focus:object)of object;

  TextField=external class
    property _alpha:Integer;
    property _focusrect:Boolean;
    property _height:Integer;
    property _highquality:Integer;
    property _name:String;
    property _parent:MovieClip;
    property _quality:String;
    property _rotation:Integer;
    property _soundbuftime:Integer;
    property _url:String;
    property _visible:Boolean;
    property _width:Integer;
    property _x:Integer;
    property _xmouse:Integer;
    property _xscale:Integer;
    property _y:Integer;
    property _ymouse:Integer;
    property _yscale:Integer;
    property autoSize:object;
    property background:Boolean;
    property backgroundColor:Integer;
    property border:Boolean;
    property borderColor:Integer;
    property bottomScroll:Integer;
    property condenseWhite:Boolean;
    property embedFonts:Boolean;
    property hscroll:Integer;
    property html:Boolean; // content is a html text
    property htmlText:String; // the html content with tags
    property length_:Integer as length; // alias for length
    property len:Integer as length; // second alias for length
    property maxChars:Integer;
    property maxhscroll:Integer;
    property maxscroll:Integer;
    property mouseWheelEnabled:Boolean;
    property multiline:Boolean;
    property password:Boolean;
    property restrict:String;
    property scroll:Integer;
    property selectable:Boolean;
    property styleSheet:TStyleSheet; // TextField.StyleSheet
    property tabEnabled:Boolean;
    property tabIndex:Integer;
    property text:String; // content without html tags
    property textColor:Integer;
    property textHeight:Integer;
    property textWidth:Integer;
    property type_:String as type; // alias for type, valid values are 'dynamic' or 'input'
    property typ:String as type;   // second alias for type
    property variable:String; // the text is taken/updated from/to this named variable
    property wordWrap:Boolean;
  // methods
    constructor Create(Parent:MovieClip; Name:string; depth,left,top,width,height:integer) as Parent.createTextField;
    function addListener(listener:object):Boolean;
    function getDepth:Integer;
    function getFontList:array of String;
    function getNewTextFormat:TextFormat;
    function getTextFormat(beginIndex:Integer;endIndex:Integer):TextFormat;
    function removeListener(listener:object):Boolean;
    procedure removeTextField;
    procedure replaceSel(newText:String);
    procedure replaceText(beginIndex:Integer;endIndex:Integer;newText:String);
    procedure setNewTextFormat(format:TextFormat);
    procedure setTextFormat(format:TextFormat);
  // callbacks
    property onChanged:TMethod_TextField_onChange;
    property onKillFocus:TMethod_TextField_onFocus;
    property onScroller:TMethod_TextField_onChange;
    property onSetFocus:TMethod_TextField_onFocus;
  end;

  // a TextField listener class must have these methods - TEMPLATE ONLY!
  TextFieldListener=external class(object)
    procedure onChanged(changedField:TextField);
    procedure onScroller(scrolledField:TextField);
  end;

// Selection - handling text selection in the active TextField (zero based strings)

function getSelectionBeginIndex:Integer external Selection.getBeginIndex;
function getSelectionCaretIndex:Integer external Selection.getCaretIndex;
function getSelectionEndIndex:Integer external Selection.getEndIndex;
function getSelectionFocus:String external Selection.getFocus;
function removeSelectionListener(listener:object):Boolean external Selection.removeListener;
function setSelectionFocus(newFocus:object):Boolean external Selection.setFocus;
procedure addSelectionListener(listener:object) external Selection.addListener;
procedure setSelectionIndexes(beginIndex:Integer;endIndex:Integer) external Selection.setSelection;

type

  TSelection=external class(Selection)
    procedure addListener(listener:object);
    function getBeginIndex:Integer;
    function getCaretIndex:Integer;
    function getEndIndex:Integer;
    function getFocus:String;
    function removeListener(listener:object):Boolean;
    function setFocus(newFocus:object):Boolean;
    procedure setSelection(beginIndex:Integer;endIndex:Integer);
  end;

  // a selection listener class must have these methods - TEMPLATE ONLY!
  SelectionListener=external class(object)
    procedure onSetFocus(oldFocus:object;newFocus:object);
  end;

var
  Selection:TSelection;

// base variable(s)

var
  _root:MovieClip;

implementation

end.
