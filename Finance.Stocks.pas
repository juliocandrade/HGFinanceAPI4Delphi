unit Finance.Stocks;

interface

uses
  Finance.interfaces,
  System.JSON,
  System.Generics.Collections;

type
  TFinanceStocks = class(TInterfacedObject, iFinanceStocks)
    private
      FParent : iFinance;
      FIBOVESPA : iFinanceStock;
      FNASDAQ : iFinanceStock;
      FCAC : iFinanceStock;
      FNIKKEI : iFinanceStock;

    public
      constructor Create(Parent : iFinance);
      destructor Destroy; override;
      function GetIBOVESPA : iFinanceStock;
      function GetNASDAQ : iFinanceStock;
      function GetCAC : iFinanceStock;
      function GetNIKKEI : iFinanceStock;
      function SetJSON( value : TJSONObject) : iFinanceStocks;
      function &End : iFinance;
  end;

implementation

uses
  Injection, Finance.Stock;

{ TFinanceStocks }

constructor TFinanceStocks.Create(Parent: iFinance);
begin
  TInjection.Weak(@FParent, Parent);

  FIBOVESPA := TFinanceStock.Create(Self);
  FNASDAQ := TFinanceStock.Create(Self);
  FCAC := TFinanceStock.Create(Self);
  FNIKKEI := TFinanceStock.Create(Self);
end;

destructor TFinanceStocks.Destroy;
begin

  inherited;
end;

function TFinanceStocks.&End: iFinance;
begin
  Result := FParent;
end;

function TFinanceStocks.GetCAC: iFinanceStock;
begin
  Result := FCAC;
end;

function TFinanceStocks.GetIBOVESPA: iFinanceStock;
begin
  Result := FIBOVESPA
end;

function TFinanceStocks.GetNASDAQ: iFinanceStock;
begin
  Result := FNASDAQ;
end;

function TFinanceStocks.GetNIKKEI: iFinanceStock;
begin
  Result := FNIKKEI
end;

function TFinanceStocks.SetJSON(value: TJSONObject): iFinanceStocks;
begin
  Result := Self;
  FIBOVESPA.SetJSON(value.pairs[0]);
  FNASDAQ.SetJSON(value.pairs[1]);
  FCAC.SetJSON(value.pairs[2]);
  FNIKKEI.SetJSON(value.pairs[3]);

end;

end.
