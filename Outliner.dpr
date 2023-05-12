program Outliner;

uses
  Vcl.Forms,
  CollapsibleOutliner in 'CollapsibleOutliner.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
