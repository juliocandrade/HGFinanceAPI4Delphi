unit Finance;

interface

uses
  Finance.interfaces;

type
  TFinance = class(TInterfacedObject, iFinance)
    private
      FCurrencies : iFinanceCurrencies;
      FStocks : iFinanceStocks;
      FTaxes : iFinanceTaxes;
      FKey : string;

    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFinance;
      function Key (value : string) : iFinance;
      function Get : iFinance;
      function Currencies : iFinanceCurrencies;
      function Stocks : iFinanceStocks;
      function Taxes : iFinanceTaxes;
  end;

implementation

uses
  RESTRequest4D.Request,
  System.JSON,
  System.Generics.Collections,
  Finance.Currencies,
  Finance.Stocks,
  Finance.Taxes;

{ TFinance }

constructor TFinance.Create;
begin
  FCurrencies := TFinanceCurrencies.Create(Self);
  FStocks := TFinanceStocks.Create(Self);
  FTaxes := TFinanceTaxes.Create(Self);
end;

function TFinance.Currencies: iFinanceCurrencies;
begin
  Result := FCurrencies;
end;

destructor TFinance.Destroy;
begin

  inherited;
end;

function TFinance.Get: iFinance;
var
  Response : IResponse;
  JSONValue,
  JSONResult : TJSONObject;
begin
  Result := Self;
  Response := TRequest.New.BaseURL('https://api.hgbrasil.com/finance' + Fkey)
    .Accept('application/json')
    .Get;
  JsonValue := TJSONObject(Response.JSONValue);
  JsonResult := JsonValue.pairs[2].JsonValue as TJSONObject;
  FCurrencies.SetJSON(JsonResult.pairs[0].JsonValue as TJSONObject);
  FStocks.SetJSON(JsonResult.pairs[1].JsonValue as TJSONObject);
  FTaxes.SetJSON(JsonResult.pairs[4].JsonValue as TJSONArray)
end;

function TFinance.Key(value: string): iFinance;
begin
  Result := Self;
  FKey := '?key=' + value;
end;

class function TFinance.New: iFinance;
begin
  Result := Self.Create;
end;

function TFinance.Stocks: iFinanceStocks;
begin
  Result := FStocks;
end;

function TFinance.Taxes: iFinanceTaxes;
begin
  Result := FTaxes;
end;

end.
