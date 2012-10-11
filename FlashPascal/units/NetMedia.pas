{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit NetMedia; //

interface

type

// Camera - capture video from the video camera

  // parameter for Camera.onStatus - TEMPLATE ONLY!
  infoObject_Camera_onStatus=external class(Object)
    property code:string;
    property Level:string;
  end;

  TMethod_Camera_onActivity=procedure(active:Boolean)of object;
  TMethod_Camera_onStatus=procedure(infoObject:object)of object; // infoObject_Camera_onStatus

  Camera=external class
    property activityLevel:Integer;
    property bandwidth:Integer;
    property currentFps:Integer;
    property fps:Integer;
    property height:Integer;
    property index:Integer;
    property keyFrameInterval:Integer;
    property loopback:Boolean;
    property motionLevel:Integer;
    property motionTimeOut:Integer;
    property muted:Boolean;
    property name:String;
    property names:array of String;
    property quality:Integer;
    property width:Integer;
  // methods
    constructor Create(index:Integer){ as Camera.get};
    //constructor get(index:Integer):Camera; // 'get' is the constructor in actionscript :S
    procedure setKeyFrameInterval(keyFrameInterval:Integer);
    procedure setLoopback(compress:Boolean);
    procedure setMode(width:Integer;height:Integer;fps:Integer;favorArea:Boolean);
    procedure setMotionLevel(motionLevel:Integer;timeOut:Integer);
    procedure setQuality(bandwidth:Integer;quality:Integer);
  // callbacks
    property onActivity:TMethod_Camera_onActivity;
    property onStatus:TMethod_Camera_onStatus;
  end;

type

// Microphone - capture audio from the microphone

  // parameter for Microphone.onStatus - TEMPLATE ONLY!
  infoObject_Microphone_onStatus=external class(Object)
    property code:string;
    property Level:string;
  end;

  TMethod_Microphone_onActivity=procedure(active:Boolean)of object;
  TMethod_Microphone_onStatus=procedure(infoObject:object)of object; // infoObject_Microphone_onStatus

  Microphone=external class
    property activityLevel:Integer;
    property gain:Integer;
    property index:Integer;
    property muted:Boolean;
    property name:String;
    property names:array of String;
    property rate:Integer;
    property silenceLevel:Integer;
    property silenceTimeOut:Integer;
    property useEchoSuppression:Boolean;
  // methods
    constructor Create(index:Integer) {as Microphone.get};
    //constructor get(index:Integer):Microphone; // 'get' is the constructor in actionscript :S
    procedure setGain(gain:Integer);
    procedure setRate(rate:Integer);
    procedure setSilenceLevel(silenceLevel:Integer;timeOut:Integer);
    procedure setUseEchoSuppression(useEchoSuppression:Boolean);
  // callbacks
    property onActivity:TMethod_Microphone_onActivity;
    property onStatus:TMethod_Microphone_onStatus;
  end;

// NetConnection - open network connection

type

  // parameter for NetConnection.onStatus - TEMPLATE ONLY!
  infoObject_NetConnection_onStatus=external class(Object)
    property code:string;
    property Level:string;
  end;

  TMethod_NetConnection_onStatus=procedure(infoObject:object)of object; // infoObject_NetConnection_onStatus

  NetConnection=external class
    property isConnected:Boolean;
    property uri:String;
  // methods
    constructor Create;
    function connect(targetURI:string):Boolean; // rtmp://host:port/appname/instanceName (default port is 1935) or rtmpt://host:port/appname/instanceName (http tunneling mode, default port is 80)
    procedure close;
  // callbacks
    property onStatus:TMethod_NetConnection_onStatus;
  end;

type

// NetStream - playing Flash Video (FLV) files from the local file system or an HTTP address

  // parameter for NetStream.onCuePoint - TEMPLATE ONLY!
  infoObject_NetStream_onCuePoint=external class(Object)
    property name:string; // the name of the cue point
    property time:double; // the time (seconds) of the cue point
    property type_:string as type; // alias for type, valid values are 'navigation' or 'event'
    property typ:string as type; // second alias for type
    property parameters: array of object;
  end;

  // parameter for NetStream.onMetaData - TEMPLATE ONLY!
  infoObject_NetStream_onMetaData=external class(Object)
    property canSeekToEnd:Boolean;
    property videocodecid:Integer;
    property framerate:Integer;
    property videodatarate:Integer;
    property height:Integer;
    property width:Integer;
    property duration:double;
  end;

  // parameter for NetStream.onStatus - TEMPLATE ONLY!
  infoObject_NetStream_onStatus=external class(Object)
    property code:string;
    property Level:string;
  end;

  TMethod_NetStream_onCuePoint=procedure(infoObject:object)of object; // infoObject_NetStream_onCuePoint
  TMethod_NetStream_onMetaData=procedure(infoObject:object)of object; // infoObject_NetStream_onMetaData
  //TMethod_NetStream_onPlayStatus=procedure(infoObject:object)of object; // ?
  TMethod_NetStream_onStatus=procedure(infoObject:object)of object; // infoObject_NetStream_onStatus

  NetStream=external class
    property bufferLength:Integer;
    property bufferTime:Integer;
    property bytesLoaded:Integer;
    property bytesTotal:Integer;
    property currentFps:Integer;
    property liveDelay:Integer;
    property time:Integer;
  // methods
    constructor Create(connection:NetConnection);
    procedure attachAudio(theMicrophone:Microphone);
    procedure attachVideo(theCamera:Camera;snapshotMilliseconds:Integer);
    procedure close;
    procedure pause(flag:Boolean);
    procedure play(name:object; start:Integer; len:Integer; reset:object);
    procedure publish(name:object;_type:String);
    procedure receiveAudio(flag:Boolean);
    procedure receiveVideo(flag:object); // flag:object can be Boolean (play/stop incoming video) or Double for frame rate (goes to currentFPS)
    procedure seek(offset:Integer);
    procedure send(handlerName:String);
    procedure setBufferTime(bufferTime:Integer);
  // callbacks
    property onCuePoint:TMethod_NetStream_onCuePoint;
    property onMetaData:TMethod_NetStream_onMetaData;
    //function onPlayStatus:TMethod_NetStream_onPlayStatus;
    property onStatus:TMethod_NetStream_onStatus;
  end;

type

// Video - display streaming video

  Video=external class
    property _alpha:Integer;
    property _height:Integer;
    property _name:String;
    property _parent:MovieClip;
    property _rotation:Integer;
    property _visible:Boolean;
    property _width:Integer;
    property _x:Integer;
    property _xmouse:Integer;
    property _xscale:Integer;
    property _y:Integer;
    property _ymouse:Integer;
    property _yscale:Integer;
    property deblocking:Integer;
    property height:Integer;
    property smoothing:Boolean;
    property width:Integer;
    constructor Create;
    procedure attachVideo(source:object); // source:object can be Camera, NetStream (or nil to drop connection)
    procedure clear;
    // Flash Lite 2.x
    procedure close;
    procedure pause;
    function play:Boolean;
    procedure resume;
    procedure stop;
  end;

implementation

end.
