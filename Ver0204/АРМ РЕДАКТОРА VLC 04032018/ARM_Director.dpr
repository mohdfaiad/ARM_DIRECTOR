program ARM_Director;
{$M 163840,16000000}
{$DEFINE ARM_DIRECTOR}

uses
  Forms,
  UMain in 'UMain.pas' {Form1},
  UCommon in 'UCommon.pas',
  UGrid in 'UGrid.pas',
  UProject in 'UProject.pas' {FNewProject},
  UIMGButtons in 'UIMGButtons.pas',
  UPlayLists in 'UPlayLists.pas' {FPlayLists},
  UDelGridRow in 'UDelGridRow.pas' {FDelGridRow},
  UTimeline in 'UTimeline.pas' {FEditTimeline},
  UButtonOptions in 'UButtonOptions.pas' {FButtonOptions},
  UDrawTimelines in 'UDrawTimelines.pas',
  UInitForms in 'UInitForms.pas',
  UImportFiles in 'UImportFiles.pas' {FImportFiles},
  UActPlayList in 'UActPlayList.pas',
  UGRTimelines in 'UGRTimelines.pas',
  UMyEvents in 'UMyEvents.pas',
  UHRTimer in 'UHRTimer.pas',
  UWaiting in 'UWaiting.pas' {FWaiting},
  UMyFiles in 'UMyFiles.pas',
  UTextTemplate in 'UTextTemplate.pas' {FTextTemplate},
  UMyMessage in 'UMyMessage.pas' {FMyMessage},
  UMyTextTemplate in 'UMyTextTemplate.pas' {frMyTextTemplate},
  UImageTemplate in 'UImageTemplate.pas' {FGRTemplate},
  UAirDraw in 'UAirDraw.pas',
  USubtitrs in 'USubtitrs.pas',
  USetTemplate in 'USetTemplate.pas' {FrSetTemplate},
  UMyLists in 'UMyLists.pas',
  USetEventData in 'USetEventData.pas' {frSetEventData},
  UGridSort in 'UGridSort.pas' {FrSortGrid},
  uLkJSON in 'uLkJSON.pas',
  UMyMediaSwitcher in 'UMyMediaSwitcher.pas',
  ushifttl in 'ushifttl.pas' {frShiftTL},
  UShortNum in 'UShortNum.pas' {frShortNum},
  UMyIniFile in 'UMyIniFile.pas',
  UEvSwapBuffer in 'UEvSwapBuffer.pas',
  ULock in 'ULock.pas' {frLock},
  UMyUNDO in 'UMyUNDO.pas',
  UMediaCopy in 'UMediaCopy.pas' {frMediaCopy},
  UPageSetup in 'UPageSetup.pas' {FPage},
  UMyPrint in 'UMyPrint.pas' {frMyPrint},
  MyData in 'MyData.pas',
  UListUsers in 'UListUsers.pas',
  UPageDraw in 'UPageDraw.pas',
  UMyLTC in 'UMyLTC.pas' {frLTC},
  USetTC in 'USetTC.pas' {frSetTC},
  UMyNewList in 'UMyNewList.pas' {frNewList},
  USetProcent in 'USetProcent.pas' {frSetProcent},
  UMyMenu in 'UMyMenu.pas',
  UFrSaveProject in 'UFrSaveProject.pas' {FrSaveProject},
  UfrHotKeys in 'UfrHotKeys.pas' {frHotKeys},
  UHotKeys in 'UHotKeys.pas',
  UMyOptions in 'UMyOptions.pas' {FrMyOptions},
  UfrProtocols in 'UfrProtocols.pas' {FrProtocols},
  UfrListErrors in 'UfrListErrors.pas' {FrListErrors},
  UMyTextTable in 'UMyTextTable.pas',
  UMyProtocols in 'UMyProtocols.pas',
  redis_common in '..\helpers\redis_common.pas',
  synaip in '..\helpers\synaip.pas',
  udevman_options in '..\helpers\udevman_options.pas',
  udevmanagers in '..\helpers\udevmanagers.pas',
  UPlayer in '..\helpers\UPlayer.pas',
  uwebget in '..\helpers\uwebget.pas',
  vlcpl in '..\helpers\vlcpl.pas',
  Web.Win.Sockets in '..\helpers\Web.Win.Sockets.pas',
  uwebredis_common in '..\helpers\uwebredis_common.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFNewProject, FNewProject);
  Application.CreateForm(TFPlayLists, FPlayLists);
  Application.CreateForm(TFDelGridRow, FDelGridRow);
  Application.CreateForm(TFEditTimeline, FEditTimeline);
  Application.CreateForm(TFButtonOptions, FButtonOptions);
  Application.CreateForm(TFImportFiles, FImportFiles);
  Application.CreateForm(TfrMyTextTemplate, frMyTextTemplate);
  Application.CreateForm(TFTextTemplate, FTextTemplate);
  Application.CreateForm(TFrProtocols, FrProtocols);
  Application.CreateForm(TFMyMessage, FMyMessage);
  Application.CreateForm(TFGRTemplate, FGRTemplate);
  Application.CreateForm(TFrSetTemplate, FrSetTemplate);
  Application.CreateForm(TfrSetEventData, frSetEventData);
  Application.CreateForm(TFrSortGrid, FrSortGrid);
  Application.CreateForm(TFrSaveProject, FrSaveProject);
  Application.CreateForm(TfrHotKeys, frHotKeys);
  Application.CreateForm(TFrMyOptions, FrMyOptions);
  Application.CreateForm(TFrListErrors, FrListErrors);
  //Application.CreateForm(TfrMyTextTemplate, frMyTextTemplate);
  // Application.CreateForm(THTTPSRVForm, HTTPSRVForm);
  Application.CreateForm(TfrShiftTL, frShiftTL);
  Application.CreateForm(TfrShortNum, frShortNum);
  Application.CreateForm(TfrLock, frLock);
  Application.CreateForm(TfrMediaCopy, frMediaCopy);
  Application.CreateForm(TFPage, FPage);
  Application.CreateForm(TfrMyPrint, frMyPrint);
  Application.CreateForm(TfrLTC, frLTC);
  Application.CreateForm(TfrSetTC, frSetTC);
  //Application.CreateForm(TfrMyTextTemplate, frMyTextTemplate);
  Application.CreateForm(TfrNewList, frNewList);
  Application.CreateForm(TfrSetProcent, frSetProcent);
  Application.Run;

end.
