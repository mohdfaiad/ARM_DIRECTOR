function TTLParametersJson.LoadFromJSONObject(json: tjsonObject): boolean;
var
  i1: integer;
  tmpjson: tjsonObject;
begin
  // BackGround : tcolor;        //������� ����
  BackGround := getVariableFromJson(json, 'BackGround', BackGround);

  // ForeGround : tcolor;        //���� ������ ����-�����
  ForeGround := getVariableFromJson(json, 'ForeGround', ForeGround);

  // MaxFrameSize : integer;     //������������ ������ ����� � ��������
  MaxFrameSize := getVariableFromJson(json, 'MaxFrameSize', MaxFrameSize);

  // FrameSize : integer;        //������� ������ �����
  FrameSize := getVariableFromJson(json, 'FrameSize', FrameSize);

  // Start  : longint;           //������� ������� ������ ��������������� (�����)
  Start := getVariableFromJson(json, 'Start', Start);

  // Finish : longint;           //������� ������� ����� ��������������� (�����)
  Finish := getVariableFromJson(json, 'Finish', Finish);

  // //NTK    : longint;           //��������� ���� ��� (�����)
  // ZeroPoint : longint;        //������� ����� ������� ��������� ����-��� (�����)
  ZeroPoint := getVariableFromJson(json, 'ZeroPoint', ZeroPoint);

  // vlcmode
  vlcmode := getVariableFromJson(json, 'vlcMode', vlcMode);
  command := getVariableFromJson(json, 'Command', Command);
  TLTimeCode := getVariableFromJson(json, 'TLTimeCode', TLTimeCode);

  // MyCursor : longint;         //��������� ������� ������������ ������ ������ (�������)
  MyCursor := getVariableFromJson(json, 'MyCursor', MyCursor);

  // ScreenStart : longint;      //������������� ������� ������ ������ (�������)
  ScreenStart := getVariableFromJson(json, 'ScreenStart', ScreenStart);
  // ScreenEnd   : longint;      //������������� ������� ����� ������ (������)
  ScreenEnd := getVariableFromJson(json, 'ScreenEnd', ScreenEnd);
  // Preroll   : longint;        //��������� ������ (�����)
  Preroll := getVariableFromJson(json, 'Preroll', Preroll);
  // Postroll  : longint;        //�������� ������ (�����)
  Postroll := getVariableFromJson(json, 'Postroll', Postroll);
  // Duration  : longint;        //����� ����������� ����� (�����)
  Duration := getVariableFromJson(json, 'Duration', Duration);
  // EndPoint  : longint;        //��������� ����� ����� Preroll+Duration (�����)
  EndPoint := getVariableFromJson(json, 'EndPoint', EndPoint);
  // lrTransperent0 : tcolor;    //���� ������������ ��� ���� 0
  lrTransperent0 := getVariableFromJson(json, 'lrTransperent0', lrTransperent0);
  // lrTransperent1 : tcolor;    //���� ������������ ��� ���� 1
  lrTransperent1 := getVariableFromJson(json, 'lrTransperent1', lrTransperent1);
  // lrTransperent2 : tcolor;    //���� ������������ ��� ���� 2
  lrTransperent2 := getVariableFromJson(json, 'lrTransperent2', lrTransperent2);
  // Position : longint;         //T������ ������� ����� (�����)
  Position := getVariableFromJson(json, 'Position', Position);
  // ScreenStartFrame : longint; //���������� ������� ������ ������ (�����)
  ScreenStartFrame := getVariableFromJson(json, 'ScreenStartFrame',
    ScreenStartFrame);
  // ScreenEndFrame : longint;   //���������� ������� ����� ������ (�����)
  ScreenEndFrame := getVariableFromJson(json, 'ScreenEndFrame', ScreenEndFrame);
  // StopPosition : longint;     //������� ��������� ���� (�����)
  StopPosition := getVariableFromJson(json, 'StopPosition', StopPosition);
  // Scaler : real;              //��������� ������ Bitmap � ������ ������
  Scaler := getVariableFromJson(json, 'Scaler', Scaler);
  TimeToStart := getVariableFromJson(json, 'TimeToStart', TimeToStart);

  Reload := getVariableFromJson(json, 'Reload', Reload);
  ClipName := getVariableFromJson(json, 'ClipName', ClipName);

end;

function TTLParametersJson.LoadFromJSONstr(JSONstr: string): boolean;
var
  json: tjsonObject;
begin
  json := tjsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSONstr), 0)
    as tjsonObject;
  result := true;
    if JSON = nil then
    begin
      result := false;
    end
    else begin
      LoadFromJSONObject(JSON);
      json.free;
    end;
end;

function TTLParametersJson.SaveToJSONObject: tjsonObject;
var
  str1: string;
  js1, json: tjsonObject;
  i1, i2: integer;
  jsondata: string;
  (*
    ** ���������� ���� ���������� � ������ JSONDATA � ������� JSON
  *)
begin
  json := tjsonObject.Create;
  try
    // BackGround : tcolor;        //������� ����
    addVariableToJson(json, 'BackGround', BackGround);
    // ForeGround : tcolor;        //���� ������ ����-�����
    addVariableToJson(json, 'ForeGround', ForeGround);
    // MaxFrameSize : integer;     //������������ ������ ����� � ��������
    addVariableToJson(json, 'MaxFrameSize', MaxFrameSize);
    // FrameSize : integer;        //������� ������ �����
    addVariableToJson(json, 'FrameSize', FrameSize);
    // Start  : longint;           //������� ������� ������ ��������������� (�����)
    addVariableToJson(json, 'Start', Start);
    // Finish : longint;           //������� ������� ����� ��������������� (�����)
    addVariableToJson(json, 'Finish', Finish);
    // //NTK    : longint;           //��������� ���� ��� (�����)
    // ZeroPoint : longint;        //������� ����� ������� ��������� ����-��� (�����)
    addVariableToJson(json, 'ZeroPoint', ZeroPoint);
    // vlcMode
    addVariableToJson(json, 'vlcMode', vlcMode);
    addVariableToJson(json, 'Command', Command);
    addVariableToJson(json, 'TLTimeCode', TLTimeCode);

    // MyCursor : longint;         //��������� ������� ������������ ������ ������ (�������)
    addVariableToJson(json, 'MyCursor', MyCursor);
    // ScreenStart : longint;      //������������� ������� ������ ������ (�������)
    addVariableToJson(json, 'ScreenStart', ScreenStart);
    // ScreenEnd   : longint;      //������������� ������� ����� ������ (������)
    addVariableToJson(json, 'ScreenEnd', ScreenEnd);
    // Preroll   : longint;        //��������� ������ (�����)
    addVariableToJson(json, 'Preroll', Preroll);
    // Postroll  : longint;        //�������� ������ (�����)
    addVariableToJson(json, 'Postroll', Postroll);
    // Duration  : longint;        //����� ����������� ����� (�����)
    addVariableToJson(json, 'Duration', Duration);
    // EndPoint  : longint;        //��������� ����� ����� Preroll+Duration (�����)
    addVariableToJson(json, 'EndPoint', EndPoint);
    // lrTransperent0 : tcolor;    //���� ������������ ��� ���� 0
    addVariableToJson(json, 'lrTransperent0', lrTransperent0);
    // lrTransperent1 : tcolor;    //���� ������������ ��� ���� 1
    addVariableToJson(json, 'lrTransperent1', lrTransperent1);
    // lrTransperent2 : tcolor;    //���� ������������ ��� ���� 2
    addVariableToJson(json, 'lrTransperent2', lrTransperent2);
    // Position : longint;         //T������ ������� ����� (�����)
    addVariableToJson(json, 'Position', Position);
    // ScreenStartFrame : longint; //���������� ������� ������ ������ (�����)
    addVariableToJson(json, 'ScreenStartFrame', ScreenStartFrame);
    // ScreenEndFrame : longint;   //���������� ������� ����� ������ (�����)
    addVariableToJson(json, 'ScreenEndFrame', ScreenEndFrame);
    // StopPosition : longint;     //������� ��������� ���� (�����)
    addVariableToJson(json, 'StopPosition', StopPosition);
    // Scaler : real;              //��������� ������ Bitmap � ������ ������

    addVariableToJson(json, 'Scaler', Scaler);
    addVariableToJson(json, 'TimeToStart', TimeToStart);
    addVariableToJson(json, 'Reload', Reload);
    addVariableToJson(json, 'ClipName', ClipName);

  except
    on E: Exception do
  end;
  result := json;

end;




function TTLParametersJson.SaveToJSONStr: string;
var
  jsontmp: tjsonObject;
  JSONstr: string;
begin
  jsontmp := SaveToJSONObject;
  JSONstr := jsontmp.ToString;
  result := JSONstr;jsontmp.free;

end;

{ TTLScalerJson }

function TTLScalerJson.LoadFromJSONObject(json: tjsonObject): boolean;
var
  i1: integer;
  tmpjson: tjsonObject;
begin
  // PenColor : tcolor;
  PenColor := getVariableFromJson(json, 'PenColor', PenColor);
  // FontColor : tcolor;
  FontColor := getVariableFromJson(json, 'FontColor', FontColor);

  // FontSize : integer;
  FontSize := getVariableFromJson(json, 'FontSize', FontSize);
  // FontName : tfontname;
  FontName := getVariableFromJson(json, 'FontName', FontName);
  // Rect   : TRect;
  Rect.LoadFromJSONObject(tjsonObject(json.getvalue('Rect')));
end;

function TTLScalerJson.LoadFromJSONstr(JSONstr: string): boolean;
var
  json: tjsonObject;
begin
  json := tjsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSONstr), 0)
    as tjsonObject;
  result := true;
    if JSON = nil then
    begin
      result := false;
    end
    else begin
      LoadFromJSONObject(JSON);
      json.free;
    end;
end;

function TTLScalerJson.SaveToJSONObject: tjsonObject;
var
  str1: string;
  js1, json: tjsonObject;
  i1, i2: integer;
  jsondata: string;
  (*
    ** ���������� ���� ���������� � ������ JSONDATA � ������� JSON
  *)
begin
  json := tjsonObject.Create;
  result := json;
  // PenColor : tcolor;
  addVariableToJson(json, 'PenColor', PenColor);

  // FontColor : tcolor;
  addVariableToJson(json, 'FontColor', FontColor);
  // FontSize : integer;
  addVariableToJson(json, 'FontSize', FontSize);

  // FontName : tfontname;
  addVariableToJson(json, 'FontName', FontName);

  // Rect   : TRect;
  json.AddPair('Rect', Rect.SaveToJSONObject);

end;

function TTLScalerJson.SaveToJSONStr: string;
var
  jsontmp: tjsonObject;
  JSONstr: string;
begin
  jsontmp := SaveToJSONObject;
  JSONstr := jsontmp.toString;
  result := JSONstr;jsontmp.free;
end;

{ TTLTimelineJSON }

function TTLTimelineJSON.LoadFromJSONObject(json: tjsonObject): boolean;
var
  i1: integer;
  tmpjson: tjsonObject;
begin
  // IDTimeline : longint;
  IDTimeline := getVariableFromJson(json, 'IDTimeline', IDTimeline);
  // TypeTL :  TTypeTimeline;
  TypeTL := getVariableFromJson(json, 'TypeTL', TypeTL);
  // Block : boolean;
  Block := getVariableFromJson(json, 'Block', Block);
  // Status : integer;
  Status := getVariableFromJson(json, 'Status', Status);
  // Rect : TRect;
  Rect.LoadFromJSONObject(tjsonObject(json.getvalue('Rect')));
  // Count : integer;
  Count := getVariableFromJson(json, 'Count', Count);
  // Events : Array of TMyEvent;
  setlength(Events, 0);
  setlength(Events, Count);
  for i1 := 0 to Count - 1 do
  begin
    tmpjson := tjsonObject(json.getvalue('Events' + inttostr(i1)));
    assert(tmpjson <> nil, 'Events ��� ��� ' + inttostr(i1));
    if tmpjson = nil then
      break;
    Events[i1] := TMyEvent.Create;
    Events[i1].LoadFromJSONObject(tmpjson);
  end;
end;

function TTLTimelineJSON.LoadFromJSONstr(JSONstr: string): boolean;
var
  json: tjsonObject;
begin
  json := tjsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSONstr), 0)
    as tjsonObject;
  result := true;
    if JSON = nil then
    begin
      result := false;
    end
    else begin
      LoadFromJSONObject(JSON);
      json.free;
    end;
end;

function TTLTimelineJSON.SaveToJSONObject: tjsonObject;
var
  str1: string;
  js1, json: tjsonObject;
  i1, i2: integer;
  jsondata: string;
  jsarr : tjsonarray;
  (*
    ** ���������� ���� ���������� � ������ JSONDATA � ������� JSON
  *)
begin
  json := tjsonObject.Create;
  result := json;

  // IDTimeline : longint;
  addVariableToJson(json, 'IDTimeline', IDTimeline);

  // TypeTL :  TTypeTimeline;
  addVariableToJson(json, 'TypeTL', TypeTL);

  // Block : boolean;
  addVariableToJson(json, 'Block', Block);

  // Status : integer;
  addVariableToJson(json, 'Status', Status);

  // Rect : TRect;
  json.AddPair('Rect', Rect.SaveToJSONObject);
  // Count : integer;
  addVariableToJson(json, 'Count', Count);

  // Events : Array of TMyEvent;
  jsarr := tjsonarray.create;
  for i1 := 0 to Count - 1 do begin
    json.AddPair('Events' + inttostr(i1), Events[i1].SaveToJSONObject);
    jsarr.add(Events[i1].SaveToJSONObject);
  end;
  json.AddPair('Events', jsarr);

end;



function TTLTimelineJSON.SaveToJSONStr: string;
var
  jsontmp: tjsonObject;
  JSONstr: string;
begin
  jsontmp := SaveToJSONObject;
  JSONstr := jsontmp.toString;
  result := JSONstr;jsontmp.free;
end;

{ TTLEditorJSON }

function TTLEditorJSON.LoadFromJSONObject(json: tjsonObject): boolean;
var
  i1: integer;
  tmpjson: tjsonObject;
begin
  // Index   : integer;
  Index := getVariableFromJson(json, 'Index', Index);
  // isZoneEditor : boolean;
  isZoneEditor := getVariableFromJson(json, 'isZoneEditor', isZoneEditor);
  // DoubleClick : boolean;
  DoubleClick := getVariableFromJson(json, 'DoubleClick', DoubleClick);
  // IDTimeline : longint;
  IDTimeline := getVariableFromJson(json, 'IDTimeline', IDTimeline);
  // Block : boolean;
  Block := getVariableFromJson(json, 'Block', Block);
  // Status : integer;
  Status := getVariableFromJson(json, 'Status', Status);
  // TypeTL :  TTypeTimeline;
  TypeTL := getVariableFromJson(json, 'TypeTL', TypeTL);
  // Rect       : TRect;
  Rect.LoadFromJSONObject(tjsonObject(json.getvalue('Rect')));
  // Count : integer;
  Count := getVariableFromJson(json, 'Count', Count);
  // Events : Array of TMyEvent;
  setlength(Events, 0);
  setlength(Events, Count);
  for i1 := 0 to Count - 1 do
  begin
    tmpjson := tjsonObject(json.getvalue('Events' + inttostr(i1)));
    assert(tmpjson <> nil, 'Events ��� ��� ' + inttostr(i1));
    if tmpjson = nil then
      break;
    Events[i1] := TMyEvent.Create;
    Events[i1].LoadFromJSONObject(tmpjson);
  end;

end;

function TTLEditorJSON.LoadFromJSONstr(JSONstr: string): boolean;
var
  json: tjsonObject;
begin
  json := tjsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSONstr), 0)
    as tjsonObject;
  result := true;
    if JSON = nil then
    begin
      result := false;
    end
    else begin
      LoadFromJSONObject(JSON);
      json.free;
    end;
end;

function TTLEditorJSON.SaveToJSONObject: tjsonObject;
var
  str1: string;
  js1, json: tjsonObject;
  i1, i2: integer;
  jsondata: string;
  (*
    ** ���������� ���� ���������� � ������ JSONDATA � ������� JSON
  *)
begin
  json := tjsonObject.Create;
  result := json;

  // Index   : integer;
  addVariableToJson(json, 'Index', Index);

  // isZoneEditor : boolean;
  addVariableToJson(json, 'isZoneEditor', isZoneEditor);

  // DoubleClick : boolean;
  addVariableToJson(json, 'DoubleClick', DoubleClick);

  // IDTimeline : longint;
  addVariableToJson(json, 'IDTimeline', IDTimeline);

  // Block : boolean;
  addVariableToJson(json, 'Block', Block);

  // Status : integer;
  addVariableToJson(json, '', Status);

  // TypeTL :  TTypeTimeline;
  addVariableToJson(json, 'TypeTL', TypeTL);

  // Rect       : TRect;

  json.AddPair('Rect', Rect.SaveToJSONObject);
  // Count : integer;
  addVariableToJson(json, 'Count', Count);

  // Events : Array of TMyEvent;
  for i1 := 0 to Count - 1 do
    json.AddPair('Events' + inttostr(i1), Events[i1].SaveToJSONObject);

end;

function TTLEditorJSON.SaveToJSONStr: string;
var
  jsontmp: tjsonObject;
  JSONstr: string;
begin
  jsontmp := SaveToJSONObject;
  JSONstr := jsontmp.toString;
  result := JSONstr;
end;

{ TTLZoneJSON }

function TTLZoneJSON.LoadFromJSONObject(json: tjsonObject): boolean;
var
  i1: integer;
  tmpjson: tjsonObject;
begin
  // XViewer : integer;
  XViewer := getVariableFromJson(json, 'XViewer', XViewer);
  // DownViewer : boolean;
  DownViewer := getVariableFromJson(json, 'DownViewer', DownViewer);
  // DownTimeline : boolean;
  DownTimeline := getVariableFromJson(json, 'DownTimeline', DownTimeline);
  // DownEditor : boolean;
  DownEditor := getVariableFromJson(json, 'DownEditor', DownEditor);
  // DownScaler : boolean;
  DownScaler := getVariableFromJson(json, 'DownScaler', DownScaler);
  // TLScaler : TTLScaler;
  TLScaler.LoadFromJSONObject(tjsonObject(json.getvalue('TLScaler')));
  // TLEditor : TTLEditor;
  TLEditor.LoadFromJSONObject(tjsonObject(json.getvalue('TLEditor')));
  // Count : integer;
  Count := getVariableFromJson(json, 'Count', Count);
  // Timelines : array of TTLTimeline;
  setlength(Timelines, 0);
  setlength(Timelines, Count);
  for i1 := 0 to Count - 1 do
  begin
    tmpjson := tjsonObject(json.getvalue('Timelines' + inttostr(i1)));
    assert(tmpjson <> nil, 'Timelines ��� ��� ' + inttostr(i1));
    if tmpjson = nil then
      break;
    Timelines[i1] := TTLTimeline.Create;
    Timelines[i1].LoadFromJSONObject(tmpjson);
  end;

end;

function TTLZoneJSON.LoadFromJSONstr(JSONstr: string): boolean;
var
  json: tjsonObject;
begin
  json := tjsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSONstr), 0)
    as tjsonObject;
  result := true;
    if JSON = nil then
    begin
      result := false;
    end
    else begin
      LoadFromJSONObject(JSON);
      json.free;
    end;
end;

function TTLZoneJSON.SaveToJSONObject: tjsonObject;
var
  str1: string;
  js1, json: tjsonObject;
  i1, i2: integer;
  jsondata: string;
  (*
    ** ���������� ���� ���������� � ������ JSONDATA � ������� JSON
  *)
begin
  json := tjsonObject.Create;
  result := json;

  // XViewer : integer;
  addVariableToJson(json, 'XViewer', XViewer);

  // DownViewer : boolean;
  addVariableToJson(json, 'DownViewer', DownViewer);

  // DownTimeline : boolean;
  addVariableToJson(json, 'DownTimeline', DownTimeline);

  // DownEditor : boolean;
  addVariableToJson(json, '', DownEditor);

  // DownScaler : boolean;
  addVariableToJson(json, 'DownScaler', DownScaler);

  // TLScaler : TTLScaler;
  json.AddPair('TLScaler', TLScaler.SaveToJSONObject);

  // TLEditor : TTLEditor;
  json.AddPair('TLEditor', TLEditor.SaveToJSONObject);

  // Count : integer;
  addVariableToJson(json, 'Count', Count);

  // Timelines : array of TTLTimeline;
  for i1 := 0 to Count - 1 do
    json.AddPair('Timelines' + inttostr(i1), Timelines[i1].SaveToJSONObject);

end;

function TTLZoneJSON.SaveToJSONStr: string;
var
  jsontmp: tjsonObject;
  JSONstr: string;
begin
  jsontmp := SaveToJSONObject;
  JSONstr := jsontmp.toString;
  result := JSONstr;jsontmp.free;
end;


