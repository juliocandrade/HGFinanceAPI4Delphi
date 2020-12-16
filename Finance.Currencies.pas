unit Finance.Currencies;

interface

uses
  Finance.interfaces,
  System.JSON;

type
  TFinanceCurrencies = class(TInterfacedObject, iFinanceCurrencies)
    private
      FParent : iFinance;
      FSource : string;
      FUSD : iFinanceCurrency;
      FEUR : iFinanceCurrency;
      FGBP : iFinanceCurrency;
      FARS : iFinanceCurrency;
      FCAD : iFinanceCurrency;
      FAUD : iFinanceCurrency;
      FJPY : iFinanceCurrency;
      FCNY : iFinanceCurrency;
      FBTC : iFinanceCurrency;

    public
      constructor Create(Parent : iFinance);
      destructor Destroy; override;
      function Source : string; overload;
      function Source(value : string) : iFinanceCurrencies; overload;
      function GetUSD : iFinanceCurrency;
      function GetEUR : iFinanceCurrency;
      function GetGBP : iFinanceCurrency;
      function GetARS : iFinanceCurrency;
      function GetCAD : iFinanceCurrency;
      function GetAUD : iFinanceCurrency;
      function GetJPY : iFinanceCurrency;
      function GetCNY : iFinanceCurrency;
      function GetBTC : iFinanceCurrency;
      function SetJSON( value : TJSONObject) : iFinanceCurrencies;
      function GetJSONArray : TJSONArray;
      function &End : iFinance;

  end;

implementation

uses
  Injection,
  Finance.Currency,
  System.Generics.Collections;

{ TFinanceCurrencies }

constructor TFinanceCurrencies.Create(Parent: iFinance);
begin
  TInjection.Weak(@FParent, Parent);

  FUSD := TFinanceCurrency.Create(Self);
  FEUR := TFinanceCurrency.Create(Self);
  FGBP := TFinanceCurrency.Create(Self);
  FARS := TFinanceCurrency.Create(Self);
  FCAD := TFinanceCurrency.Create(Self);
  FAUD := TFinanceCurrency.Create(Self);
  FJPY := TFinanceCurrency.Create(Self);
  FCNY := TFinanceCurrency.Create(Self);
  FBTC := TFinanceCurrency.Create(Self);
end;

destructor TFinanceCurrencies.Destroy;
begin

  inherited;
end;

function TFinanceCurrencies.&End: iFinance;
begin
  Result := FParent;
end;

function TFinanceCurrencies.GetARS: iFinanceCurrency;
begin
  Result := FARS;
end;

function TFinanceCurrencies.GetAUD: iFinanceCurrency;
begin
  Result := FAUD;
end;

function TFinanceCurrencies.GetBTC: iFinanceCurrency;
begin
  Result := FBTC;
end;

function TFinanceCurrencies.GetCAD: iFinanceCurrency;
begin
  Result := FCAD;
end;

function TFinanceCurrencies.GetCNY: iFinanceCurrency;
begin
  Result := FCNY;
end;

function TFinanceCurrencies.GetEUR: iFinanceCurrency;
begin
  Result := FEUR;
end;

function TFinanceCurrencies.GetGBP: iFinanceCurrency;
begin
  Result := FGBP;
end;

function TFinanceCurrencies.GetJPY: iFinanceCurrency;
begin
  Result := FJPY;
end;

function TFinanceCurrencies.GetJSONArray: TJSONArray;
var
  JSONArray : TJSONArray;
begin
  JSONArray := TJSONArray.Create;
  JSONArray.AddElement(FUSD.getJSON);
  JSONArray.AddElement(FEUR.getJSON);
  JSONArray.AddElement(FGBP.getJSON);
  JSONArray.AddElement(FARS.getJSON);
  JSONArray.AddElement(FCAD.getJSON);
  JSONArray.AddElement(FAUD.getJSON);
  JSONArray.AddElement(FJPY.getJSON);
  JSONArray.AddElement(FCNY.getJSON);
  JSONArray.AddElement(FBTC.getJSON);
  Result := JSONArray;
end;

function TFinanceCurrencies.GetUSD: iFinanceCurrency;
begin
  Result := FUSD;
end;

function TFinanceCurrencies.SetJSON(value: TJSONObject): iFinanceCurrencies;
begin
  Result := Self;
  FSource := value.pairs[0].JsonValue.Value;
  FUSD.SetJSON(value.pairs[1]);
  FEUR.SetJSON(value.pairs[2]);
  FGBP.SetJSON(value.pairs[3]);
  FARS.SetJSON(value.pairs[4]);
  FCAD.SetJSON(value.pairs[5]);
  FAUD.SetJSON(value.pairs[6]);
  FJPY.SetJSON(value.pairs[7]);
  FCNY.SetJSON(value.pairs[8]);
  FBTC.SetJSON(value.pairs[9]);

end;

function TFinanceCurrencies.Source(value: string): iFinanceCurrencies;
begin
  Result := Self;
  FSource := value;
end;

function TFinanceCurrencies.Source: string;
begin
  Result := FSource;
end;

end.
