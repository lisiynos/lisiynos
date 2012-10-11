{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit System; // access the Flash system and I/O Devices

interface

// System.capabilities - reading system capabilities

type

  TSystemCapabilities=external class(System.capabilities)
    property hasAudio:Boolean;
    property hasMP3:Boolean;
    property hasAudioEncoder:Boolean;
    property hasVideoEncoder:Boolean;
    property screenResolutionX:Integer;
    property screenResolutionY:Integer;
    property screenDPI:Integer;
    property screenColor:String;
    property pixelAspectRatio:Integer; // double (?)
    property hasAccessibility:Boolean;
    property input:String;
    property isDebugger:Boolean;
    property language:String;
    property manufacturer:String;
    property os:String;
    property serverString:String;
    property version:String;
    property hasPrinting:Boolean;
    property playerType:String;
    property hasStreamingAudio:Boolean;
    property hasScreenBroadcast:Boolean;
    property hasScreenPlayback:Boolean;
    property hasStreamingVideo:Boolean;
    property hasEmbeddedVideo:Boolean;
    property avHardwareDisable:Boolean;
    property localFileReadDisable:Boolean;
    property windowlessDisable:Boolean;
    // Flash Lite 2.x
    property audioMIMETypes:array of String;
    property has4WayKeyAS:Boolean;
    property hasCMIDI:Boolean;
    property hasCompoundSound:Boolean;
    property hasDataLoading:Boolean;
    property hasEmail:Boolean;
    property hasMappableSoftKeys:Boolean;
    property hasMFI:Boolean;
    property hasMIDI:Boolean;
    property hasMMS:Boolean;
    property hasMouse:Boolean;
    property hasQWERTYKeyboard:Boolean;
    property hasSharedObjects:Boolean;
    property hasSMAF:Boolean;
    property hasSMS:Integer;
    property hasStylus:Boolean;
    property hasXMLSocket:Boolean; // added in Flash Lite 2.1
    property imageMIMETypes:array of String;
    property MIMETypes:array of String;
    property screenOrientation:String;
    property softKeyCount:Integer;
    property videoMIMETypes:array of String;
  end;

// System.security - manage system security

const // available contents of System.security.sandboxType
  sbRemote='remote';
  sbLocalWithFile='localWithFile';
  sbLocalWithNetwork='localWithNetwork';
  sbLocalTrusted='localTrusted';

procedure systemAllowDomain(domain:String) external System.security.allowDomain;
procedure systemAllowInsecureDomain(domain:String) external System.security.allowInsecureDomain;
procedure systemLoadPolicyFile(url:String) external System.security.loadPolicyFile;

type

  TSystemSecurity=external class(System.security)
    property sandboxType:String; // read-only
    procedure allowDomain(domain:String);
    procedure allowInsecureDomain(domain:String);
    procedure loadPolicyFile(url:String);
    procedure allowDomain(domain:String);
    procedure allowInsecureDomain(domain:String);
    procedure loadPolicyFile(url:String);
  end;


// System - accessing the Flash system

const
  // infoObject.Level
  ilStatus='status';
  ilError='error';

const
  // for infoObject.code (some examples)
  icNetStreamBufferEmpty='NetStream.Buffer.Full'; // status
  icNetStreamBufferFull='NetStream.Buffer.Full'; // status
  icNetStreamBufferFlush='NetStream.Buffer.Flush'; // status
  icNetStreamPlayStart='NetStream.Play.Start'; // status
  icNetStreamPlayStop='NetStream.Play.Stop'; // status
  icNetStreamPlayStreamNotFound='NetStream.Play.StreamNotFound'; // error
  icNetStreamSeekInvalidTime='NetStream.Seek.InvalidTime'; // error
  icNetStreamSeekNotify='NetStream.Seek.Notify'; // status
  icNetConnectionCallSuccess='NetConnection.Call.Success'; // status
  icNetConnectionCallFailed='NetConnection.Call.Failed'; // error
  icNetConnectionCallBadValue='NetConnection.Call.BadValue'; // error
  icNetConnectionConnectAppShutdown='NetConnection.Connect.AppShutdown'; // error
  icNetConnectionConnectClosed='NetConnection.Connect.Closed'; // status
  icNetConnectionConnectFailed='NetConnection.Connect.Failed'; // error
  icNetConnectionConnectInvalidApp='NetConnection.Connect.InvalidApp'; // error
  icNetConnectionConnectRejected='NetConnection.Connect.Rejected'; // error
  icNetConnectionConnectSuccess='NetConnection.Connect.Success'; // status
  icNetConnectionAdminCommandFailed='NetConnection.Admin.CommandFailed'; // error

type

  // parameter for System.onStatus() - TEMPLATE ONLY!
  infoObject_System_onStatus=external class(object)
    property code:string;
    property Level:string;
  end;

  TMethod_System_onStatus=procedure(infoObject: object)of object; // infoObject_System_onStatus

const // for tabID parameter of System.showSettings()
  stPrivacy=0;
  stLocalStorage=1;
  stMicrophone=2;
  stCamera=3;

procedure systemShowSettings(tabID:Integer) external System.showSettings;
procedure systemSetClipboard(text:String) external System.setClipboard;

type

  TSystem=external class(System)
    capabilities:TSystemCapabilities;
    security:TSystemSecurity;
    property useCodepage:Boolean;
    property exactSettings:Boolean;
    property onStatus:TMethod_System_onStatus; // super event handler
    procedure showSettings(tabID:Integer);
    procedure setClipboard(text:String);
    procedure showSettings(tabID:Integer);
    procedure setClipboard(text:String);
  end;

var
  System:TSystem;

implementation

end.
