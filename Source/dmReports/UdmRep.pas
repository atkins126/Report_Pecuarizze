unit UdmRep;

interface

uses
  System.SysUtils, System.Classes, System.Json,
  vcl.Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin,
  System.Json.writers,System.JSON.Types, FireDAC.Phys.PGDef, FireDAC.Phys.PG,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef,System.IniFiles, FireDAC.FMXUI.Wait,FMX.Dialogs,
  FireDAC.Phys.IBBase,IdSSLOpenSSL,IdSMTP,IdMessage,IdText,IdExplicitTLSClientServerBase,
  IdAttachmentFile, FireDAC.Comp.BatchMove,System.Variants, FireDAC.Comp.BatchMove.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  System.Net.HttpClient,FMX.Types,System.Net.URLClient,
  System.Net.HttpClientComponent, FireDAC.ConsoleUI.Wait,FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  ppStrtch, ppMemo, ppPrnabl, ppClass, ppCtrls, ppDB, ppBands, ppCache,
  ppDesignLayer, ppParameter, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe,
  Vcl.Imaging.pngimage,ppVar;

type
  TdmReports = class(TDataModule)
    qryBalancete: TFDQuery;
    dsBalancete: TDataSource;
    ppRepBalancete: TppReport;
    ppDBalancete: TppDBPipeline;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppLine1: TppLine;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    qryBalancetecategoria: TWideStringField;
    qryBalancetecentrocusto: TWideStringField;
    qryBalancetecredito: TFMTBCDField;
    qryBalancetedebito: TFMTBCDField;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppShape1: TppShape;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel2: TppLabel;
    ppShape2: TppShape;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppShape4: TppShape;
    ppSummaryBand1: TppSummaryBand;
    ppShape5: TppShape;
    ppLabel6: TppLabel;
    ppDBCalcCredito: TppDBCalc;
    ppDBCalcDebito: TppDBCalc;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLblSaldoGlobal: TppLabel;
    ppShape3: TppShape;
    ppShape6: TppShape;
    TCliente: TFDQuery;
    TClienteid: TIntegerField;
    TClientenome: TWideStringField;
    TClienteemail: TWideStringField;
    TClientetelefone: TWideStringField;
    TClientetipo: TIntegerField;
    TClienteusuario: TWideStringField;
    TClientesenha: TWideStringField;
    TClientedataregistro: TSQLTimeStampField;
    TClientestatus: TIntegerField;
    TClienteidtecnico: TIntegerField;
    TClientenomepropriedade: TWideStringField;
    TClientecidade: TWideStringField;
    TClienteuf: TWideStringField;
    TClienteqtdeanimais: TIntegerField;
    TClientedatavalidadelicenca: TDateField;
    TClientecpf_cnpj: TWideStringField;
    TClienteareahectare: TBCDField;
    pplblCliente: TppLabel;
    ppLblPeriodo: TppLabel;
    qryExtrato: TFDQuery;
    dsExtrato: TDataSource;
    ppRepExtrato: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel7: TppLabel;
    ppLine3: TppLine;
    ppShape7: TppShape;
    ppShape8: TppShape;
    ppLblExtratoCliente: TppLabel;
    ppLblExtratoPeriodo: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppLine4: TppLine;
    ppSystemVariable3: TppSystemVariable;
    ppSystemVariable4: TppSystemVariable;
    ppSummaryBand2: TppSummaryBand;
    ppShape9: TppShape;
    ppDBCalc3: TppDBCalc;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppParameterList2: TppParameterList;
    ppDBExtrato: TppDBPipeline;
    qryExtratodatamovimentacao: TDateField;
    qryExtratoplanocontas: TWideStringField;
    qryExtratocredito: TFMTBCDField;
    qryExtratodebito: TFMTBCDField;
    qryExtratodescricao: TWideStringField;
    ppShape11: TppShape;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLabel9: TppLabel;
    ppDBText9: TppDBText;
    ppShape10: TppShape;
    ppDBCalc4: TppDBCalc;
    ppLine5: TppLine;
    ppImage2: TppImage;
    ppImage1: TppImage;
    procedure ppSummaryBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AbreQryBalancente(vIdCliente,vInicio,vFIM,Atividade,
     categoria,Natureza,CentroCusto,PlanoContas: string);
   procedure AbreQryExtrato(vIdCliente,vInicio,vFIM,Atividade,
     categoria,Natureza,CentroCusto,PlanoContas: string);
    procedure AbreCliente(vIdCliente:string);

    function GeraReport(obj: TJSONObject): TJSONObject;
  end;

var
  dmReports: TdmReports;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses UPrincipal;

{$R *.dfm}

{ TdmReports }

procedure TdmReports.AbreCliente(vIdCliente: string);
begin
 with TCliente,TCliente.SQL do
 begin
   Clear;
   Add('select * from cliente c where id=:id');
   ParamByName('id').AsInteger := strToInt(vIdCliente);
   Open;
 end;
end;

procedure TdmReports.AbreQryExtrato(vIdCliente,vInicio,vFIM,Atividade,
     categoria,Natureza,CentroCusto,PlanoContas:string);
begin
 AbreCliente(vIdCliente);
 with qryExtrato,qryExtrato.SQL do
 begin
   Clear;
   Add('select');
   Add('datamovimentacao,');
   Add('p.nome PlanoContas,');
   Add('case');
   Add('when n.tipo=1 then l.valor');
   Add('else');
   Add('0');
   Add('end Credito,');
   Add('case');
   Add('when n.tipo=2 then l.valor');
   Add('else');
   Add('0');
   Add('end Debito,');
   Add('descricao');
   Add('from lancamentosfinanceiros l');
   Add('join auxcategoriafinanceira a on a.id=l.idcategoriafinanceira');
   Add('join planodecontascliente p on p.id= l.idplanodecontas');
   Add('join auxnaturezaoperacao n on n.id=l.idnatureza');
   Add('where l.status=1');
   Add('and l.idcliente=:idcliente');
   Add('and l.datamovimentacao between '+vInicio.QuotedString+' and '+vFIM.QuotedString);
   if Atividade<>'-1' then
    Add('and p.idatividade='+Atividade);
   if categoria<>'-1' then
    Add('and l.idcategoriafinanceira='+categoria);
   if Natureza<>'-1' then
    Add('and n.id='+Natureza);
   if CentroCusto<>'-1' then
    Add('and l.idcentrocusto='+CentroCusto);
   if CentroCusto<>'-1' then
    Add('and p.id='+PlanoContas);
   ParamByName('idcliente').AsInteger := StrToInt(vIdCliente);
   qryBalancete.SQL.Text;
   Open;
 end;
end;


function TdmReports.GeraReport(obj: TJSONObject): TJSONObject;
var
 JsonToSend :TStringStream;
 vField,vFieldJS,vJsonString,vIdCliente,vReportName,
 vAtividade,vCategoria,vNatureza,vCentroCusto,vPlanoContas:string;
 LJSon      : TJSONArray;
 StrAux     : TStringWriter;
 txtJson    : TJsonTextWriter;
 vJoReport,vJoItemO  : TJSONObject;
 vJoItem    : TJSONArray;
 path,vDataIni,vDataFim :string;
begin
 vJsonString    := obj.ToString;
 vJoReport      := TJSONObject.ParseJSONValue(vJsonString) as TJSONObject;
 vJoItem        := vJoReport.GetValue('Report') as TJSONArray;
 vJoItemO       := vJoItem.Items[0] as TJSONObject;
 vReportName    := vJoItemO.GetValue('reportname').value;
 vIdCliente     := vJoItemO.GetValue('idcliente').value;
 vDataIni       := vJoItemO.GetValue('datainicio').value;
 vDataFim       := vJoItemO.GetValue('datafim').value;
 vAtividade     := vJoItemO.GetValue('idatividade').value;
 vCategoria     := vJoItemO.GetValue('idcategoriafinanceira').value;
 vNatureza      := vJoItemO.GetValue('idnatureza').value;
 vCentroCusto   := vJoItemO.GetValue('idcentrocusto').value;
 vPlanoContas   := vJoItemO.GetValue('idpanocontas').value;
 if vReportName='Balancete' then
 begin
   AbreQryBalancente(
    vIdCliente,
    FormatDateTime('mm/dd/yyyy',strToDate(vDataIni)),
    FormatDateTime('mm/dd/yyyy',strToDate(vDataFim)),
    vAtividade,
    vCategoria,
    vNatureza,
    vCentroCusto,
    vPlanoContas);
   path:=ExtractFilePath(Application.ExeName)+'Relatorios\Clientes';
   path := path+'\'+vIdCliente;
   if not qryBalancete.IsEmpty then
   begin
    frmPrincipal.vStateCode :=200;
    if not DirectoryExists(path) then
     ForceDirectories(path);
    if not DirectoryExists(path) then
     ForceDirectories(path);
    try
     pplblCliente.Text := TClientenomepropriedade.AsString+'  '+TClientecidade.AsString+'-'+TClienteuf.AsString;
     ppLblPeriodo.Text := 'Período: '+ vDataIni +' ate '+vDataFim;
     ppRepBalancete.ShowPrintDialog := false;
     ppRepBalancete.DeviceType := 'PDF';
     ppRepBalancete.TextFileName := path+'\Balancete.pdf';
     ppRepBalancete.Print;

     StrAux  := TStringWriter.Create;
     txtJson := TJsonTextWriter.Create(StrAux);
     txtJson.Formatting := TJsonFormatting.Indented;
     txtJson.WriteStartObject;
     txtJson.WritePropertyName('Mensagem');
     txtJson.WriteValue(path+'\Balancete.pdf');
     txtJson.WriteEndObject;
     Result := TJsonObject.ParseJSONValue(TEncoding.ASCII.GetBytes(StrAux.ToString),0)
     as TJSONObject;
     except
     on E : Exception do
       begin
        frmPrincipal.vStateCode :=500;
        StrAux  := TStringWriter.Create;
        txtJson := TJsonTextWriter.Create(StrAux);
        txtJson.Formatting := TJsonFormatting.Indented;
        txtJson.WriteStartObject;
        txtJson.WritePropertyName('Erro');
        txtJson.WriteValue('Erro ao gerar relatorio:'+e.Message);
        txtJson.WriteEndObject;
        Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(StrAux.ToString),0)as TJSONObject;
       end;
    end;
   end
   else
   begin
    frmPrincipal.vStateCode :=404;
    StrAux  := TStringWriter.Create;
    txtJson := TJsonTextWriter.Create(StrAux);
    txtJson.Formatting := TJsonFormatting.Indented;
    txtJson.WriteStartObject;
    txtJson.WritePropertyName('Erro');
    txtJson.WriteValue('Sem dados para gerar esse relatorio!');
    txtJson.WriteEndObject;
    Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(StrAux.ToString),0)as TJSONObject;
   end;
 end;//balancete
 if vReportName='Extrato' then
 begin
   AbreQryExtrato(
    vIdCliente,
    FormatDateTime('mm/dd/yyyy',strToDate(vDataIni)),
    FormatDateTime('mm/dd/yyyy',strToDate(vDataFim)),
    vAtividade,
    vCategoria,
    vNatureza,
    vCentroCusto,
    vPlanoContas);
   path:=ExtractFilePath(Application.ExeName)+'Relatorios\Clientes';
   path := path+'\'+vIdCliente;
   if not qryExtrato.IsEmpty then
   begin
    frmPrincipal.vStateCode :=200;
    if not DirectoryExists(path) then
     ForceDirectories(path);
    if not DirectoryExists(path) then
     ForceDirectories(path);
    try
     ppLblExtratoCliente.Text := TClientenomepropriedade.AsString+'  '+TClientecidade.AsString+'-'+TClienteuf.AsString;
     ppLblExtratoPeriodo.Text := 'Período: '+ vDataIni +' ate '+vDataFim;
     ppRepExtrato.ShowPrintDialog := false;
     ppRepExtrato.DeviceType := 'PDF';
     ppRepExtrato.TextFileName := path+'\Extrato.pdf';
     ppRepExtrato.Print;

     StrAux  := TStringWriter.Create;
     txtJson := TJsonTextWriter.Create(StrAux);
     txtJson.Formatting := TJsonFormatting.Indented;
     txtJson.WriteStartObject;
     txtJson.WritePropertyName('Mensagem');
     txtJson.WriteValue(path+'\Extrato.pdf');
     txtJson.WriteEndObject;
     Result := TJsonObject.ParseJSONValue(TEncoding.ASCII.GetBytes(StrAux.ToString),0)
     as TJSONObject;
     except
     on E : Exception do
       begin
        frmPrincipal.vStateCode :=500;
        StrAux  := TStringWriter.Create;
        txtJson := TJsonTextWriter.Create(StrAux);
        txtJson.Formatting := TJsonFormatting.Indented;
        txtJson.WriteStartObject;
        txtJson.WritePropertyName('Erro');
        txtJson.WriteValue('Erro ao gerar relatorio:'+e.Message);
        txtJson.WriteEndObject;
        Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(StrAux.ToString),0)as TJSONObject;
       end;
    end;
   end
   else
   begin
    frmPrincipal.vStateCode :=404;
    StrAux  := TStringWriter.Create;
    txtJson := TJsonTextWriter.Create(StrAux);
    txtJson.Formatting := TJsonFormatting.Indented;
    txtJson.WriteStartObject;
    txtJson.WritePropertyName('Erro');
    txtJson.WriteValue('Sem dados para gerar esse relatorio!');
    txtJson.WriteEndObject;
    Result := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(StrAux.ToString),0)as TJSONObject;
   end;
 end;//Extrato
end;

procedure TdmReports.AbreQryBalancente(vIdCliente,vInicio,vFIM,Atividade,
     categoria,Natureza,CentroCusto,PlanoContas:string);
begin
 AbreCliente(vIdCliente);
 with qryBalancete,qryBalancete.SQL do
 begin
   Clear;
   Add('select');
   Add(' categoria,');
   Add(' CentroCusto,');
   Add(' coalesce(Credito,0)Credito,');
   Add(' coalesce(Debito,0)Debito');
   Add('from');
   Add('(select');
   Add(' c.id idCentro,');
   Add(' a.nome categoria,');
   Add(' c.nome CentroCusto');
   Add('from centrocusto c');
   Add('join auxcategoriafinanceira a on a.id=c.idcategoria');
   Add('order by c.nome)y');
   Add('join');
   Add('(select l.idcentrocusto,');
   Add('case');
   Add('   when n.tipo=1 then l.valor');
   Add('   else');
   Add('   0');
   Add(' end Credito,');
   Add(' case');
   Add('   when n.tipo=2 then l.valor');
   Add('   else');
   Add('    0');
   Add(' end Debito,');
   Add(' p.id idPlanoContas,');
   Add(' p.nome PlanodeContas');
   Add('from lancamentosfinanceiros l');
   Add('join planodecontascliente p on p.id= l.idplanodecontas');
   Add('join auxcategoriafinanceira a on a.id=l.idcategoriafinanceira');
   Add('join auxnaturezaoperacao n on n.id=l.idnatureza');
   Add('where l.status=1');
   Add('and l.idcliente=:idcliente');
   Add('and l.datamovimentacao between '+vInicio.QuotedString+' and '+vFIM.QuotedString);
   if Atividade<>'-1' then
    Add('and p.idatividade='+Atividade);
   if categoria<>'-1' then
    Add('and l.idcategoriafinanceira='+categoria);
   if Natureza<>'-1' then
    Add('and n.id='+Natureza);
   if CentroCusto<>'-1' then
    Add('and l.idcentrocusto='+CentroCusto);
   if CentroCusto<>'-1' then
    Add('and p.id='+PlanoContas);
   Add(')w');
   Add('on w.idcentrocusto=y.idCentro');
   ParamByName('idcliente').AsInteger   := StrToInt(vIdCliente);
   qryBalancete.SQL.Text;
   Open;
 end;
end;

procedure TdmReports.ppSummaryBand1BeforePrint(Sender: TObject);
var
 vCredito,vDebito,vSaldo:Double;
begin
  vCredito :=strToFloat(
    StringReplace(
     StringReplace(
      ppDBCalcCredito.Text,'R$','',[rfReplaceAll]),'.','',[rfReplaceAll]));

  vDebito  :=strToFloat(
   StringReplace(
    StringReplace(ppDBCalcDebito.Text,'R$','',[rfReplaceAll]),'.','',[rfReplaceAll]));

  vSaldo   := vCredito-vDebito;
  ppLblSaldoGlobal.Text :='Saldo '+FormatFloat('R$####,##0.00',vSaldo);
end;

end.
