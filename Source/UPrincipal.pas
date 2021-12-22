unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  Horse,
  Horse.Jhonson,
  System.JSON, Horse.HandleException,Winapi.Windows, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client,System.Json.writers,System.IniFiles,System.JSON.Types,
  IdBaseComponent, IdComponent, IdIPWatch, FMX.Memo.Types, FMX.Edit,
  FMX.ListBox, FMX.Layouts, FMX.DateTimeCtrls;

type
  TfrmPrincipal = class(TForm)
    Rectangle1: TRectangle;
    btnFechar: TImage;
    lblWS: TLabel;
    Rectangle2: TRectangle;
    Image1: TImage;
    mlog: TMemo;
    FDConPG: TFDConnection;
    PgDriverLink: TFDPhysPgDriverLink;
    IdIPWatch1: TIdIPWatch;
    layTesteMetodos: TLayout;
    Rectangle3: TRectangle;
    Layout1: TLayout;
    Label1: TLabel;
    cbxRelatorio: TComboBox;
    edtIdCliente: TEdit;
    btnGerar: TButton;
    Label2: TLabel;
    edtIni: TDateEdit;
    edtFim: TDateEdit;
    Label3: TLabel;
    edtNatureza: TEdit;
    edtcategoria: TEdit;
    edtAtividade: TEdit;
    edtCentroCusto: TEdit;
    edtIdPlanoContas: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
  public
    vStateCode:integer;
    function ConectaPG_LOCAL: TJSONObject;
    function LerIni(Diretorio,Chave1, Chave2, ValorPadrao: String): String;
    function GetVersaoArq: string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses UdmRep;

{ TForm1 }

procedure TfrmPrincipal.btnGerarClick(Sender: TObject);
begin
// if cbxRelatorio.ItemIndex=0 then
// begin
//  dmReports.AbreQryBalancente(
//   edtIdCliente.Text,
//   edtIni.Text,
//   edtFim.Text,
//   edtAtividade.Text,
//   edtcategoria.Text,
//   edtNatureza.Text,
//   edtCentroCusto.Text,
//   edtIdPlanoContas.Text);
// end;
// if cbxRelatorio.ItemIndex=1 then
// begin
//  dmReports.AbreQryExtrato(
//   edtIdCliente.Text,
//   edtIni.Text,
//   edtFim.Text,
//   edtAtividade.Text,
//   edtcategoria.Text,
//   edtNatureza.Text,
//   edtCentroCusto.Text,
//   edtIdPlanoContas.Text);
// end;
end;

function TfrmPrincipal.ConectaPG_LOCAL: TJSONObject;
var
 Arquivo,
 vVendorLib,
 dbUser,
 dbPassw,
 dbName,
 dbServer,
 dbPort,vRDS: String;
 StrAux     : TStringWriter;
 txtJson    : TJsonTextWriter;
begin
 StrAux  := TStringWriter.Create;
 txtJson := TJsonTextWriter.Create(StrAux);
 Arquivo := ExtractFilePath(ParamStr(0))+'pecuarizze.ini';
 if not FileExists(Arquivo) then
 begin
   txtJson.WriteStartObject;
   txtJson.WritePropertyName('Erro');
   txtJson.WriteValue('Arquivo pecuarizze.ini não localizado no seguinte diretorio:'+
   Arquivo);
   txtJson.WriteEndObject;
   Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(StrAux.ToString),0)as TJSONObject;
 end
 else
 begin
   vVendorLib := ExtractFilePath(ParamStr(0))+'libpq.dll';
   dbName     := LerIni(Arquivo,'LOCAL','Database','');
   dbServer   := LerIni(Arquivo,'LOCAL','Server','');
   vRDS       := LerIni(Arquivo,'LOCAL','RDS','');
   with FDConPG do
   begin
    Params.Clear;
    if vRDS='N' then
    begin
     Params.Values['DriverID']        := 'PG';
     Params.Values['User_name']       := 'postgres';
     Params.Values['Database']        := 'Pecuarizze';
     Params.Values['Password']        := 'Dev#110485';
     Params.Values['DriverName']      := 'PG';
     Params.Values['Server']          := '3.22.100.144';
     Params.Values['Port']            := '5432';
     PgDriverLink.VendorLib           := vVendorLib;
    end
    else
    begin
     Params.Values['DriverID']        := 'PG';
     Params.Values['User_name']       := 'postgres';
     Params.Values['Database']        := dbName;
     Params.Values['Password']        := 'Dev#110485';
     Params.Values['DriverName']      := 'PG';
     Params.Values['Server']          := 'solotecsolucoes.chhbmii57c8o.us-east-2.rds.amazonaws.com';
     Params.Values['Port']            := '5432';
     PgDriverLink.VendorLib           := vVendorLib;
    end;
   try
     Connected := true;
     txtJson.WriteStartObject;
     txtJson.WritePropertyName('Mensagem');
     txtJson.WriteValue('Conexao OK');
     txtJson.WriteEndObject;
     Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(StrAux.ToString),0)as TJSONObject;
    except
     on E: Exception do
     begin
      mlog.Lines.Add(E.Message);
      StrAux  := TStringWriter.Create;
      txtJson := TJsonTextWriter.Create(StrAux);
      txtJson.Formatting := TJsonFormatting.Indented;
      txtJson.WriteStartObject;
      txtJson.WritePropertyName('Erro');
      txtJson.WriteValue('Erro Ao Conectar DB Pedido:'+E.Message);
      txtJson.WriteEndObject;
      Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(StrAux.ToString),0)as TJSONObject;
     end;
    end;
  end;
 end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  ConectaPG_LOCAL;
  edtIni.Date := StrToDate('01/01/2021');
  THorse.Use(Jhonson);
  THorse.Use(HandleException);
  THorse.Get('/ping',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
  begin
    Res.Send('pong');
  end);
  THorse.Listen(8089, procedure(Horse: THorse)
  begin
    lblWS.Text := ('WS Report Pecuarizze Rodando no ip:'+IdIPWatch1.LocalIP+' na porta: ' + Horse.Port.ToString+' Versão:'+GetVersaoArq);
    Application.ProcessMessages;
  end);
  THorse.Post('/GeraReport',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LBody,LBodyRed: TJSONObject;
    begin
      mLog.Lines.Add(FormatDateTime('dd-mm-yyyy-hh:mm:ss',now)+' Lista Animais');
      LBody := Req.Body<TJSONObject>;
      try
       mLog.Lines.Add(FormatDateTime('dd-mm-yyyy-hh:mm:ss',now)+' Lendo :'+LBody.ToString);
       LBodyRed:= dmReports.GeraReport(LBody);
       mLog.Lines.Add(FormatDateTime('dd-mm-yyyy-hh:mm:ss',now)+' OK :'+LBodyRed.ToString);
       Res.Send(LBodyRed).Status(vStateCode)
       except on ex:exception do
       begin
        mLog.Lines.Add(FormatDateTime('dd-mm-yyyy-hh:mm:ss',now)+' Erro :'+ex.Message);
        Res.Send(tjsonobject.Create.AddPair('Mensagem', ex.Message)).Status(500);
       end;
      end;
    end);
end;

function TfrmPrincipal.GetVersaoArq: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(
  ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0,
  VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue),
  VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(
    dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(
    dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(
    dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

function TfrmPrincipal.LerIni(Diretorio, Chave1, Chave2, ValorPadrao: String): String;
var
 FileIni: TIniFile;
begin
  result := ValorPadrao;
  try
    FileIni := TIniFile.Create(Diretorio);
    if FileExists(Diretorio) then
      result := FileIni.ReadString(Chave1, Chave2, ValorPadrao);
  finally
    FreeAndNil(FileIni)
  end;
end;

end.
