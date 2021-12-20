unit UdmRep;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, ppDB, ppDBPipe, ppComm,
  ppRelatv, ppProd, ppClass, ppReport, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, ppCtrls, Vcl.Imaging.pngimage, ppPrnabl, ppBands,
  ppCache, ppDesignLayer, ppParameter, ppVar;

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
    ppImage1: TppImage;
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
    ppDBCalc3: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
  private
    { Private declarations }
  public
    procedure AbreQryBalancente(vIdCliente,
     vInicio,vFim,Atividade,categoria,Natureza,CentroCusto:string);
  end;

var
  dmReports: TdmReports;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses UPrincipal;

{$R *.dfm}

{ TdmReports }

procedure TdmReports.AbreQryBalancente(vIdCliente,
 vInicio,vFim,Atividade,categoria,Natureza,CentroCusto: string);
begin
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
   Add('left join');
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
   Add('and l.datamovimentacao between :dataIni and :dataFim');
   if Atividade <>'0' then
    Add('and p.idatividade='+Atividade);
   if categoria <>'0' then
    Add('and c.idcategoria='+Atividade);
   if Natureza <>'0' then
    Add('and n.id='+Natureza);
   if CentroCusto <>'0' then
    Add('and l.idcentrocusto='+CentroCusto);
   Add(')w');
   Add('on w.idcentrocusto=y.idCentro');
   ParamByName('dataIni').AsDate      := StrToDate(vInicio);
   ParamByName('dataFim').AsDate      := StrToDate(vFIM);
   ParamByName('idcliente').AsInteger := StrToInt(vIdCliente);
   qryBalancete.SQL.Text;
   Open;
   ppRepBalancete.Print;
 end;
end;

end.
