﻿unit mainsrv;

// fdgsdfgsdf
interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons, ExtCtrls, HTTPSend, blcksock, winsock, Synautil,
    strutils, system.json, AppEvnts, Menus, inifiles, das_const, ipcthrd,
    TeEngine, Series, TeeProcs, Chart, VclTee.TeeGDIPlus, System.Generics.Collections,
<<<<<<< HEAD
    mmsystem, synaip, Web.Win.Sockets;
=======
    mmsystem;
>>>>>>> 567489eb579fa25cb906471546da671d36020444

type
    THTTPSRVForm = class(TForm)
        Panel1: TPanel;
        Timer1: TTimer;
        Memo2: TMemo;
        URLED: TEdit;
<<<<<<< HEAD
=======
        SpeedButton1: TSpeedButton;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
        BitBtn1: TBitBtn;
        PopupMenu2: TPopupMenu;
        Restore1: TMenuItem;
        Minimize1: TMenuItem;
        quit1: TMenuItem;
<<<<<<< HEAD
        Memo1: TMemo;
        txt1: TStaticText;
        txt2: TStaticText;
        webreqtxt: TStaticText;
        mmo1: TMemo;
        procedure FormCreate(Sender: TObject);
=======
    Memo1: TMemo;
    txt1: TStaticText;
    txt2: TStaticText;
        procedure FormCreate(Sender: TObject);
        procedure SpeedButton1Click(Sender: TObject);
>>>>>>> 567489eb579fa25cb906471546da671d36020444
        procedure terminate1Click(Sender: TObject);
        procedure Panel1Click(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure FormDestroy(Sender: TObject);
        procedure Restore1Click(Sender: TObject);
        procedure Minimize1Click(Sender: TObject);
        procedure quit1Click(Sender: TObject);
        procedure FormShow(Sender: TObject);
<<<<<<< HEAD
        procedure TcpserverAccept(Sender: TObject; ClientSocket: TCustomIpClient);
        procedure TcphttpserverAccept(Sender: TObject; ClientSocket: TCustomIpClient);
        procedure Timer1Timer(Sender: TObject);
=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    private
    protected
        procedure ControlWindow(var Msg: TMessage); message WM_SYSCOMMAND;
        procedure IconMouse(var Msg: TMessage); message WM_USER + 1;
    public
<<<<<<< HEAD
        TCPsrv: TTcpServer;
        TCPHTTPsrv: TTcpServer;
=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
        procedure Ic(n: Integer; Icon: TIcon);
    end;

    TTCPHttpDaemon = class(TThread)
    private
        Sock: TTCPBlockSocket;
    public
        constructor Create;
        destructor Destroy; override;
        procedure Execute; override;
<<<<<<< HEAD
        procedure DoExecute;
=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    end;

    TTCPHttpThrd = class(TThread)
    private
        Sock: TTCPBlockSocket;
    public
        Headers: TStringList;
        InputData, OutputData: TMemoryStream;
        constructor Create(hsock: tSocket);
        destructor Destroy; override;
        procedure Execute; override;
<<<<<<< HEAD
        procedure doExecute;
=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
        function ProcessHttpRequest(Request, URI: string): Integer;
    end;

    THardRec = packed record
        DateTimeSTR: array[0..5] of ansichar;
        UpdateCounter: int64;
        VersionSignature: array[0..5] of ansichar;
        JSONAll: array[0..1000000] of ansichar;
        JSONStore: array[0..1000000] of ansichar;
    end;

    PHardRec = ^THardRec;

    TWebVar = packed record
        Name: ansistring;
        baseName: ansistring;
        changed: int64;
        jsonStr: ansistring;
        json: TJSONObject;
    end;

<<<<<<< HEAD
function ProcessRequest(URI: string): AnsiString;

var
    LocalTCPPort: string = '9085';
    EmptyWebVar: TWebVar;// = ('','',-1,'',nil); //'','',-1,'',nil);
=======
var
    EmptyWebVar: TWebVar = (); //'','',-1,'',nil);
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    VarCount: integer = 0;
    webvars: array[0..10000] of twebvar;
    KeyNames: tstringlist;
    Keyvalues: tstringlist;
    JsonVars: tstringlist;
    PrevUpdates: Integer = 0;
    HardRec: PHardRec;
    testbuf: array[0..1000] of byte absolute HardRec;
    shared: tsharedmem;
    PortNum: Integer = 9090;
    textfromjson: string = '[]';
    currentData: string = '{}';
    testjson: string = '[{"time":"18:57:40","sbrkgu1":0,"sbrkgu2":0,"k1t6":272.73,"k1t12":295.05,"k1t13":288.41,"k1dt5t6":12.15,"k1dt3t4":2.73,"k1sbr":0,' + '"k1vanna":0,"k1bo1":0.37,"k1bo2":0,"k2t6":108.89,"k2t12":211.58,"k2t13":286.86,"k2dt5t6":-2.02,"k2dt3t4":-1.91,"k2sbr":0,"k2vanna":0,' + '"k2bo1":0,"k2bo2":58.79}]';
    starttime: double;
    HTTP: THTTPSend = nil;
    PrevUpdate: double = 0;
    HTTPsrv: TTCPHttpDaemon;
    HTTPSRVFORM: THTTPSRVForm;
    URL: string;
    intsum: Integer = 0;
    intcount: Integer = 0;
    maxint: Integer = 0;
    minint: Integer = 10000;
    lastReq: double;

implementation

uses
    shellapi;
{$R *.dfm}

<<<<<<< HEAD
function ReceiveBlob(sock: thandle; var buff: array of ansichar; len: integer): Integer;
var
    rc: integer;
    incount: integer;
    readLen: integer;
begin
    synWriteLog('webget', 'Receive block begin');
    FillChar(buff, high(buff), 0);
    readLen := 0;
    result := -1;

    repeat
        sleep(2);
//        synWriteLog('webget', ' IOCTL');
        rc := ioctlsocket(sock, FIONREAD, incount);
        if incount = 0 then break;

        if incount > 8000 then
//            synWriteLog('webget', ' LARGE TCP To read = ' + IntToStr(incount));
//        synWriteLog('webget', ' TCP To read = ' + IntToStr(incount));
        if rc <> 0 then begin
            rc := wsagetlasterror;
            synWriteLog('webget', ' DISconnect BY ERROR AFTER ioctl = ' + syserrormessage(rc));
            Exit;
        end;
        if incount < 0 then begin
            rc := wsagetlasterror;
            if rc <> 0 then begin
                synWriteLog('webget', ' DISconnect BY ERROR AFTER RECEIVE = ' + syserrormessage(rc));
            end
            else
                synWriteLog('webget', ' DISconnect BY ERROR AFTER RECEIVE incount= ' + IntToStr(incount));
            Exit;
        end;
        rc := recv(sock, buff[readLen], incount, 0);
        if rc <= 0 then begin
            rc := WSAGetLastError;
            synWriteLog('webget', 'Error receive ' + syserrormessage(rc));
            exit;
        end;
        readLen := readLen + rc;

    until incount <= 0;
//    synWriteLog('webget', 'Receive block ok len =' + IntToSTr(readLen));
    result := readLen;
end;

procedure THTTPSRVForm.TcpserverAccept(Sender: TObject;       //пришло сообщение
    ClientSocket: TCustomIpClient);
var
    txt: string;
    buffer: array[0..300000] of ansichar;
    tmpBuffer: integer;
    rcstr, hstr: string;
    rc: Integer;
    outstr, instr, uri: AnsiString;
    resp: ansistring;
    i1: integer;
    incount: integer;
    st : int64;
    chTime : ansistring;
begin
    hstr := 'Connect H=' + IntToStr(ClientSocket.Handle) + ' ';
    synWriteLog('webget', hstr);
//    mmo1.Lines.add(FormatDateTime('HH:NN:SS ', now) + 'accept' + hstr);
    while True do begin
//        sleep(1);
        rc := recv(ClientSocket.Handle, buffer[0],1,MSG_PEEK);
        if rc <= 0 then begin
            rc := WSAGetlastError;
            synWriteLog('webget', ' DISconnect by other sid. Checked on wait incoming packet'+SysErrorMessage(rc));
            ClientSocket.Disconnect;
            Exit;
        end;
        st := timegettime;
        synWriteLog('webget','Begin receive block');


        rc := ReceiveBlob(ClientSocket.Handle, buffer, 200000);
        if rc < 0 then begin
            rc := WSAGetlastError;
            ;
            synWriteLog('webget', ' DISconnect BY ERROR AFTER receive blob');
            ClientSocket.Disconnect;
            Exit;
        end;

        instr := buffer;
        synWriteLog('webget',Format('Received len=%d time=%d ',[rc,timegettime-st])+ ' Request= ' + system.copy(instr, 1, 30));
        while length(instr) > 5 do begin
            if system.copy(instr, 1, 5) = '/GET_' then
                break;
            if system.copy(instr, 1, 5) = '/SET_' then
                break;
            if system.copy(instr, 1, 5) = '/DEL_' then
                break;
            if system.copy(instr, 1, 5) = '/TIM_' then
                break;
            if system.copy(instr, 1, 5) = '/ADD_' then
                break;
            if system.copy(instr, 1, 5) = '/UPD_' then
                break;
            system.Delete(instr, 1, 1);

        end;
        uri := instr;
        i1 := pos(' ', uri) - 1;
        if i1 > 1 then
            uri := system.copy(uri, 1, i1);
        synWriteLog('webget', ' Request ' + system.copy(uri, 1, 30));

        outstr := ProcessRequest(uri);
        if pos('GET_', uri) > 0 then begin

//            synWriteLog('GET_', uri + ' =  ' + outstr);
        end;
        synWriteLog('webget', ' Answer ' + system.copy(outstr, 1, 30));

        strpcopy(buffer, outstr + #0 + #255);
        synWriteLog('webget',Format('Processed len=%d time=%d ',[rc,timegettime-st])+ ' Answer= ' + system.copy(outstr, 1, 30));
        rc := Send(ClientSocket.handle, buffer[0], length(outstr + #00+#255), 0);
        synWriteLog('webget', ' send ' + IntToStr(rc));
        if rc < 0 then begin
            rc := WSAGetlastError;
            synWriteLog('webget', ' DISconnect BY ERROR AFTER SEND ERR = ' + syserrormessage(rc));
            ClientSocket.Disconnect;
            Exit;
        end;
        synWriteLog('webget',Format('Completed time=%d ',[timegettime-st]));

    end;

end;

procedure THTTPSRVForm.TcpHTTPserverAccept(Sender: TObject;       //пришло сообщение
    ClientSocket: TCustomIpClient);
var
    txt: string;
    buffer: array[0..100000] of ansichar;
    tmpBuffer: integer;
    rcstr, hstr: string;
    rc: Integer;
    outstr, instr, uri: AnsiString;
    resp: ansistring;
    i1: integer;

    procedure FillBuff(buff: array of ansichar; instr: ansistring);
    var
        i1: integer;
    begin
        for i1 := 0 to length(instr) do
            buff[i1] := instr[i1];

    end;

begin
    hstr := 'H=' + IntToStr(ClientSocket.Handle) + ' ';
//    mmo1.Lines.add(FormatDateTime('HH:NN:SS ', now) + 'accept' + hstr);
    while True do begin
        FillChar(buffer, 0, High(buffer));
        rc := ClientSocket.ReceiveBuf(buffer, 10000);  //берем буфер
        rcstr := ' ' + IntToStr(rc) + ' ';
        if rc <= 0 then begin
            mmo1.Lines.Add(IntToStr(rc) + ' err:' + hstr + syserrormessage(wsagetlasterror));
            exit;
        end;
        if Length(buffer) <> 0 then
//            mmo1.Lines.Add(hstr + rcstr + ' Read:' + buffer);
            instr := buffer;
//        for i1 := 1 to length(instr) do uri := u
        i1 := pos(#13, instr) - 1;
        if i1 < 1 then
            i1 := pos(#10, instr) - 1;
        if i1 < 1 then
            i1 := length(instr) - 1;
        uri := system.copy(instr, 1, i1);
        uri := system.copy(uri, Pos('/', uri), Length(uri));
        i1 := pos(' ', uri) - 1;
        if i1 < 1 then
            i1 := length(uri) - 1;
        uri := system.copy(uri, 1, i1);

        outstr := ProcessRequest(uri);
        if pos('GET_', uri) > 0 then begin

//            synWriteLog('GET_', uri + ' =  ' + outstr);
        end;
        ClientSocket.Sendln('HTTP/1.0 ' + '200' + CRLF + 'Content-type: Text/Html' + #13#10 + 'Content-length: ' + IntToStr(length(outstr)) + #13#10 + 'Connection: close' + #13#10 + 'Date: Tue, 20 Mar 2018 14:04:45 +0300' + #13#10 + 'Server: Synapse HTTP server demo' + #13#10 + #13#10 + outstr + crlf);

        exit;

    end;

end;

=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
procedure THTTPSRVForm.IconMouse(var Msg: TMessage);
var
    p: tpoint;
begin
    GetCursorPos(p); // Запоминаем координаты курсора мыши
    case Msg.LParam of  // Проверяем какая кнопка была нажата
        WM_LBUTTONUP, WM_LBUTTONDBLCLK: {Действия, выполняемый по одинарному или двойному щелчку левой кнопки мыши на значке. В нашем случае это просто активация приложения}
            begin
//        ShowWindow(Application.Handle, SW_SHOW); // Восстанавливаем кнопку программы
                ShowWindow(Handle, SW_SHOW); // Восстанавливаем окно программы
            end;
        WM_RBUTTONUP: {Действия, выполняемый по одинарному щелчку правой кнопки мыши}
            begin
                SetForegroundWindow(Handle);                   // Восстанавливаем программу в качестве переднего окна
                PopupMenu2.Popup(p.X, p.Y);  // Заставляем всплыть тот самый TPopUp о котором я говорил чуть раньше
                PostMessage(Handle, WM_NULL, 0, 0);
            end;
    end;
end;

procedure THTTPSRVForm.Minimize1Click(Sender: TObject);
begin
    ShowWindow(Handle, SW_hide); // Âîññòàíàâëèâàåì îêíî ïðîãðàììû
    application.Minimize;
end;

procedure THTTPSRVForm.Ic(n: Integer; Icon: TIcon);
var
    Nim: TNotifyIconData;
begin
    Nim.cbSize := SizeOf(Nim);
    with Nim do begin
        Wnd := Handle;
        uID := 1;
        uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
        hicon := Icon.Handle;
        uCallbackMessage := wm_user + 1;
        szTip := 'WEB-Shell interface server';
    end;
    case n of
        1:
            Shell_NotifyIcon(Nim_Add, @Nim);
        2:
            Shell_NotifyIcon(Nim_Delete, @Nim);
        3:
            Shell_NotifyIcon(Nim_Modify, @Nim);
    end;
end;

procedure THTTPSRVForm.ControlWindow(var Msg: TMessage);
begin
    if Msg.WParam = SC_MINIMIZE then begin
        ShowWindow(Handle, SW_HIDE);  // ???????? ?????????
//    ShowWindow(Application.Handle, SW_HIDE);  // ???????? ?????? ? TaskBar'?
    end
    else
        inherited;
end;

procedure THTTPSRVForm.Panel1Click(Sender: TObject);
<<<<<<< HEAD
var
    st: int64;
begin
    st := timeGetTime;

=======
begin
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    HTTP := THTTPSend.Create;
    try
//    HTTP.ProxyHost := Edit8.Text;
//    HTTP.ProxyPort := Edit9.Text;
        HTTP.HTTPMethod('GET', URLED.text);
        Memo2.Lines.Assign(HTTP.Headers);
<<<<<<< HEAD
        Memo1.Lines.LoadFromStream(HTTP.Document);
    finally
        HTTP.Free;
    end;

    webreqtxt.Caption := ' WEBTIME = ' + IntToStr(timeGetTime - st);

=======
//    Memo3.Lines.LoadFromStream(HTTP.Document);
    finally
        HTTP.Free;
    end;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
end;

procedure THTTPSRVForm.quit1Click(Sender: TObject);
begin
    halt;
end;

procedure THTTPSRVForm.Restore1Click(Sender: TObject);
begin
    ShowWindow(Handle, SW_SHOW);
end;

procedure THTTPSRVForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    ShowWindow(Handle, SW_hide);
    Action := caNone;

end;

procedure THTTPSRVForm.FormCreate(Sender: TObject);
var
    ff: tfilestream;
    str1: string;
    objFileName: string;
    strlist: TStringList;
<<<<<<< HEAD
    rc: integer;
=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
begin

    starttime := now;
    while (now - starttime) * 24 * 3600 < 3 do
        Application.ProcessMessages;

<<<<<<< HEAD
    tcpsrv := ttcpserver.Create(nil);
    tcpsrv.LocalPort := IntToStr(StrToInt(LocalTCPPort));
    tcpsrv.OnAccept := TcpserverAccept;
    tcpsrv.Active := true;
    rc := WSAGetlastError;

    if rc <> 0 then begin
        mmo1.Lines.add(IntToStr(rc) + ' TCPSRV ' + syserrormessage(rc) + ' ');
        tcpsrv.Free;
    end;

    tcphttpsrv := ttcpserver.Create(nil);
    tcphttpsrv.LocalPort := IntToStr(StrToInt(LocalTCPPort) + 5);
    tcphttpsrv.OnAccept := TcpHTTPserverAccept;
    tcphttpsrv.Active := true;
    rc := WSAGetlastError;

    if rc <> 0 then begin
        mmo1.Lines.add(IntToStr(rc) + ' TCPHTT ' + syserrormessage(rc) + ' ');
        tcphttpsrv.Free;
    end;


//    HTTPsrv := TTCPHttpDaemon.Create;
=======
    HTTPsrv := TTCPHttpDaemon.Create;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    lastReq := -1;
    Ic(1, Application.Icon);
    Timer1.Enabled := true;
    application.Minimize;

end;

procedure THTTPSRVForm.FormDestroy(Sender: TObject);
begin
    Ic(2, Application.Icon);
end;

procedure THTTPSRVForm.FormShow(Sender: TObject);
begin
    ShowWindow(Application.Handle, SW_HIDE);
    ShowWindow(Application.MainForm.Handle, SW_HIDE);

end;

constructor TTCPHttpDaemon.Create;
begin
    inherited Create(false);
<<<<<<< HEAD
    sock := TTCPBlockSocket.Create;
=======
    Sock := TTCPBlockSocket.Create;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    FreeOnTerminate := true;
    Priority := tpNormal;
end;

destructor TTCPHttpDaemon.Destroy;
begin
<<<<<<< HEAD
    sock.free;
    inherited Destroy;
end;

procedure TTCPHttpDaemon.DoExecute;
=======
    Sock.free;
    inherited Destroy;
end;

procedure TTCPHttpDaemon.Execute;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
var
    ClientSock: tSocket;
begin
  // writeTimeLog('open sock');
<<<<<<< HEAD
    with sock do begin
=======
    with Sock do begin
>>>>>>> 567489eb579fa25cb906471546da671d36020444
        CreateSocket;
        setLinger(true, 10);
        bind('0.0.0.0', IntToStr(PortNum));
        listen;
    // writeTimeLog('Listen sock');
        repeat
            if terminated then
                break;
            if canread(1000) then begin
        // writeTimeLog('Client read sock');
                ClientSock := accept;
                if lastError = 0 then
                    TTCPHttpThrd.Create(ClientSock);
            end;
        until false;
    end;
end;

<<<<<<< HEAD
procedure TTCPHttpDaemon.Execute;
var
    st: int64;
begin
    st := timegettime;
    doExecute;
end;

=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
{ TTCPHttpThrd }

constructor TTCPHttpThrd.Create(hsock: tSocket);
begin
<<<<<<< HEAD
//    writeTimeLog('TCPHttpThrd.Create');
    inherited Create(false);
    sock := TTCPBlockSocket.Create;
    Headers := TStringList.Create;
    InputData := TMemoryStream.Create;
    OutputData := TMemoryStream.Create;
    sock.socket := hsock;
=======
    writeTimeLog('TCPHttpThrd.Create');

    inherited Create(false);
    Sock := TTCPBlockSocket.Create;
    Headers := TStringList.Create;
    InputData := TMemoryStream.Create;
    OutputData := TMemoryStream.Create;
    Sock.socket := hsock;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    FreeOnTerminate := true;
    Priority := tpNormal;
end;

destructor TTCPHttpThrd.Destroy;
begin
<<<<<<< HEAD
    sock.free;
=======
    Sock.free;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    Headers.free;
    InputData.free;
    OutputData.free;
    inherited Destroy;
end;

<<<<<<< HEAD
procedure TTCPHttpThrd.doExecute;
=======
procedure TTCPHttpThrd.Execute;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
var
    b: byte;
    timeout: Integer;
    s: string;
    method, URI, protocol: string;
    size: Integer;
    X, n: Integer;
    resultcode: Integer;
<<<<<<< HEAD
    rsstr: string;
    st: int64;

    procedure addMark(num: integer);
    begin
        rsstr := rsstr + format('%d %dms ', [num, TimegetTime - st]);
        st := TimegetTime;
    end;

begin
    rsstr := '';
    st := timegettime;
    addMark(1);
    timeout := 1200;
  // read request line
    s := sock.RecvString(timeout);
    WriteLog('URI ' + s);
    addMark(2);
    if sock.lastError <> 0 then
=======
begin
    writeTimeLog('123');
    timeout := 120000;
  // read request line
    s := Sock.RecvString(timeout);
    if Sock.lastError <> 0 then
>>>>>>> 567489eb579fa25cb906471546da671d36020444
        Exit;
    if s = '' then
        Exit;
    method := fetch(s, ' ');
    if (s = '') or (method = '') then
        Exit;
    URI := fetch(s, ' ');
    if URI = '' then
        Exit;
    protocol := fetch(s, ' ');
//    protocol :=  'HTTP/1.0';
    Headers.Clear;
    size := -1;
  // read request headers
    if protocol <> '' then begin
        if pos('HTTP/', protocol) <> 1 then
            Exit;
        repeat
<<<<<<< HEAD

            s := sock.RecvString(timeout);
            if pos('Host:', s) > 0 then
                rsstr := s + rsstr;
            addMark(3);
            if sock.lastError <> 0 then
=======
            s := Sock.RecvString(timeout);
            if Sock.lastError <> 0 then
>>>>>>> 567489eb579fa25cb906471546da671d36020444
                Exit;
            if s <> '' then
                Headers.add(s);
            if pos('CONTENT-LENGTH:', Uppercase(s)) = 1 then
                size := StrToIntDef(SeparateRight(s, ' '), -1);
        until s = '';
    end;
  // recv document...
    InputData.Clear;
    if size >= 0 then begin
        InputData.SetSize(size);
<<<<<<< HEAD
        X := sock.RecvBufferEx(InputData.Memory, size, timeout);
        addMark(4);
        InputData.SetSize(X);
        if sock.lastError <> 0 then
=======
        X := Sock.RecvBufferEx(InputData.Memory, size, timeout);
        InputData.SetSize(X);
        if Sock.lastError <> 0 then
>>>>>>> 567489eb579fa25cb906471546da671d36020444
            Exit;
    end;
    OutputData.Clear;
    resultcode := ProcessHttpRequest(method, URI);
<<<<<<< HEAD
    sock.SendString('HTTP/1.0 ' + IntToStr(resultcode) + CRLF);
=======
    Sock.SendString('HTTP/1.0 ' + IntToStr(resultcode) + CRLF);
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    if protocol <> '' then begin
        Headers.add('Content-length: ' + IntToStr(OutputData.size));
        Headers.add('Connection: close');
        Headers.add('Date: ' + Rfc822DateTime(now));
        Headers.add('Server: Synapse HTTP server demo');
        Headers.add('');
<<<<<<< HEAD
        addMark(5);
        for n := 0 to Headers.count - 1 do
            sock.SendString(Headers[n] + CRLF);
        addMark(6);
        headers.SaveToFile('g:\home\headers.txt');
    end;
    if sock.lastError <> 0 then
        Exit;
    sock.SendBuffer(OutputData.Memory, OutputData.size);
    addMark(7);
=======
        for n := 0 to Headers.count - 1 do
            Sock.SendString(Headers[n] + CRLF);
    end;
    if Sock.lastError <> 0 then
        Exit;
    Sock.SendBuffer(OutputData.Memory, OutputData.size);
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    if lastReq > 0 then begin
        intsum := intsum + trunc((now - lastReq) * 24 * 3600 * 1000);
        inc(intcount);
        if (now - lastReq) * 24 * 3600 * 1000 > maxint then
            maxint := trunc((now - lastReq) * 24 * 3600 * 1000);
        if (now - lastReq) * 24 * 3600 * 1000 < minint then
            minint := trunc((now - lastReq) * 24 * 3600 * 1000);
    end;
    lastReq := now;
<<<<<<< HEAD
    addMark(8);

    sock.CloseSocket;
    addMark(9);
    synaip.synWriteLog('tcpip', 'Request process ' + rsstr);
    WriteLog('Request process ' + rsstr);
end;

procedure TTCPHttpThrd.Execute;
var
    st: int64;
begin
    st := timegettime;
    doExecute;
//  WriteLog('Request process time = '+IntToStr(timeGetTime-st));
=======
    Sock.CloseSocket;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
end;

procedure AddWebVar(keyname: ansistring; KeyValue: ansistring; json: tjsonobject);
var
    i1, i2, i3: integer;
    tnow: int64;
<<<<<<< HEAD
    JSvalue: TJSONValue;
    posstr: string;
=======
    JSvalue : TJSONValue;
    posstr : string;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
begin
    tnow := timeGetTime;
    if keyname = 'TLP' then begin

<<<<<<< HEAD
        JSvalue := json.GetValue('Position');
        if JSvalue <> nil then
            posstr := JSvalue.Value
        else
            posstr := 'NIL';

        HTTPSRVForm.txt1.Caption := 'TLP:' + formatdatetime('TLP: HH:NN:SS ZZZ ', now) + ' position:' + posstr;

    end
    else if keyname = 'CTC' then
        HTTPSRVForm.txt2.Caption := 'CTC:' + formatdatetime('TLP: HH:NN:SS ZZZ ', now)
    else
        HTTPSRVForm.memo1.lines.Values[keyname] := formatdatetime('HH:NN:SS ZZZ', now);
=======
      jsvalue := json.GetValue('Position');
      if JSvalue<>nil
         then posstr := JSvalue.Value
         else posstr := 'NIL';

      HTTPSRVForm.txt1.Caption :='TLP:'+ formatdatetime('TLP: HH:NN:SS ZZZ ',now)+' position:'+posstr;

    end else
        if keyname = 'CTC'
           then HTTPSRVForm.txt2.Caption :='CTC:'+ formatdatetime('TLP: HH:NN:SS ZZZ ',now)
           else   HTTPSRVForm.memo1.lines.Values[keyname] := formatdatetime('HH:NN:SS ZZZ',now);
    ;

>>>>>>> 567489eb579fa25cb906471546da671d36020444
    for i1 := 0 to VarCount - 1 do begin
        if ansiuppercase(webvars[i1].Name) <> ansiuppercase(keyname) then
            continue;
        webvars[i1].BaseName := keyname;

        if pos('[', keyname) > 1 then
            webvars[i1].BaseName := system.Copy(keyname, 1, pos('[', keyname) - 1);
        webvars[i1].changed := tnow;
        webvars[i1].jsonstr := KeyValue;
        webvars[i1].json.free;
        webvars[i1].json := json;
        exit;
    end;
    inc(varCount);
    i1 := varCount - 1;
    if pos('[', keyname) > 1 then
        webvars[i1].BaseName := system.Copy(keyname, 1, pos('[', keyname) - 1);
    webvars[i1].changed := tnow;
    webvars[i1].jsonstr := KeyValue;
    webvars[i1].name := keyname;

end;

<<<<<<< HEAD
function RemoveWebVar(keyname: ansistring): ansistring;
=======
procedure RemoveWebVar(keyname: ansistring);
>>>>>>> 567489eb579fa25cb906471546da671d36020444
var
    i1, i2, i3: integer;
    tnow: int64;
begin
<<<<<<< HEAD
    result := '{"RC":0,"status":"Not exist"}';

    for i1 := 0 to VarCount - 1 do begin
        if ansiuppercase(webvars[i1].Name) <> ansiuppercase(keyname) then
            continue;
        HTTPSRVForm.memo1.lines.Values[keyname] := 'deleted ' + formatdatetime('HH:NN:SS ZZZ', now);
        webvars[i1].changed := -1;
        result := '{"RC":0,"status":"Deleted"}';

=======
    for i1 := 0 to VarCount - 1 do begin
        if ansiuppercase(webvars[i1].Name) <> ansiuppercase(keyname) then
            continue;
        webvars[i1].changed := -1;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
        exit;
    end;
end;

function getWebVarTime(keyname: ansistring): int64;
var
    i1, i2, i3: integer;
    tnow: int64;
begin
    result := -1;
    for i1 := 0 to VarCount - 1 do begin
        if ansiuppercase(webvars[i1].Name) <> ansiuppercase(keyname) then
            continue;
        result := webvars[i1].changed;
        exit;
    end;
end;

procedure ParseKeyName(KeyName: ansistring; var baseName: ansistring; var Selkey: ansistring; var SelValue: ansistring);
var
    pair: string;
    st, fn: integer;
begin
    Selkey := '';
    baseName := KeyName;
    if pos('(', KeyName) = 0 then
        exit;
    if pos(')', KeyName) = 0 then
        exit;
    baseName := system.Copy(KeyName, 1, pos('(', KeyName) - 1);
    st := pos('(', KeyName) + 1;
    fn := pos(')', KeyName);
    pair := system.Copy(KeyName, st, fn - st);

    Selkey := system.Copy(pair, 1, pos(':', pair) - 1);
    SelValue := system.Copy(pair, pos(':', pair) + 1, Length(pair));
end;

<<<<<<< HEAD
//function GetVarBySelection(baseName, SelName, Selvalue: string): twebvar;
//var
//    i1, i2, i3: integer;
//    jvalue: tjsonvalue;
//    jstr: string;
//begin
//    for i1 := 0 to VarCount - 1 do begin
//        if ansiuppercase(webvars[i1].baseName) <> ansiuppercase(baseName) then
//            continue;
//        jvalue := webvars[i1].json.GetValue(SelName);
//        if jvalue = nil then
//            Continue;
//        jstr := jvalue.Value;
//        if jstr <> Selvalue then
//            continue;
//        result := webvars[i1];
//        exit;
//    end;
//    Result := EmptyWebVar;
//
//end;
=======
function GetVarBySelection(baseName, SelName, Selvalue: string): twebvar;
var
    i1, i2, i3: integer;
    jvalue: tjsonvalue;
    jstr: string;
begin
    for i1 := 0 to VarCount - 1 do begin
        if ansiuppercase(webvars[i1].baseName) <> ansiuppercase(baseName) then
            continue;
        jvalue := webvars[i1].json.GetValue(SelName);
        if jvalue = nil then
            Continue;
        jstr := jvalue.Value;
        if jstr <> Selvalue then
            continue;
        result := webvars[i1];
        exit;
    end;
    Result := EmptyWebVar;

end;
>>>>>>> 567489eb579fa25cb906471546da671d36020444

function GetWebVar(keyName: ansistring): TWebVar;
var
    i1, i2, i3: integer;
    str1: string;
    json: tjsonobject;
    baseName: ansistring;
    SelName: AnsiString;
    Selvalue: AnsiString;
begin
    result := EmptyWebVar;
    ;
<<<<<<< HEAD
//    ParseKeyName(keyName, baseName, SelName, Selvalue);
//    if SelName <> '' then begin
//        Result := GetVarBySelection(baseName, SelName, Selvalue);
//        exit;
//    end;
=======
    ParseKeyName(keyName, baseName, SelName, Selvalue);
    if SelName <> '' then begin
        Result := GetVarBySelection(baseName, SelName, Selvalue);
        exit;
    end;
>>>>>>> 567489eb579fa25cb906471546da671d36020444

    for i1 := 0 to VarCount - 1 do begin
        if ansiuppercase(webvars[i1].Name) <> ansiuppercase(keyName) then
            continue;
<<<<<<< HEAD
        if webvars[i1].changed > 0 then
            result := webvars[i1];
=======
        result := webvars[i1];
>>>>>>> 567489eb579fa25cb906471546da671d36020444
        exit;
    end;

end;

<<<<<<< HEAD
function ProcessRequest(URI: string): AnsiString;
var
    stmp, jreq, resp, keyName, keyVal, str1: ansistring;
    i1, amppos, pos_var_name: integer;
    json: tjsonobject;
begin

    if (pos('callback=', URI) <> 0) then begin
        stmp := copy(URI, pos('callback=', URI) + 9, length(URI));
        amppos := pos('get_member', stmp);
        if amppos > 0 then
            jreq := copy(stmp, 1, amppos - 2);
    end;
    resp := HardRec.JSONAll;

    pos_var_name := pos('GET_', ansiuppercase(URI)) + 4;
    if pos_var_name > 4 then begin
        keyName := system.copy(URI, pos_var_name, Length(URI));
        if pos('&', keyName) > 0 then
            keyName := system.Copy(URI, 1, pos('&', keyName) - 1);
        resp := '('+IntToStr(GetWebVar(keyName).changed)+')'+GetWebVar(keyName).jSONSTR;
    end;

    pos_var_name := pos('DEL_', ansiuppercase(URI)) + 4;
    if pos_var_name > 4 then begin
        keyName := system.copy(URI, pos_var_name, Length(URI));
        if pos('&', keyName) > 0 then
            keyName := system.Copy(URI, 1, pos('&', keyName) - 1);
        resp := RemoveWebVar(keyName);
    end;

    pos_var_name := pos('SET_', ansiuppercase(URI)) + 4;
    if pos_var_name > 5 then begin
        resp := '{"status":"ok"}';
        i1 := pos('=', URI);
        if i1 > 5 then begin
            keyName := copy(URI, pos_var_name, i1 - pos_var_name);
            str1 := copy(URI, i1 + 1, Length(URI));
            if str1 = '' then begin
                resp := RemoveWebVar(keyName);
            end
            else begin
                while (str1[length(str1)] <> '}') and (length(str1) > 2) do
                    system.delete(str1, length(str1), 1);
                json := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(str1), 0) as TJSONObject;
                if json <> nil then
                    AddWebVar(keyName, str1, json)
                else
                    resp := '{"status":"errformat"}';

            end;
        end;
    end;
    resp := jreq + '(' + resp + ');';
    result := resp;
end;

=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
function TTCPHttpThrd.ProcessHttpRequest(Request, URI: string): Integer;
var
    l: TStringList;
    str1, str2, resp: ansistring;
    pos_var_name: integer;
    str3: string;
    stmp, jreq: string;
    amppos: Integer;
    json, json1: tjsonobject;
    i1, i2, i3: integer;
    keyname: ansistring;
    keyval: ansistring;
    I: Integer;
    MyRequest: string;
    jSONSTR: string;
begin
  // sample of precessing HTTP request:
  // InputData is uploaded document, headers is stringlist with request headers.
  // Request is type of request and URI is URI of request
  // OutputData is document with reply, headers is stringlist with reply headers.
  // Result is result code
<<<<<<< HEAD
//    WritetimeLog(URI);
=======
>>>>>>> 567489eb579fa25cb906471546da671d36020444
    result := 504;
    if Request = 'GET' then begin
        Headers.Clear;
        Headers.add('Content-type: Text/Html');
        l := TStringList.Create;
        try
<<<<<<< HEAD
            resp := ProcessRequest(URI);
            resp := jreq + resp;
=======
            if (pos('callback=', URI) <> 0) then begin
                stmp := copy(URI, pos('callback=', URI) + 9, length(URI));
                amppos := pos('get_member', stmp);
                if amppos > 0 then
                    jreq := copy(stmp, 1, amppos - 2);
            end;
            resp := HardRec.JSONAll;

            i1 := pos('&', URI);
            if i1 <= 0 then
                i1 := length(URI) + 1;
            MyRequest := System.Copy(URI, 2, i1 - 2);
            if pos('GET_', MyRequest) <> 0 then begin
                resp := GetWebVar(system.copy(MyRequest, 5, Length(MyRequest))).jSONSTR;
            end;
            pos_var_name := pos('SET_', ansiuppercase(URI)) + 4;
            if pos_var_name > 5 then begin
                resp := '{"status":"ok"}';
                i1 := pos('=', URI);
                if i1 > 5 then begin
                    keyname := copy(URI, pos_var_name, i1 - pos_var_name);
                    str1 := copy(URI, i1 + 1, Length(URI));
                    while (str1[length(str1)] <> '}') and (length(str1) > 1) do
                        system.delete(str1, length(str1), 1);
                    json := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(str1), 0) as TJSONObject;
                    if json <> nil then
                        AddWebVar(keyname, str1, json)
                    else
                        resp := '{"status":"errformat"}';
                end;
            end;

            resp := jreq + '(' + resp + ');';
>>>>>>> 567489eb579fa25cb906471546da671d36020444
            l.add(resp);
            l.SaveToStream(OutputData);
        finally
            l.free;
        end;
        result := 200;
    end;
end;

<<<<<<< HEAD
procedure THTTPSRVForm.terminate1Click(Sender: TObject);
begin
    halt;
end;

procedure THTTPSRVForm.Timer1Timer(Sender: TObject);
begin
//   TCPsrv.Handle;
=======
procedure THTTPSRVForm.SpeedButton1Click(Sender: TObject);
var
    jtype: string;
    jsonstr: string;
    i, id: Integer;
    r1, r2: double;
  // rl : tstringlist;
    offset, position, h, g: Integer;
    s: string;
    ff: tfilestream;
    r: array[0..255] of string;
    pointpos: Integer;
    resrecord: string;
    FullProgPath: PwideChar;
    str22: string;

    procedure SliceSeries(Chart: TChart; maxlen: Integer);
    var
        Ic: Integer;
    begin
        for Ic := 0 to Chart.SeriesCount - 1 do begin
            while Chart.Series[Ic].count > maxlen do
                Chart.Series[Ic].Delete(0);
        end;
    end;

var
    st: double;
begin
    caption := formatDateTime('dd/mm/yyyy HH:NN:SS', now) + formatDateTime(' Старт:dd/mm/yyyy HH:NN:SS', starttime);
    Timer1.Enabled := false;
    Application.ProcessMessages;
    while true do begin
        st := now;
        while (now - st) * 24 * 3600 * 1000 < 1 do begin
            sleep(1);
            Application.ProcessMessages;
        end;
        textfromjson := HardRec.JSONAll;
    // memo2.Lines.Clear;
    // memo2.Text:=textfromJson;
        PrevUpdates := HardRec.UpdateCounter;
        intsum := 0;
        intcount := 0;
        minint := 1000;
        maxint := 0;

    end;
    Timer1.Enabled := true;
end;

procedure THTTPSRVForm.terminate1Click(Sender: TObject);
begin
    halt;
>>>>>>> 567489eb579fa25cb906471546da671d36020444
end;

var
    jcount: Integer;
    str: string;

var
    ini: tinifile;

initialization
    shared := tsharedmem.Create('webredis tempore mutanur', sizeof(ThardRec) + 1000);

    HardRec := Pointer(Integer(shared.Buffer) + 100);

    if (HardRec.UpdateCounter <> 13131313) then begin
        fillchar(HardRec.JSONAll, 1000000, 0);
        HardRec.UpdateCounter := 13131313
    end;
    HardRec.UpdateCounter := 0;
    lastReq := now;
//    varNames := tstringlist.Create;
//    Varvalues:= tstringlist.Create;
<<<<<<< HEAD
    EmptyWebVar.Name := '';
    EmptyWebVar.baseName := '';
    EmptyWebVar.jsonStr := '';
    EmptyWebVar.changed := -1;
    EmptyWebVar.json := nil;
=======
      EmptyWebVar.Name := '';
      EmptyWebVar.baseName := '';
      EmptyWebVar.jsonStr := '';
      EmptyWebVar.changed := -1;
      EmptyWebVar.json := nil;
>>>>>>> 567489eb579fa25cb906471546da671d36020444

end.

