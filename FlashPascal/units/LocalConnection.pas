{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit LocalConnection; // send instructions to another SWF on the same client computer (in diffierent applications too)

interface

type

  // parameter for LocalConnection.onStatus - TEMPLATE ONLY!
  infoObject_LocalConnection_onStatus=external class(Object)
    property code:string;
    property Level:string;
  end;

  TMethod_LocalConnection_allowDomain=function(domain:string):Boolean of object; 
  TMethod_LocalConnection_onStatus=procedure(infoObject:object)of object; // infoObject_LocalConnection_onStatus

  LocalConnection=external class
    constructor Create;
    function connect(connectionName:String):Boolean; // identify this LocalConnection class
    function send(connectionName:String;methodName:String;arg1,arg2,arg3:object):Boolean; // send args to a method of another Flash
    procedure close;
    function domain:String;
    property allowDomain:TMethod_LocalConnection_allowDomain;
    property allowInsecureDomain:TMethod_LocalConnection_allowDomain;
    property onStatus:TMethod_LocalConnection_onStatus;
  end;

implementation

end.
