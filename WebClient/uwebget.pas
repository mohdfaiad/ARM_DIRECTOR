unit uwebget;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,strutils, httpsend,system.win.crtl;


var
  PortNum : integer = 9091;
 chbuf : array[0..100000] of char;
  tmpjSon : ansistring;
  Jevent, JDev, jAirsecond : TStringList;
  Jmain : ansistring;
  jsonresult : ansistring;
Function GetJsonStrFromWeb(url : ansistring): ansistring;


implementation

Function GetJsonStrFromWeb(url : ansistring): ansistring;
var










    strlist := tstringlist.create;
    httpgettext(url,strlist);
    strlist.savetofile('g:\home\gettext.js');
    http := THTTPSend.Create;
    HTTP.HTTPMethod('GET', url);










