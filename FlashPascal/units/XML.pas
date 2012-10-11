{ This file is part of Flash Pascal project. See 'http://flashpascal.sf.net' for more. }

unit XML; // working with XML documents

interface

const // nodeType
  nodeTypeXML  = 1; // an XML element
  nodeTypeTEXT = 3; // a text node

type
  TMethod_XML_onLoad=procedure(success:Boolean)of object;
  TMethod_XML_onData=procedure(src:String)of object;

type
  XMLNode=external class
    //property attributes:object; // associative array containing all attributes of the XMLNode
    property childNodes:array of XMLNode;
    property firstChild:XMLNode;
    property lastChild:XMLNode;
    property nextSibling:XMLNode;
    property nodeName:String;
    property nodeType:Integer;
    property nodeValue:String;
    property parentNode:XMLNode;
    property previousSibling:XMLNode;
    constructor Create(nodeType:Integer;value:String); // nodeType 1 or 3
    function cloneNode(deep:Boolean):XMLNode;
    procedure removeNode;
    procedure insertBefore(newChild,insertPoint:XMLNode);
    procedure appendChild(newChild:XMLNode);
    function hasChildNodes:Boolean;
    function toString:String;
    function addTreeNodeAt(index:Integer;arg1,arg2:object):XMLNode;
    function addTreeNode(arg1,arg2:object):XMLNode;
    function getTreeNodeAt(index:Integer):XMLNode;
    function removeTreeNodeAt(index:Integer):XMLNode;
    function removeTreeNode:XMLNode;
  end;


  XML=external class {extends XMLNode --> this needs to be implemented}
    // XMLNode properties
    //property attributes:object; // associative array containing all attributes of the XML
    property childNodes:array of XML;
    property firstChild:XML;
    property lastChild:XML;
    property nextSibling:XML;
    property nodeName:String;
    property nodeType:Integer;
    property nodeValue:String;
    property parentNode:XML;
    property previousSibling:XML;
    // XML properties
    property contentType:String;
    property docTypeDecl:String;
    property ignoreWhite:Boolean;
    property loaded:Boolean;
    property status:Integer;
    property xmlDecl:String;
    // XMLNode methods
    function cloneNode(deep:Boolean):XML;
    procedure removeNode;
    procedure insertBefore(newChild,insertPoint:XML);
    procedure appendChild(newChild:XML);
    function hasChildNodes:Boolean;
    function toString:String;
    function addTreeNodeAt(index:Integer;arg1,arg2:object):XML;
    function addTreeNode(arg1,arg2:object):XML;
    function getTreeNodeAt(index:Integer):XML;
    function removeTreeNodeAt(index:Integer):XML;
    function removeTreeNode:XML;
    // XML methods
    constructor Create(text:String);
    function createElement(name:String):XML;
    function createTextNode(value:String):XML;
    procedure parseXML(text:String);
    function getBytesLoaded:Integer;
    function getBytesTotal:Integer;
    function load(url:String):Boolean;
    function send(url:String;target:String):Boolean;
    function sendM(url:String;target:String;method:String):Boolean;
    procedure sendAndLoad(url:String; target:XML);
    procedure addRequestHeader(headerName,headerValue:String);
    //callbacks
    property onLoad:TMethod_XML_onLoad;
    property onData:TMethod_XML_onData;
  end;

{
  myXML:=XML.Create('<list>TheList<image1>a.png</image1><image2>b.jpg</image2></list>');

  myXML:=XML.Create('');
  myXML.ParseXML('<list>TheList<image1>a.png</image1><image2>b.jpg</image2></list>');

  bXML:=createElement('TestElement');
  cXML:=createTextNode('TestTextNodeValue');
  myXML.appendChild(cXML);
}

type

  TMethod_XMLSocket_onData=procedure(src:String);
  TMethod_XMLSocket_onXML=procedure(src:XML);
  TMethod_XMLSocket_onConnect=procedure(success:Boolean);
  TMethod_XMLSocket_onClose=procedure;

  XMLSocket=external class
    constructor Create;
    function connect(url:String;port:Integer):Boolean;
    function send(data:Object):Boolean;
    function close:Boolean;
    //callbacks
    property onData:TMethod_XMLSocket_onData;
    property onXML:TMethod_XMLSocket_onXML;
    property onConnect:TMethod_XMLSocket_onConnect;
    property onClose:TMethod_XMLSocket_onClose;
  end;

implementation

end.
