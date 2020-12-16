unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.WebCharts, Vcl.StdCtrls,
  Vcl.OleCtrls, SHDocVw, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  RESTRequest4D.Request, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids,
  System.Json,
  Finance.Interfaces;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    WebBrowser1: TWebBrowser;
    Button1: TButton;
    WebCharts1: TWebCharts;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1Label: TStringField;
    ClientDataSet1Value: TStringField;
    ClientDataSet1RGB: TStringField;
    ClientDataSet2: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    function GerarCardStock(value : iFinanceStock) : string;
    function CSSPersonalizado: String;
    function GerarWebChartAlert(value : string) : string;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses
  Winapi.ActiveX, Charts.Types, Finance, System.SysUtils, DataSet.Serialize;

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
var
  Finance : IFinance;
begin
  Finance := TFinance.New.Key('7cd596af').Get;
  
  ClientDataSet1.EmptyDataSet;
  ClientDataSet1.AppendRecord([Finance.Currencies.GetUSD.Code, Finance.Currencies.GetUSD.Buy, '']);
  ClientDataSet1.AppendRecord([Finance.Currencies.GetEUR.Code, Finance.Currencies.GetEUR.Buy, '']);
  ClientDataSet1.AppendRecord([Finance.Currencies.GetGBP.Code, Finance.Currencies.GetGBP.Buy, '']);
  ClientDataSet1.AppendRecord([Finance.Currencies.GetAUD.Code, Finance.Currencies.GetAUD.Buy, '']);
  ClientDataSet1.AppendRecord([Finance.Currencies.GetARS.Code, Finance.Currencies.GetARS.Buy, '']);
  ClientDataSet1.AppendRecord([Finance.Currencies.GetCAD.Code, Finance.Currencies.GetCAD.Buy, '']);
  ClientDataSet1.AppendRecord([Finance.Currencies.GetJPY.Code, Finance.Currencies.GetJPY.Buy, '']);
  ClientDataSet1.AppendRecord([Finance.Currencies.GetCNY.Code, Finance.Currencies.GetCNY.Buy, '']);

  ClientDataSet2.EmptyDataSet;
  ClientDataSet2.AppendRecord([Finance.Currencies.GetUSD.Code, Finance.Currencies.GetUSD.Variation, '']);
  ClientDataSet2.AppendRecord([Finance.Currencies.GetEUR.Code, Finance.Currencies.GetEUR.Variation, '']);
  ClientDataSet2.AppendRecord([Finance.Currencies.GetGBP.Code, Finance.Currencies.GetGBP.Variation, '']);
  ClientDataSet2.AppendRecord([Finance.Currencies.GetAUD.Code, Finance.Currencies.GetAUD.Variation, '']);
  ClientDataSet2.AppendRecord([Finance.Currencies.GetAUD.Code, Finance.Currencies.GetAUD.Variation, '']);
  ClientDataSet2.AppendRecord([Finance.Currencies.GetARS.Code, Finance.Currencies.GetARS.Variation, '']);
  ClientDataSet2.AppendRecord([Finance.Currencies.GetCAD.Code, Finance.Currencies.GetCAD.Variation, '']);
  ClientDataSet2.AppendRecord([Finance.Currencies.GetJPY.Code, Finance.Currencies.GetJPY.Variation, '']);
  ClientDataSet2.AppendRecord([Finance.Currencies.GetCNY.Code, Finance.Currencies.GetCNY.Variation, '']);

   WebCharts1
    .BackgroundColor('#23272b')
    .FontColor('#8f9894')
    .AddResource(Self.CSSPersonalizado)
    .Container(Fluid)
    .NewProject
      .Rows
        .HTML('<div class="title"><h3>BOLSA DE VALORES</h3></div>')
      .&End
      .Rows
        ._Div
          .ColSpan(3)
          .Add(GerarCardStock(Finance.Stocks.GetIBOVESPA))
        .&End
        ._Div
          .ColSpan(3)
          .Add(GerarCardStock(Finance.Stocks.GetNASDAQ))
        .&End
        ._Div
          .ColSpan(3)
          .Add(GerarCardStock(Finance.Stocks.GetCAC))
        .&End
        ._Div
          .ColSpan(3)
          .Add(GerarCardStock(Finance.Stocks.GetNIKKEI))
        .&End
      .&End
      .Rows
        .HTML('<div class="title"><h3>CÂMBIO</h3></div>')
      .&End
      .Rows
        ._Div
          .ColSpan(6)
          .Add(
            WebCharts1
            .ContinuosProject
              .Charts
                ._ChartType(horizontalBar)
                  .Attributes
                    .Name('MoedasValores')
                    .ColSpan(12)
                    .DataSet
                      .textLabel('Meu DataSet 1')
                      .DataSet(ClientDataSet1)
                      .BackgroundColor('101,198,134')
                    .&End
                    .Labelling
                      .Format('$0,0.0000')
                      .PaddingX(30)
                      .Padding(-7)
                    .&End
                    .Options
                      .Title
                        .text('Cotação')
                        .fontSize(15)
                      .&End
                      .Tooltip
                        .Format('$0,0.0000')
                      .&End
                      .Legend
                        .display(false)
                      .&End
                    .&End
                  .&End
                .&End
              .&End
            .HTML
          )
        .&End
        ._Div
          .ColSpan(6)
          .Add(
            WebCharts1
            .ContinuosProject
              .Charts
                ._ChartType(Line)
                  .Attributes
                    .Name('MoedasVariacao')
                    .ColSpan(12)
                    .DataSet
                      .textLabel('Meu DataSet 1')
                      .DataSet(Clientdataset2)
                      .BackgroundColor('250,92,124')
                      .BorderColor('250,92,124')
                      .LineTension(0)
                    .&End
                    .Labelling
                      .Format('0,0.0000')
                    .&End
                    .Options
                      .Title
                        .text('Variação Diária')
                        .fontSize(15)
                      .&End
                      .Tooltip
                        .Format('0,0.0000')
                      .&End
                      .Legend
                        .display(false)
                      .&End
                    .&End
                  .&End
                .&End
              .&End
            .HTML
          )
        .&End
      .&End
      .Rows
        .HTML('<div class="title"><h3>ÍNDICES ECONÔMICOS</h3></div>')
      .&End
      .Rows
        ._Div
          .ColSpan(3)
          .Add(
            GerarWebChartAlert('SELIC ' + Finance.Taxes.GetSelic + ' %')
          )
        .&End
        ._Div
          .ColSpan(3)
          .Add(
            GerarWebChartAlert('CDI ' + Finance.Taxes.GetCdi + ' %')
          )
        .&End
        ._Div
          .ColSpan(3)
          .Add(
            GerarWebChartAlert('SELIC Diária' + Finance.Taxes.GetSelicDaily + ' %')
          )
        .&End
        ._Div
          .ColSpan(3)
          .Add(
            GerarWebChartAlert('CDI Diária ' + Finance.Taxes.GetCdiDaily + ' %')
          )
        .&End
      .&End
  .WebBrowser(WebBrowser1)
  .Generated;
end;


function TForm4.gerarCardStock(value: iFinanceStock): string;
var
  Variation : string;
begin

  if (value.Variation.IndexOf('-')) > -1 then
    Variation := '<i class="red"><i class="fa fa-angle-down"></i></i>'
  else
    Variation := '<i class="green"><i class="fa fa-angle-up"></i></i>';

  Result := '<div class="box primary"> ' +
               '<span class="count_top">' +
                  value.Code +
               '</span>' +
               '<div class="count" > ' + 
                  Variation + ' ' +  value.Variation + '%' + 
               '</div>' +
            '</div>';
end;

function TForm4.gerarWebChartAlert(value: string): string;
begin
  Result := WebCharts1
            .ContinuosProject
              .Alerts
                .Title(value)
                .AlertsClass
                  .success
                .&End
              .&End
            .HTML;
end;

function TForm4.CSSPersonalizado: String;
begin
  Result := Result + '<style>';
  Result := Result + '.title {padding-left: 0.75rem; padding-top: 0.75rem;}';
  Result := Result + '.box {';
  Result := Result + 'background-color: #FFFFFF;';
  Result := Result + 'border-radius: 2px;';
  Result := Result + 'width: 100%;';
  Result := Result + 'margin: auto;';
  Result := Result + 'padding: 0.75rem;';
  Result := Result + 'text-align: center;';
  Result := Result + '}';
  Result := Result + '.red {color : #fa5c7c;}';
  Result := Result + '.green {color : #0acf97;}';
  Result := Result + '.primary {';
  Result := Result + 'background-color: #5273E9;';
  Result := Result + 'color: #FFFFFF;';
  Result := Result + '}';
  Result := Result + '.count {';
  Result := Result + 'font-size: 20px;';
  Result := Result + '}';
  Result := Result + '</style>';
end;
procedure TForm4.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := true;
end;

end.
