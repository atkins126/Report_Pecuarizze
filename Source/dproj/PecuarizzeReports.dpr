program PecuarizzeReports;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in '..\UPrincipal.pas' {frmPrincipal},
  UdmRep in '..\dmReports\UdmRep.pas' {dmReports: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmReports, dmReports);
  Application.Run;
end.
