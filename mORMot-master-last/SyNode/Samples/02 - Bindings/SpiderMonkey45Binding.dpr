program SpiderMonkey45Binding;

uses
  FastMM4,
  Forms,
  ufrmSM45Demo in 'ufrmSM45Demo.pas' {frmSM45Demo},
  NSPRAPI in '..\..\NSPRAPI.pas',
  SpiderMonkey in '..\..\SpiderMonkey.pas',
  SyNode in '..\..\SyNode.pas',
  SyNodeBinding_fs in '..\..\SyNodeBinding_fs.pas',
  SyNodeBinding_HTTPClient in '..\..\SyNodeBinding_HTTPClient.pas',
  SyNodeProto in '..\..\SyNodeProto.pas',
  SyNodeRemoteDebugger in '..\..\SyNodeRemoteDebugger.pas',
  SyNodeSimpleProto in '..\..\SyNodeSimpleProto.pas',
  SyNodeBinding_worker in '..\..\SyNodeBinding_worker.pas',
  SyNodeBinding_const in '..\..\SyNodeBinding_const.pas',
  SyNodeBinding_buffer in '..\..\SyNodeBinding_buffer.pas',
  SyNodeBinding_util in '..\..\SyNodeBinding_util.pas',
  SyNodeBinding_uv in '..\..\SyNodeBinding_uv.pas',
  SyNodeReadWrite in '..\..\SyNodeReadWrite.pas';

{$R *.res}

begin
  InitJS;
  try
    Application.Initialize;
    Application.CreateForm(TfrmSM45Demo, frmSM45Demo);
    Application.Run;
  finally
    frmSM45Demo.Free;
    ShutDownJS;
  end;
end.
