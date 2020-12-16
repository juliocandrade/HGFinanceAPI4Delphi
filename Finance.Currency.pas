unit Finance.Currency;

interface

uses
  Finance.interfaces,
  System.JSON;

type
  TFinanceCurrency = class(TInterfacedObject, iFinanceCurrency)
    private
      FParent : iFinanceCurrencies;
      FCode : string;
      FName : string;
      FBuy : string;
      FSell : string;
      FVariation : string;

    public
      constructor Create (Parent : iFinanceCurrencies);
      destructor Destroy; override;
      function Code : string; overload;
      function Name : string; overload;
      function Buy : string; overload;
      function Sell : string; overload;
      function Variation : string; overload;
      function Code (value : string) : iFinanceCurrency; overload;
      function Name (value : string) : iFinanceCurrency; overload;
      function Buy (value : string) : iFinanceCurrency; overload;
      function Sell (value : string) : iFinanceCurrency; overload;
      function Variation (value : string) : iFinanceCurrency; overload;
      function &End : iFinanceCurrencies;
      function SetJSON( value : TJSONPair) : iFinanceCurrency;
      function getJSON : TJSONObject;
  end;

implementation

uses
  Injection,
  System.Generics.Collections;

{ TFinanceCurrency }

function TFinanceCurrency.Buy: string;
begin
  Result := FBuy;
end;

function TFinanceCurrency.Buy(value: string): iFinanceCurrency;
begin
  Result := Self;
  FBuy := value;
end;

function TFinanceCurrency.Code(value: string): iFinanceCurrency;
begin
  Result := Self;
  FCode := value;
end;

function TFinanceCurrency.Code: string;
begin
  Result := FCode;
end;

constructor TFinanceCurrency.Create(Parent: iFinanceCurrencies);
begin
  TInjection.Weak(@FParent, Parent);
end;

destructor TFinanceCurrency.Destroy;
begin

  inherited;
end;

function TFinanceCurrency.&End: iFinanceCurrencies;
begin
  Result := FParent;
end;

function TFinanceCurrency.getJSON: TJSONObject;
var
  JSONObject : TJSONObject;
begin
  JSONObject := TJSONObject.Create;
  JSONObject.AddPair( 'Code', TJSONString.Create(FCode));
  JSONObject.AddPair( 'Name', TJSONString.Create(FName));
  JSONObject.AddPair( 'Buy', TJSONString.Create(FBuy));
  JSONObject.AddPair( 'Sell', TJSONString.Create(FSell));
  JSONObject.AddPair( 'Variation', TJSONString.Create(FVariation));
  Result := JSONObject;
end;

function TFinanceCurrency.Name(value: string): iFinanceCurrency;
begin
  Result := Self;
  FName := value;
end;

function TFinanceCurrency.Name: string;
begin
  Result := FName;
end;

function TFinanceCurrency.Sell(value: string): iFinanceCurrency;
begin
  Result := Self;
  FSell := value;
end;

function TFinanceCurrency.SetJSON(value: TJSONPair): iFinanceCurrency;
var
  JSONCurrency : TJSONObject;
begin
  Result := Self;
  FCode := value.JsonString.Value;
  JSONCurrency := value.JsonValue as TJSONObject;
  FName := JSONCurrency.Pairs[0].JsonValue.Value;
  FBuy := JSONCurrency.Pairs[1].JsonValue.Value;
  FSell := JSONCurrency.Pairs[2].JsonValue.Value;
  FVariation := JSONCurrency.Pairs[3].JsonValue.Value;
end;

function TFinanceCurrency.Sell: string;
begin
  Result := FSell;
end;

function TFinanceCurrency.Variation(Value: string): iFinanceCurrency;
begin
  Result := Self;
  FVariation := Value
end;

function TFinanceCurrency.Variation: string;
begin
  Result := FVariation;
end;

end.
