unit Finance.StockPrice;

interface

uses
  Finance.interfaces,
  System.JSON,
  System.Generics.Collections;

type
  TFinanceStockPrice = class(TInterfacedObject, iFinanceStockPrice)
    private
      FParent : iFinance;
      FCode : string;
      FName : string;
      FPrice : string;
      FChangePercent : string;

    public
      constructor Create(Parent : iFinance);
      destructor Destroy; override;
      function Code : string;
      function Name : string;
      function Price : string;
      function ChangePercent : string;
      function SetJSON( value : TJSONObject ) : iFinanceStockPrice;
      function &End : iFinance;
end;

implementation

uses
  Injection;

{ TFinanceStockPrice }

function TFinanceStockPrice.ChangePercent: string;
begin
  Result := FChangePercent;
end;

function TFinanceStockPrice.Code: string;
begin
  Result := FCode;
end;

constructor TFinanceStockPrice.Create(Parent: iFinance);
begin
  TInjection.Weak(@FParent, Parent);
end;

destructor TFinanceStockPrice.Destroy;
begin

  inherited;
end;

function TFinanceStockPrice.&End: iFinance;
begin
  Result := FParent;
end;

function TFinanceStockPrice.Name: string;
begin
  Result := FName;
end;

function TFinanceStockPrice.Price: string;
begin
  Result := FPrice;
end;

function TFinanceStockPrice.SetJSON(value: TJSONObject): iFinanceStockPrice;
begin
  Result := Self;
  FCode := value.Pairs[0].JsonString.Value;
  FName := value.Pairs[1].JsonValue.Value;
  FPrice := value.Pairs[10].JsonValue.Value;
  FChangePercent := value.Pairs[11].JsonValue.Value;

end;

end.
