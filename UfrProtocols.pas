unit UfrProtocols;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, utimeline, Math, FastDIB, FastFX, FastSize,
  FastFiles, FConvert, FastBlend, UmyProtocols, udevmanagers;

type

  TFrProtocols = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    imgButtons: TImage;
    ComboBox1: TComboBox;
    ComboBox3: TComboBox;
    imgAddParam: TImage;
    ComboBox4: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    imgDevice: TImage;
    imgPorts: TImage;
    GroupBox3: TGroupBox;
    imgMainParam: TImage;
    ComboBox2: TComboBox;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    Panel2: TPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgDeviceMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure imgButtonsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgButtonsMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure imgPortsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgPortsMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure imgMainParamMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure imgAddParamMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure imgDeviceMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ComboBox4Change(Sender: TObject);
    procedure imgMainParamMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox3Change(Sender: TObject);
    procedure imgAddParamMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgDeviceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgPortsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMainParamMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgAddParamMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    CRow : integer;
    OldStr, NewStr : string;
    countvisible : integer;
  public
    { Public declarations }
    function SaveDataProtocol: string;
    procedure LoadDataProtocol(StrSrc: string);
    procedure SetPanel2Visible;
  end;

var
  FrProtocols: TFrProtocols;
  ListTypeDevices: TListTypeDevices;
  indxven: Integer = -1;
  indxport: Integer = -1;
  indxprmain: Integer = -1;
  indxpradd: Integer = -1;

  STRVendors: string = '';
  STRManager: string = '0';




procedure SetProtocol(OPTTimeline: TTimelineOptions; ARow : integer);

implementation

uses umyfiles, ucommon, StrUtils, uinitforms, uimgbuttons, UMain;

{$R *.dfm}

procedure TFrProtocols.SetPanel2Visible;
begin
  if panel2.visible then exit;
  if not checkbox1.Checked then panel2.Visible := true;
  countvisible := 1;
end;

procedure DrawTableProtocols;
begin
  if ListTypeDevices.index = -1 then begin
  //  ListTypeDevices.index := 0;
    ListTypeDevices.DrawEmpty(FrProtocols.imgDevice.Canvas,
                              FrProtocols.ComboBox1.Height);
    ListTypeDevices.drawimgempty(FrProtocols.imgPorts.Canvas);
    ListTypeDevices.drawimgempty(FrProtocols.imgMainParam.Canvas);
    ListTypeDevices.drawimgempty(FrProtocols.imgAddParam.Canvas);
    STRManager := '';
    exit;
  end else begin
    ListTypeDevices.TypeDevices[ListTypeDevices.index]
      .Draw(FrProtocols.imgDevice.Canvas, FrProtocols.ComboBox1.Height);
  end;

  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    with Vendors[Index].FirmDevices[Vendors[Index].index] do
    begin
      ListProtocols[index].Ports.devicemanager := STRManager;
      ListProtocols[index].Ports.Draw(FrProtocols.imgPorts.Canvas,
        FrProtocols.ComboBox4.Height);
      ListProtocols[index].ProtocolMain.Draw(FrProtocols.imgMainParam.Canvas,
        FrProtocols.ComboBox3.Height);
      ListProtocols[index].ProtocolAdd.Draw(FrProtocols.imgAddParam.Canvas,
        FrProtocols.ComboBox2.Height);
    end;
  end;
end;

procedure updateportdata;
var lstdevmng : string;
    i, indx : Integer;
begin

  UpdateManagerList;

  lstdevmng := '';
  for i := 0 to 16 do begin
    if DevManagers[i]<>nil then begin
      if trim(lstdevmng)=''
        then lstdevmng := inttostr(i)
        else lstdevmng := lstdevmng + '|' + inttostr(i);
    end;
  end;

  if ListTypeDevices.index = -1 then exit;
  //  ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        ListProtocols[indx].Ports.ldevicemanager:=lstdevmng;
        ListProtocols[indx].Ports.devicemanager := trim(STRManager);
        if trim(STRManager)<>'' then begin
          if DevManagers[StrToInt(STRManager)]<>nil then begin
            ListProtocols[indx].Ports.Status := '��������';
            if trim(DevManagers[StrToInt(STRManager)].Options[2].Text)='RS232/422'
              then ListProtocols[indx].Ports.select422:=true
              else ListProtocols[indx].Ports.select422:=false;

            ListProtocols[indx].Ports.port422.ComPort:=
               DevManagers[StrToInt(STRManager)].Options[3].Text; //��� ���-�����
            ListProtocols[indx].Ports.port422.Speed:=
               DevManagers[StrToInt(STRManager)].Options[4].Text; //�������� ���-�����
            ListProtocols[indx].Ports.port422.Bits:=
               DevManagers[StrToInt(STRManager)].Options[5].Text; //���-�� ��� ���-�����
            ListProtocols[indx].Ports.port422.Parity:=
               DevManagers[StrToInt(STRManager)].Options[6].Text; //�������� ���-�����
            ListProtocols[indx].Ports.port422.Stop:=
               DevManagers[StrToInt(STRManager)].Options[7].Text; //���� ���� ���-�����
            ListProtocols[indx].Ports.port422.Flow:=
               DevManagers[StrToInt(STRManager)].Options[8].Text; //������. ������� ���-�����
            ListProtocols[indx].Ports.portip.IPAdress:=
               DevManagers[StrToInt(STRManager)].Options[9].Text; //IP Adress
            ListProtocols[indx].Ports.portip.IPPort:=
               DevManagers[StrToInt(STRManager)].Options[10].Text; //IP Port
            ListProtocols[indx].Ports.portip.Login:=
               DevManagers[StrToInt(STRManager)].Options[11].Text; //IP Login
            ListProtocols[indx].Ports.portip.Password:=
               DevManagers[StrToInt(STRManager)].Options[12].Text; //IP Password
          end else begin
            ListProtocols[indx].Ports.Status := '�� ���������';
          end;
        end;
      end;
    end;
  end;
end;

procedure SetProtocol(OPTTimeline: TTimelineOptions; ARow : integer);
var
  sprotocols: string;
  lst: tstrings;
  stypetl, lstdevmng : string;
  i, indx : Integer;
begin
  FrProtocols.CRow := ARow;
  //UpdateManagerList;
  if ListTypeDevices = nil then
    ListTypeDevices := TListTypeDevices.Create;
  InitFrProtocols;
  FrProtocols.ComboBox1.Visible := false;
  FrProtocols.ComboBox2.Visible := false;
  FrProtocols.ComboBox3.Visible := false;
  FrProtocols.ComboBox4.Visible := false;
  FrProtocols.Edit1.Visible := false;
  STRVendors := OPTTimeline.Protocol;
  STRManager := OPTTimeline.Manager;
     case OPTTimeline.TypeTL of
  tldevice : stypetl := 'TLDevices';
  tltext   : stypetl := 'TLText';
  tlmedia  : stypetl := 'TLMedia';
     end;
  ListTypeDevices.clear;
  ListTypeDevices.LoadFromFile('AListProtocols.txt', stypetl);
  if ListTypeDevices.Count<=0 then exit;
  FrProtocols.LoadDataProtocol(STRVendors);

  updateportdata;

  DrawTableProtocols;
  FrProtocols.imgDevice.Repaint;
  FrProtocols.imgPorts.Repaint;
  FrProtocols.imgMainParam.Repaint;
  FrProtocols.imgAddParam.Repaint;

  FrProtocols.CheckBox1.Checked := false;
  FrProtocols.Timer1.Enabled:=true;

  FrProtocols.ShowModal;
  if FrProtocols.ModalResult = mrOk then
  begin
    OPTTimeline.Protocol := STRVendors;
    OPTTimeline.Manager := STRManager;
    if ARow<>-1 then begin
      (Form1.GridTimeLines.Objects[0,ARow] as TTimelineOptions).Protocol:=STRVendors;
      (Form1.GridTimeLines.Objects[0,ARow] as TTimelineOptions).Manager:=STRManager;
      Put_TLO_ToServer(ARow);
      //PutGridTimeLinesToServer(Form1.GridTimeLines);
    end;
    if ListTypeDevices <> nil then
    begin
      ListTypeDevices.clear;
      ListTypeDevices.FreeInstance;
      ListTypeDevices := nil;
    end;
  end;
end;

procedure TFrProtocols.ComboBox1Change(Sender: TObject);
var
  indx, indx1, oldindx: Integer;
begin
  if ComboBox1.ItemIndex <> -1 then begin
    oldindx := ListTypeDevices.index;
    //ComboBox1.ItemIndex := 0;
         case indxven of
    0: begin
         ListTypeDevices.index := ComboBox1.ItemIndex-1;
         if (oldindx = -1) then begin
           if ListTypeDevices.index<>-1 then begin
             ListTypeDevices.TypeDevices[ListTypeDevices.index].index := 0;
             indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
             ListTypeDevices.TypeDevices[ListTypeDevices.index]
                .Vendors[indx].index := 0;
             indx1 := ListTypeDevices.TypeDevices[ListTypeDevices.index]
                .Vendors[indx].index;
             ListTypeDevices.TypeDevices[ListTypeDevices.index].Vendors[indx]
                .FirmDevices[indx1].index := 0;
           end;
         end;
       end;
    1: begin
         if ListTypeDevices.index = -1 then ListTypeDevices.index := 0;
         ListTypeDevices.TypeDevices[ListTypeDevices.index].index :=
            ComboBox1.ItemIndex;
       end;
    2:
      begin
        indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
        ListTypeDevices.TypeDevices[ListTypeDevices.index].Vendors[indx].index
          := ComboBox1.ItemIndex;
      end;
    3:
      begin
        indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
        indx1 := ListTypeDevices.TypeDevices[ListTypeDevices.index].Vendors
          [indx].index;
        ListTypeDevices.TypeDevices[ListTypeDevices.index].Vendors[indx]
          .FirmDevices[indx1].index := ComboBox1.ItemIndex;
      end;
         end; {case}
  end;
  DrawTableProtocols;
  FrProtocols.imgDevice.Repaint;
  FrProtocols.imgPorts.Repaint;
  FrProtocols.imgMainParam.Repaint;
  FrProtocols.imgAddParam.Repaint;
end;

procedure TFrProtocols.ComboBox2Change(Sender: TObject);
var
  indx: Integer;
begin
  if ListTypeDevices.index = -1 then
    ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          if indxpradd <> -1 then
          begin
            ProtocolAdd.List[indxpradd].Text := ComboBox2.Items.Strings
              [ComboBox2.ItemIndex];
          end;
          ProtocolAdd.Draw(imgAddParam.Canvas, ComboBox2.Height);
          imgAddParam.Repaint;
        end;
      end;
    end;
  end;
end;

procedure TFrProtocols.ComboBox3Change(Sender: TObject);
var
  indx: Integer;
begin
  if ListTypeDevices.index = -1 then
    ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          if indxprmain <> -1 then
          begin
            ProtocolMain.List[indxprmain].Text := ComboBox3.Items.Strings
              [ComboBox3.ItemIndex];
          end;
          // ComboBox3.Visible:=false;
          ProtocolMain.Draw(imgMainParam.Canvas, ComboBox3.Height);
          imgMainParam.Repaint;
        end;
      end;
    end;
  end;
end;

procedure TFrProtocols.ComboBox4Change(Sender: TObject);
var
  indx: Integer;
begin
  if ListTypeDevices.index = -1 then
    ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          case indxport of
            2:
              begin
                STRManager := ComboBox4.Items.Strings[ComboBox4.ItemIndex];
                //STRManager := trim(StringReplace(STRManager,'�� ���������', '', [rfReplaceAll, rfIgnoreCase]));
                //STRManager := trim(StringReplace(STRManager,'��������', '', [rfReplaceAll, rfIgnoreCase]));
                Ports.devicemanager := STRManager;

                if trim(STRManager)<>'' then begin
                  updateportdata;
//                  if DevManagers[strtoint(STRManager)]<>nil then begin
//                    Ports.devicemanager := Ports.devicemanager + ' ��������';
//                    if trim(DevManagers[StrToInt(STRManager)].Options[2].Text)='RS232/422'
//                     then Ports.select422:=true
//                     else Ports.select422:=false;
//                    Ports.port422.ComPort:=
//                      DevManagers[StrToInt(STRManager)].Options[3].Text; //��� ���-�����
//                    Ports.port422.Speed:=
//                       DevManagers[StrToInt(STRManager)].Options[4].Text; //�������� ���-�����
//                    Ports.port422.Bits:=
//                       DevManagers[StrToInt(STRManager)].Options[5].Text; //���-�� ��� ���-�����
//                    Ports.port422.Parity:=
//                       DevManagers[StrToInt(STRManager)].Options[6].Text; //�������� ���-�����
//                    Ports.port422.Stop:=
//                       DevManagers[StrToInt(STRManager)].Options[7].Text; //���� ���� ���-�����
//                    Ports.port422.Flow:=
//                       DevManagers[StrToInt(STRManager)].Options[8].Text; //������. ������� ���-�����
//                    Ports.portip.IPAdress:=
//                       DevManagers[StrToInt(STRManager)].Options[9].Text; //IP Adress
//                    Ports.portip.IPPort:=
//                       DevManagers[StrToInt(STRManager)].Options[10].Text; //IP Port
//                    Ports.portip.Login:=
//                       DevManagers[StrToInt(STRManager)].Options[11].Text; //IP Login
//                    Ports.portip.Password:=
//                       DevManagers[StrToInt(STRManager)].Options[12].Text; //IP Password
//                  end else begin
//                    Ports.devicemanager := Ports.devicemanager + ' �� ���������';
//                  end;
                end;
              end;
            10:
              Ports.port422.Speed := ComboBox4.Items.Strings
                [ComboBox4.ItemIndex];
            11:
              Ports.port422.Bits := ComboBox4.Items.Strings
                [ComboBox4.ItemIndex];
            12:
              Ports.port422.Parity := ComboBox4.Items.Strings
                [ComboBox4.ItemIndex];
            13:
              Ports.port422.Stop := ComboBox4.Items.Strings
                [ComboBox4.ItemIndex];
            14:
              Ports.port422.Flow := ComboBox4.Items.Strings
                [ComboBox4.ItemIndex];
          end;
          Ports.Draw(imgPorts.Canvas, ComboBox4.Height);
          imgPorts.Repaint;
        end;
      end;
    end;
  end;
end;

procedure TFrProtocols.Edit1Change(Sender: TObject);
var
  s: string;
  indx: Integer;
begin
  if ListTypeDevices.index = -1 then
    ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          s := trim(Edit1.Text);
          if length(s) > 15 then
            s := copy(s, 1, 15);
          Edit1.Text := s;
          case indxport of
            20:
              Ports.portip.IPAdress := shortipadress(Edit1.Text);
            21:
              Ports.portip.IPPort := Edit1.Text;
            22:
              Ports.portip.Login := Edit1.Text;
            23:
              Ports.portip.Password := Edit1.Text;
          end;
          Ports.Draw(imgPorts.Canvas, ComboBox4.Height);
          imgPorts.Repaint;
        end;
      end;
    end;
  end;
end;

procedure TFrProtocols.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (indxport = 20) or (indxport = 21) then
    if Key = 46 then
      Key := 0;
end;

procedure TFrProtocols.Edit1KeyPress(Sender: TObject; var Key: Char);
var
  s: string;
  i, p1, p2, p3: Integer;
begin
  case indxport of

    20:
      begin
        if not(Key in ['0' .. '9', #8]) then
        begin
          Key := #0;
          exit;
        end;
        s := Edit1.Text;
        p2 := Edit1.SelStart;
        Case Key of
          #8:
            begin
              if Edit1.SelLength = 0 then
              begin
                if (p2 <> 4) and (p2 <> 8) and (p2 <> 12) then
                begin
                  s[p2] := '0';
                  Edit1.Text := s;
                  Key := #0;
                  if p2 > 0 then
                    Edit1.SelStart := p2 - 1;
                end
                else
                begin
                  s[p2] := '.';
                  Edit1.Text := s;
                  Key := #0;
                  if p2 > 0 then
                    Edit1.SelStart := p2 - 1;
                end;
              end
              else
              begin
                for i := p2 + 1 to p2 + Edit1.SelLength do
                begin
                  if (i <> 4) and (i <> 8) and (i <> 12) then
                    s[i] := '0';
                end;
                Edit1.SelLength := 0;
                Edit1.Text := s;
                if (p2 = 3) or (p2 = 7) or (p2 = 12) then
                  Edit1.SelStart := p2 + 1;
                if p2 > 0 then
                  Key := s[p2 - 1];
              end;
            end;
          '0' .. '9':
            begin
              if (p2 = 3) or (p2 = 7) or (p2 = 11) then
                p2 := p2 + 1;
              if (p2 <> 3) and (p2 <> 7) and (p2 <> 11) then
              begin
                if p2 < 15 then
                  p2 := p2 + 1
                else
                  p2 := 16;
                // case p2 of
                // 1 : if strtoint(Key)>2 then Key:='2';
                // 2 : if s[1]='2' then if strtoint(Key)>3 then Key:='3';
                // 4 : if strtoint(Key)>5 then Key:='5';
                // 7 : if strtoint(Key)>5 then Key:='5';
                // 10: if strtoint(Key)>2 then Key:='2';
                // 11: if s[10]='2' then if strtoint(Key)>4 then Key:='4';
                // end;
                s[p2] := Key;
                Edit1.Text := s;
                Key := #0;
                if p2 <= 15 then
                begin
                  if (p2 = 3) or (p2 = 7) or (p2 = 11) then
                    Edit1.SelStart := p2 + 1
                  else
                    Edit1.SelStart := p2;
                end;
              end;
            end;
        End;
      end;
    21:
      begin
        if not(Key in ['0' .. '9', #8]) then
        begin
          Key := #0;
          exit;
        end;
      end;
  end;
end;

procedure TFrProtocols.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled:=false;
  if ListTypeDevices <> nil then
  begin
    ListTypeDevices.clear;
    // FreeMem(@ListTypeDevices);
    ListTypeDevices.FreeInstance;
    ListTypeDevices := nil;
  end;
end;

procedure TFrProtocols.FormCreate(Sender: TObject);
begin
  InitFrProtocols;
end;

procedure TFrProtocols.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case key of
  13 : begin
         Timer1.Enabled:=false;
         STRVendors := SaveDataProtocol;
         WriteLog('Protocol_'+STRManager, STRVendors);
         ListTypeDevices.SaveToFile('AListProtocols.txt', 'TLDevices');
         FrProtocols.ModalResult := mrOk;
       end;
  27 : begin
         Timer1.Enabled:=false;
         FrProtocols.ModalResult := mrCancel;
       end;
     end;
end;

procedure TFrProtocols.imgAddParamMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetPanel2Visible;
end;

procedure TFrProtocols.imgAddParamMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var indx: Integer;
begin


  if ComboBox1.Visible then
    ComboBox1.Visible := false;
  if ComboBox3.Visible then
    ComboBox3.Visible := false;
  if ComboBox4.Visible then
    ComboBox4.Visible := false;
  if ComboBox2.Visible then
    ComboBox2.Visible := false;
  if Edit1.Visible then
    Edit1.Visible := false;

  if not CheckBox1.Checked then exit;

  if ListTypeDevices.index = -1 then begin
    DrawTableProtocols;
    FrProtocols.imgDevice.Repaint;
    FrProtocols.imgPorts.Repaint;
    FrProtocols.imgMainParam.Repaint;
    FrProtocols.imgAddParam.Repaint;
    exit;
  end;
  //  ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          ProtocolAdd.MouseMove(imgAddParam.Canvas, X, Y);
          ProtocolMain.unselect;
          Ports.unselect;
          //ProtocolAdd.Draw(imgAddParam.Canvas, ComboBox2.Height);
          //imgAddParam.Repaint;
        end;
      end;
    end;
  end;
  ListTypeDevices.unselect;
  DrawTableProtocols;
  FrProtocols.imgDevice.Repaint;
  FrProtocols.imgPorts.Repaint;
  FrProtocols.imgMainParam.Repaint;
  FrProtocols.imgAddParam.Repaint;
end;

procedure TFrProtocols.imgAddParamMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var indx: Integer;
begin
  if not CheckBox1.Checked then exit;

  if ListTypeDevices.index = -1 then exit;
  //  ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          indxpradd := ProtocolAdd.ClickMouse(imgAddParam.Canvas, X, Y);
          if indxpradd <> -1 then
          begin
            ComboBox2.Visible := false;
            ComboBox2.Left := ProtocolAdd.List[indxpradd].rttxt.Left;
            ComboBox2.Top := imgAddParam.Top + ProtocolAdd.List[indxpradd]
              .rttxt.Top;
            ComboBox2.Width := ProtocolAdd.List[indxpradd].rttxt.Right -
              ProtocolAdd.List[indxpradd].rttxt.Left;
            ComboBox2.clear;
            GetListParam(ProtocolAdd.List[indxpradd].VarText, ComboBox2.Items);
            ComboBox2.ItemIndex := ComboBox2.Items.IndexOf
              (ProtocolAdd.List[indxpradd].Text);
            ComboBox2.Visible := true;
          end;
          ProtocolAdd.Draw(imgAddParam.Canvas, ComboBox2.Height);
          imgAddParam.Repaint;
        end;
      end;
    end;
  end;
end;

procedure TFrProtocols.imgButtonsMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  btnpnlpotocol.MouseMove(imgButtons.Canvas, X, Y);
end;

procedure TFrProtocols.LoadDataProtocol(StrSrc: string);
var
  indxt, indxv, indxd, indxp: Integer;
  strt, strv, strd, strp, psel, tmpstr: ansistring;
begin

  strt := GetProtocolsParam(StrSrc, 'TypeDevices');
  strv := GetProtocolsParam(StrSrc, 'Firms');
  strd := GetProtocolsParam(StrSrc, 'Device');
  strp := GetProtocolsParam(StrSrc, 'Protocol');
  psel := GetProtocolsParam(StrSrc, 'PortSelect');
  indxt := ListTypeDevices.IndexOf(strt);
  ListTypeDevices.index := indxt;
  if indxt = -1 then begin
    exit;
    indxt := 0;
  end;
  indxv := ListTypeDevices.TypeDevices[indxt].IndexOf(strv);
  if indxv = -1 then begin
    exit;
    indxv := 0;
  end;
  ListTypeDevices.TypeDevices[indxt].index := indxv;
  indxd := ListTypeDevices.TypeDevices[indxt].Vendors[indxv].IndexOf(strd);
  if indxd = -1 then indxd := 0;
  ListTypeDevices.TypeDevices[indxt].Vendors[indxv].index := indxd;
  indxp := ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
    .IndexOf(strp);
  if indxp = -1 then indxp := 0;
  ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd].
    index := indxp;

  strp := GetProtocolsStr(StrSrc, 'Port422');
//  if trim(strp) = '' then begin
//    strp := ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
//            .ListProtocols[indxp].Ports.port422.GetString;
//  end;

  if (ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
    .ListProtocols[indxp].Ports.exist422) and (trim(strp)<>'')
  then begin
    ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
      .ListProtocols[indxp].Ports.port422.SetString(StrSrc);
  end;


  strp := GetProtocolsStr(StrSrc, 'PortIP');
//  if trim(strp) = '' then begin
//    strp := ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
//            .ListProtocols[indxp].Ports.portip.GetString;
//  end;
  if ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
    .ListProtocols[indxp].Ports.existip and (trim(strp)<>'')
  then begin
    ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
      .ListProtocols[indxp].Ports.portip.SetString(StrSrc);
  end;

//  ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
//    .ListProtocols[indxp].Ports.SetString(StrSrc);
  if ansilowercase(psel) = 'ipadress' then
  begin
    ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
      .ListProtocols[indxp].Ports.select422 := false;
  end
  else
  begin
    ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
      .ListProtocols[indxp].Ports.select422 := true;
  end;

  ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
    .ListProtocols[indxp].Ports.devicemanager := STRManager;
  ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
    .ListProtocols[indxp].ProtocolMain.SetString(StrSrc);
  ListTypeDevices.TypeDevices[indxt].Vendors[indxv].FirmDevices[indxd]
    .ListProtocols[indxp].ProtocolAdd.SetString(StrSrc);
end;

function TFrProtocols.SaveDataProtocol: string;
var
  indx, indx1, indx2: Integer;
begin
  with ListTypeDevices do
  begin
    if index = -1 then begin
      result := '';
      exit;
    end;
    //  index := 0;
    result := '<TypeDevices=' + TypeDevices[Index].TypeDevice + '>';
    with TypeDevices[Index] do
    begin
      if index = -1 then
        index := 0;
      result := result + '<Firms=' + Vendors[index].Vendor + '>';
      with Vendors[index] do
      begin
        if index = -1 then
          index := 0;
        result := result + '<Device=' + FirmDevices[index].Device + '>';
        with FirmDevices[index] do
        begin
          if index = -1 then
            index := 0;
          result := result + '<Protocol=' + ListProtocols[index].Protocol + '>';
          if ListProtocols[index].Ports.select422 then
            result := result + '<PortSelect=RS422>'
          else
            result := result + '<PortSelect=IPAdress>';
          result := result + ListProtocols[index].Ports.GetString;
          result := result + ListProtocols[index].ProtocolMain.GetString;
          result := result + ListProtocols[index].ProtocolAdd.GetString;
        end;
      end;
    end;
  end;
end;

procedure TFrProtocols.Timer1Timer(Sender: TObject);
var indx : integer;
begin
  if CheckBox1.Checked then exit;
  if FrProtocols.ComboBox4.Visible then exit;
  if FrProtocols.Edit1.Visible then exit;
  if ListTypeDevices=nil then exit;

  if ListTypeDevices.index = -1 then begin
    if Panel2.Visible then begin
      countvisible := countvisible - 1;
      if countvisible <= 0 then Panel2.Visible := false;
    end;
    exit;
  end;
  //  ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          updateportdata;
          Ports.Draw(imgPorts.Canvas, ComboBox4.Height);
          imgPorts.Repaint;
        end;
      end;
    end;
  end;

  if Panel2.Visible then begin
    countvisible := countvisible - 1;
    if countvisible <= 0 then Panel2.Visible := false;
  end;

end;

procedure TFrProtocols.imgButtonsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  res: Integer;
  str: string;
begin
  res := btnpnlpotocol.ClickButton(imgButtons.Canvas, X, Y);
  case res of
    0: begin
         Timer1.Enabled:=false;
         FrProtocols.ModalResult := mrCancel;
       end;
    1:
      begin
        // STRVendors := Vendors.GetString + Ports.GetString
        // + ProtocolMain.GetString + ProtocolAdd.GetString;
        Timer1.Enabled:=false;
        STRVendors := SaveDataProtocol;
        WriteLog('Protocol_'+STRManager, STRVendors);

        ListTypeDevices.SaveToFile('AListProtocols.txt', 'TLDevices');
        FrProtocols.ModalResult := mrOk;
        // ssssjson
        //PutGridTimeLinesToServer(Form1.GridTimeLines);

      end;
  end;
end;

procedure TFrProtocols.imgDeviceMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetPanel2Visible;
end;

procedure TFrProtocols.imgDeviceMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var indx : integer;
begin
  if ComboBox3.Visible then
    ComboBox3.Visible := false;
  if ComboBox4.Visible then
    ComboBox4.Visible := false;
  if ComboBox1.Visible then
    ComboBox1.Visible := false;
  if ComboBox2.Visible then
    ComboBox2.Visible := false;
  if Edit1.Visible then
    Edit1.Visible := false;

  if not CheckBox1.Checked then exit;

  ListTypeDevices.MouseMove(imgDevice.Canvas, X, Y);

  if ListTypeDevices.index = -1 then begin
    DrawTableProtocols;
    FrProtocols.imgDevice.Repaint;
    FrProtocols.imgPorts.Repaint;
    FrProtocols.imgMainParam.Repaint;
    FrProtocols.imgAddParam.Repaint;
    exit;
  end;

//  if ListTypeDevices.index = -1 then begin
//    ListTypeDevices.index := 0;
//  end;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          ProtocolMain.unselect;
          ProtocolAdd.unselect;
          Ports.unselect;
        end;
      end;
    end;
  end;
  DrawTableProtocols;
  FrProtocols.imgDevice.Repaint;
  FrProtocols.imgPorts.Repaint;
  FrProtocols.imgMainParam.Repaint;
  FrProtocols.imgAddParam.Repaint;
end;

procedure TFrProtocols.imgDeviceMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i, res, indx, indx1: Integer;
  sprotocols: string;
  wdth, hght, ps : integer;
begin
  if not CheckBox1.Checked then exit;

  res := ListTypeDevices.ClickMouse(imgDevice.Canvas, X, Y, ComboBox1.Height);
  if res <> -1 then
  begin
    // sprotocols :=  ReadListProtocols;
    // sprotocols := GetProtocolsStr(sprotocols, 'TLDevices');
    case res of
      // 0 : Vendors.TypeDevice:=FrProtocols.ComboBox1.Items.Strings[FrProtocols.ComboBox1.ItemIndex];
      // 1 : Vendors.Vendor:=FrProtocols.ComboBox1.Items.Strings[FrProtocols.ComboBox1.ItemIndex];
      // 2 : Vendors.Device:=FrProtocols.ComboBox1.Items.Strings[FrProtocols.ComboBox1.ItemIndex];
      // 3 : Vendors.Protocol:=FrProtocols.ComboBox1.Items.Strings[FrProtocols.ComboBox1.ItemIndex];
      // end;
      // //SelectVendors('TLDevices',Vendors.TypeDevice,Vendors.Vendor,Vendors.Device,Vendors.Protocol);
      // case res of
      0:
        begin
          FrProtocols.ComboBox1.Visible := false;
          if ListTypeDevices.index = -1 then begin
            wdth := imgDevice.Canvas.ClipRect.Right - imgDevice.Canvas.ClipRect.Left;
            hght := imgDevice.Canvas.ClipRect.Bottom - imgDevice.Canvas.ClipRect.Top;
            ps := (wdth - 10) div 2;
            FrProtocols.ComboBox1.Left := ps + 10;
            FrProtocols.ComboBox1.Top := imgDevice.Top + 5;
            FrProtocols.ComboBox1.Width := wdth - ps - 15;
            //then ListTypeDevices.index := 0;
          end else begin
            FrProtocols.ComboBox1.Left := ListTypeDevices.TypeDevices
              [ListTypeDevices.index].rttd.Left;
            FrProtocols.ComboBox1.Top := imgDevice.Top +
              ListTypeDevices.TypeDevices[ListTypeDevices.index].rttd.Top;
            FrProtocols.ComboBox1.Width := ListTypeDevices.TypeDevices
              [ListTypeDevices.index].rttd.Right - ListTypeDevices.TypeDevices
              [ListTypeDevices.index].rttd.Left;
          end;
          FrProtocols.ComboBox1.clear;
          FrProtocols.ComboBox1.Items.Add('');
          for i := 0 to ListTypeDevices.Count - 1 do
            FrProtocols.ComboBox1.Items.Add(ListTypeDevices.TypeDevices[i]
              .TypeDevice);
          FrProtocols.ComboBox1.ItemIndex := ListTypeDevices.index+1;
          FrProtocols.ComboBox1.Visible := true;
          indxven := 0;
        end;
      1:
        begin
          with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
          begin
            if index = -1 then
              index := 0;
            FrProtocols.ComboBox1.Visible := false;
            FrProtocols.ComboBox1.Left := Vendors[index].rtv.Left;
            FrProtocols.ComboBox1.Top := imgDevice.Top + Vendors[index].rtv.Top;
            FrProtocols.ComboBox1.Width := Vendors[index].rtv.Right -
              Vendors[index].rtv.Left;
            FrProtocols.ComboBox1.clear;
            for i := 0 to Count - 1 do
              FrProtocols.ComboBox1.Items.Add(Vendors[i].Vendor);
            FrProtocols.ComboBox1.ItemIndex := Index;
            FrProtocols.ComboBox1.Visible := true;
            indxven := 1;
          end;
        end;
      2:
        begin
          indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
          with ListTypeDevices.TypeDevices[ListTypeDevices.index]
            .Vendors[indx] do
          begin
            // sprotocols := GetProtocolsStr(sprotocols, 'Firms='+trim(Vendors.Vendor));
            if index = -1 then
              index := 0;
            FrProtocols.ComboBox1.Visible := false;
            FrProtocols.ComboBox1.Left := FirmDevices[index].rtd.Left;
            FrProtocols.ComboBox1.Top := imgDevice.Top + FirmDevices
              [index].rtd.Top;
            FrProtocols.ComboBox1.Width := FirmDevices[index].rtd.Right -
              FirmDevices[index].rtd.Left;
            FrProtocols.ComboBox1.clear;
            for i := 0 to Count - 1 do
              FrProtocols.ComboBox1.Items.Add(FirmDevices[i].Device);
            FrProtocols.ComboBox1.ItemIndex := index;
            // GetProtocolsList(sprotocols, 'Device=',FrProtocols.ComboBox1.Items);
            // indx := FrProtocols.ComboBox1.Items.IndexOf(Vendors.Protocol);
            // if indx=-1
            // then FrProtocols.ComboBox1.ItemIndex:=0
            // else FrProtocols.ComboBox1.ItemIndex:=indx;
            FrProtocols.ComboBox1.Visible := true;
            indxven := 2;
          end;
        end;
      3:
        begin
          indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
          indx1 := ListTypeDevices.TypeDevices[ListTypeDevices.index].Vendors
            [indx].index;
          with ListTypeDevices.TypeDevices[ListTypeDevices.index].Vendors[indx]
            .FirmDevices[indx1] do
          begin
            if index = -1 then
              index := 0;
            // if trim(Vendors.Device)<>''
            // then sprotocols := GetProtocolsStr(sprotocols, 'Device='+trim(Vendors.Device));
            FrProtocols.ComboBox1.Visible := false;
            FrProtocols.ComboBox1.Left := ListProtocols[index].rtp.Left;
            FrProtocols.ComboBox1.Top := imgDevice.Top + ListProtocols
              [index].rtp.Top;
            FrProtocols.ComboBox1.Width := ListProtocols[index].rtp.Right -
              ListProtocols[index].rtp.Left;
            FrProtocols.ComboBox1.clear;
            // GetProtocolsList(sprotocols, 'Protocol=',FrProtocols.ComboBox1.Items);
            // indx := FrProtocols.ComboBox1.Items.IndexOf(Vendors.Protocol);
            // if indx=-1
            // then FrProtocols.ComboBox1.ItemIndex:=0
            // else FrProtocols.ComboBox1.ItemIndex:=indx;
            for i := 0 to Count - 1 do
              FrProtocols.ComboBox1.Items.Add(ListProtocols[i].Protocol);
            FrProtocols.ComboBox1.ItemIndex := index;
            FrProtocols.ComboBox1.Visible := true;
            indxven := 3;
          end;
        end;
    end;
  end
  else
  begin
    FrProtocols.ComboBox1.Visible := false;
    indxven := -1;
  end;
  DrawTableProtocols;
  FrProtocols.imgDevice.Repaint;
  FrProtocols.imgPorts.Repaint;
  FrProtocols.imgMainParam.Repaint;
  FrProtocols.imgAddParam.Repaint;
end;

procedure TFrProtocols.imgMainParamMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetPanel2Visible;
end;

procedure TFrProtocols.imgMainParamMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var indx: Integer;
begin
  if ComboBox1.Visible then
    ComboBox1.Visible := false;
  if ComboBox3.Visible then
    ComboBox3.Visible := false;
  if ComboBox4.Visible then
    ComboBox4.Visible := false;
  if ComboBox2.Visible then
    ComboBox2.Visible := false;
  if Edit1.Visible then
    Edit1.Visible := false;

  if not CheckBox1.Checked then exit;

  if ListTypeDevices.index = -1 then begin
    //ListTypeDevices.unselect;
    DrawTableProtocols;
    FrProtocols.imgDevice.Repaint;
    FrProtocols.imgPorts.Repaint;
    FrProtocols.imgMainParam.Repaint;
    FrProtocols.imgAddParam.Repaint;
    exit;
  end;
  //  ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          ProtocolMain.MouseMove(imgMainParam.Canvas, X, Y);
          ProtocolAdd.unselect;
          Ports.unselect;
          //ListTypeDevices.unselect;
          //ProtocolMain.Draw(imgMainParam.Canvas, ComboBox3.Height);
          //imgMainParam.Repaint;
        end;
      end;
    end;
  end;
  ListTypeDevices.unselect;
  DrawTableProtocols;
  FrProtocols.imgDevice.Repaint;
  FrProtocols.imgPorts.Repaint;
  FrProtocols.imgMainParam.Repaint;
  FrProtocols.imgAddParam.Repaint;
end;

procedure TFrProtocols.imgMainParamMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var indx: Integer;
begin
  if not CheckBox1.Checked then exit;

  if ListTypeDevices.index = -1 then exit;
  //  ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          indxprmain := ProtocolMain.ClickMouse(imgMainParam.Canvas, X, Y);
          if indxprmain <> -1 then
          begin
            ComboBox3.Visible := false;
            ComboBox3.Left := ProtocolMain.List[indxprmain].rttxt.Left;
            ComboBox3.Top := imgMainParam.Top + ProtocolMain.List[indxprmain]
              .rttxt.Top;
            ComboBox3.Width := ProtocolMain.List[indxprmain].rttxt.Right -
              ProtocolMain.List[indxprmain].rttxt.Left;
            ComboBox3.clear;
            GetListParam(ProtocolMain.List[indxprmain].VarText,
              ComboBox3.Items);
            ComboBox3.ItemIndex := ComboBox3.Items.IndexOf
              (ProtocolMain.List[indxprmain].Text);
            ComboBox3.Visible := true;
          end;
          ProtocolMain.Draw(imgMainParam.Canvas, ComboBox3.Height);
          imgMainParam.Repaint;
        end;
      end;
    end;
  end;
end;

procedure TFrProtocols.imgPortsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetPanel2Visible;
end;

procedure TFrProtocols.imgPortsMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var indx: Integer;
begin
  if ComboBox1.Visible then
    ComboBox1.Visible := false;
  if ComboBox4.Visible then
    ComboBox4.Visible := false;
  if ComboBox3.Visible then
    ComboBox3.Visible := false;
  if ComboBox2.Visible then
    ComboBox2.Visible := false;

  if not CheckBox1.Checked then begin
    if Edit1.Visible then Edit1.Visible := false;
    exit;
  end;

  if ListTypeDevices.index = -1 then begin
    DrawTableProtocols;
    FrProtocols.imgDevice.Repaint;
    FrProtocols.imgPorts.Repaint;
    FrProtocols.imgMainParam.Repaint;
    FrProtocols.imgAddParam.Repaint;
    exit;
  end;

  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          Ports.MouseMove(imgPorts.Canvas, X, Y);
          ProtocolAdd.unselect;
          ProtocolMain.unselect;
          //Ports.Draw(imgPorts.Canvas, ComboBox4.Height);
        end;
      end;
    end;
  end;
  ListTypeDevices.unselect;
  DrawTableProtocols;
  FrProtocols.imgDevice.Repaint;
  FrProtocols.imgPorts.Repaint;
  FrProtocols.imgMainParam.Repaint;
  FrProtocols.imgAddParam.Repaint;

//  imgPorts.Repaint;
  // if Edit1.Visible then Edit1.Visible := false;
end;

procedure TFrProtocols.imgPortsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  res, indx: Integer;
begin
  if not CheckBox1.Checked then exit;

  if ListTypeDevices.index = -1 then exit;
  //  ListTypeDevices.index := 0;
  with ListTypeDevices.TypeDevices[ListTypeDevices.index] do
  begin
    indx := ListTypeDevices.TypeDevices[ListTypeDevices.index].index;
    with Vendors[indx] do
    begin
      indx := Vendors[indx].index;
      with FirmDevices[indx] do
      begin
        indx := FirmDevices[indx].index;
        with ListProtocols[indx] do
        begin
          res := Ports.ClickMouse(imgPorts.Canvas, X, Y);
          case res of
            0:
              begin
                indxport := 0;
                Edit1.Visible := false;
                ComboBox4.Visible := false;
                Ports.select422 := true;
              end;
            1:
              begin
                indxport := 1;
                Edit1.Visible := false;
                ComboBox4.Visible := false;
                Ports.select422 := false;
              end;
            2:
              begin
                Edit1.Visible := false;
                ComboBox4.Visible := false;
                ComboBox4.Left := Ports.rtdm.Left;
                ComboBox4.Top := imgPorts.Top + Ports.rtdm.Top;
                ComboBox4.Width := Ports.rtdm.Right - Ports.rtdm.Left;
                indxport := 2;
                ComboBox4.Items.clear;
                GetListParam(Ports.ldevicemanager, ComboBox4.Items);
                ComboBox4.ItemIndex := ComboBox4.Items.IndexOf(STRManager);
                ComboBox4.Visible := true;
              end;
            10:
              begin
                Edit1.Visible := false;
                ComboBox4.Visible := false;
                ComboBox4.Left := Ports.port422.rtsp.Left;
                ComboBox4.Top := imgPorts.Top + Ports.port422.rtsp.Top;
                ComboBox4.Width := Ports.port422.rtsp.Right -
                  Ports.port422.rtsp.Left;
                indxport := 10;
                ComboBox4.Items.clear;
                GetListParam(Ports.port422.LSpeed, ComboBox4.Items);
                indx := ComboBox4.Items.IndexOf(Ports.port422.Speed);
                if indx = -1 then
                  ComboBox4.ItemIndex := 0
                else
                  ComboBox4.ItemIndex := indx;
                Ports.port422.Speed := ComboBox4.Items.Strings
                  [ComboBox4.ItemIndex];
                ComboBox4.Visible := true;
              end;
            11:
              begin
                Edit1.Visible := false;
                ComboBox4.Visible := false;
                ComboBox4.Left := Ports.port422.rtbt.Left;
                ComboBox4.Top := imgPorts.Top + Ports.port422.rtbt.Top;
                ComboBox4.Width := Ports.port422.rtbt.Right -
                  Ports.port422.rtbt.Left;
                indxport := 11;
                ComboBox4.Items.clear;
                GetListParam(Ports.port422.LBits, ComboBox4.Items);
                indx := ComboBox4.Items.IndexOf(Ports.port422.Bits);
                if indx = -1 then
                  ComboBox4.ItemIndex := 0
                else
                  ComboBox4.ItemIndex := indx;
                Ports.port422.Bits := ComboBox4.Items.Strings
                  [ComboBox4.ItemIndex];
                ComboBox4.Visible := true;
              end;
            12:
              begin
                Edit1.Visible := false;
                ComboBox4.Visible := false;
                ComboBox4.Left := Ports.port422.rtpr.Left;
                ComboBox4.Top := imgPorts.Top + Ports.port422.rtpr.Top;
                ComboBox4.Width := Ports.port422.rtpr.Right -
                  Ports.port422.rtpr.Left;
                indxport := 12;
                ComboBox4.Items.clear;
                GetListParam(Ports.port422.LParity, ComboBox4.Items);
                indx := ComboBox4.Items.IndexOf(Ports.port422.Parity);
                if indx = -1 then
                  ComboBox4.ItemIndex := 0
                else
                  ComboBox4.ItemIndex := indx;
                Ports.port422.Parity := ComboBox4.Items.Strings
                  [ComboBox4.ItemIndex];
                ComboBox4.Visible := true;
              end;
            13:
              begin
                Edit1.Visible := false;
                ComboBox4.Visible := false;
                ComboBox4.Left := Ports.port422.rtst.Left;
                ComboBox4.Top := imgPorts.Top + Ports.port422.rtst.Top;
                ComboBox4.Width := Ports.port422.rtst.Right -
                  Ports.port422.rtst.Left;
                indxport := 13;
                ComboBox4.Items.clear;
                GetListParam(Ports.port422.LStop, ComboBox4.Items);
                indx := ComboBox4.Items.IndexOf(Ports.port422.Stop);
                if indx = -1 then
                  ComboBox4.ItemIndex := 0
                else
                  ComboBox4.ItemIndex := indx;
                Ports.port422.Stop := ComboBox4.Items.Strings
                  [ComboBox4.ItemIndex];
                ComboBox4.Visible := true;
              end;
            14:
              begin
                Edit1.Visible := false;
                ComboBox4.Visible := false;
                ComboBox4.Left := Ports.port422.rtfl.Left;
                ComboBox4.Top := imgPorts.Top + Ports.port422.rtfl.Top;
                ComboBox4.Width := Ports.port422.rtfl.Right -
                  Ports.port422.rtfl.Left;
                indxport := 14;
                ComboBox4.Items.clear;
                GetListParam(Ports.port422.LFlow, ComboBox4.Items);
                indx := ComboBox4.Items.IndexOf(Ports.port422.Flow);
                if indx = -1 then
                  ComboBox4.ItemIndex := 0
                else
                  ComboBox4.ItemIndex := indx;
                Ports.port422.Flow := ComboBox4.Items.Strings
                  [ComboBox4.ItemIndex];
                ComboBox4.Visible := true;
              end;
            20:
              begin
                ComboBox4.Visible := false;
                Edit1.Visible := false;
                Edit1.Left := Ports.portip.rtip.Left;
                Edit1.Top := imgPorts.Top + Ports.portip.rtip.Top;
                Edit1.Width := Ports.portip.rtip.Right - Ports.portip.rtip.Left;
                Edit1.Height := Ports.portip.rtip.Bottom -
                  Ports.portip.rtip.Top;
                indxport := 20;
                Edit1.Text := WideIPAdress(Ports.portip.IPAdress);
                Edit1.Visible := true;
              end;
            21:
              begin
                ComboBox4.Visible := false;
                Edit1.Visible := false;
                Edit1.Left := Ports.portip.rtpr.Left;
                Edit1.Top := imgPorts.Top + Ports.portip.rtpr.Top;
                Edit1.Width := Ports.portip.rtpr.Right - Ports.portip.rtpr.Left;
                Edit1.Height := Ports.portip.rtpr.Bottom -
                  Ports.portip.rtpr.Top;
                indxport := 21;
                Edit1.Text := Ports.portip.IPPort;
                Edit1.Visible := true;
              end;
            22:
              begin
                ComboBox4.Visible := false;
                Edit1.Visible := false;
                Edit1.Left := Ports.portip.rtlg.Left;
                Edit1.Top := imgPorts.Top + Ports.portip.rtlg.Top;
                Edit1.Width := Ports.portip.rtlg.Right - Ports.portip.rtlg.Left;
                Edit1.Height := Ports.portip.rtlg.Bottom -
                  Ports.portip.rtlg.Top;
                indxport := 22;
                Edit1.Text := Ports.portip.Login;
                Edit1.Visible := true;
              end;
            23:
              begin
                ComboBox4.Visible := false;
                Edit1.Visible := false;
                Edit1.Left := Ports.portip.rtps.Left;
                Edit1.Top := imgPorts.Top + Ports.portip.rtps.Top;
                Edit1.Width := Ports.portip.rtps.Right - Ports.portip.rtps.Left;
                Edit1.Height := Ports.portip.rtps.Bottom -
                  Ports.portip.rtps.Top;
                indxport := 23;
                Edit1.Text := Ports.portip.Password;
                Edit1.Visible := true;
              end;
          end;

          Ports.Draw(imgPorts.Canvas, ComboBox4.Height);
          imgPorts.Repaint;
        end;
      end;
    end;
  end;
end;

end.
