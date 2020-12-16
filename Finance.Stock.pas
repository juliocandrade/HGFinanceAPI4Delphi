unit Finance.Stock;

interface

uses
  Finance.interfaces,
  System.JSON;

type
  TFinanceStock = class(TInterfacedObject, iFinanceStock)
    private
      FParent : iFinanceStocks;
      FCode : string;
      FName : string;
      FLocation : string;
      FPoints : string;
      FVariation : string;

    public
      constructor Create (Parent : iFinanceStocks);
      destructor Destroy; override;
      function Code : string; overload;
      function Name : string; overload;
      function Location : string; overload;
      function Points : string; overload;
      function Variation : string; overload;
      function Code (value : string) : iFinanceStock; overload;
      function Name (value : string) : iFinanceStock; overload;
      function Location ( value : string ) : iFinanceStock; overload;
      function Points ( value : string ) : iFinanceStock; overload;
      function Variation (value : string) : iFinanceStock; overload;
      function &End : iFinanceStocks;
      function SetJSON( value : TJSONPair) : iFinanceStock;

  end;

implementation

uses
  Injection;

{ TFinanceStock }

function TFinanceStock.Code: string;
begin
  Result := FCode;
end;

function TFinanceStock.Code(value: string): iFinanceStock;
begin
  Result := Self;
  FCode := value;
end;

constructor TFinanceStock.Create(Parent: iFinanceStocks);
begin
  TInjection.Weak(@FParent, Parent);
end;

destructor TFinanceStock.Destroy;
begin

  inherited;
end;

function TFinanceStock.&End: iFinanceStocks;
begin
  Result := FParent;
end;

function TFinanceStock.Location(value: string): iFinanceStock;
begin
  Result := Self;
  FLocation := value;
end;

function TFinanceStock.Location: string;
begin
  Result := FLocation;
end;

function TFinanceStock.Name: string;
begin
  Result := FName;
end;

function TFinanceStock.Name(value: string): iFinanceStock;
begin
  Result := Self;
  FName := value;
end;

function TFinanceStock.Points(value: string): iFinanceStock;
begin
  Result := Self;
  FPoints := value;
end;

function TFinanceStock.Points: string;
begin
  Result := FPoints;
end;

function TFinanceStock.SetJSON(value: TJSONPair): iFinanceStock;
var
  JSONStock : TJSONObject;
begin
  Result := Self;
  FCode := value.JsonString.Value;
  JSONStock := value.JsonValue as TJSONObject;
  JSONStock.tryGetValue<string>('name', FName);
  JSONStock.tryGetValue<string>('location', FLocation);
  JSONStock.tryGetValue<string>('points', FPoints);
  JSONStock.tryGetValue<string>('variation', FVariation);

end;

function TFinanceStock.Variation(value: string): iFinanceStock;
begin
  Result := Self;
  FVariation := value;
end;

function TFinanceStock.Variation: string;
begin
  Result := FVariation;
end;

end.
