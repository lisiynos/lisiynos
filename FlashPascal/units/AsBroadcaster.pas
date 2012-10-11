{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit AsBroadcaster; // custom event handling

interface

procedure InitASBroadcaster(broadcaster:object) external AsBroadcaster.initialize; // initialize the broadcaster object

type
  TAsBroadcaster=external class(AsBroadcaster);
    procedure initialize(broadcaster:object);
  end;

  // ASBroadcaster object that will be able to send messages - TEMPLATE ONLY!
  AsBroadcasterObject=external class(object)
    procedure broadcastMessage(eventName:string); // the method (called eventName) of listeners will be triggered
    procedure broadcastMessageB(eventName:string;B:Boolean) as broadcastMessage;// the called method must be defined with the given type of parameter
    procedure broadcastMessageN(eventName:string;I:integer) as broadcastMessage;
    procedure broadcastMessageS(eventName:string;S:string) as broadcastMessage;
    function addListener(listener:object):Boolean;
    function removeListener(listener:object):Boolean;
  end;

var
  AsBroadcaster:TAsBroadcaster;

implementation

end.
