unit Finance.Taxes;

interface

uses
  Finance.interfaces,
  System.JSON,
  System.Generics.Collections;

type
  TFinanceTaxes = class(TInterfacedObject, iFinanceTaxes)
    private
      FParent : iFinance;
      FDate : String;
      FCdi : string;
      FSelic : string;
      FDailyFactor : string;
      FSelicDaily : string;
      FCdiDaily : string;


    public
      constructor Create(Parent : iFinance);
      destructor Destroy; override;
      function GetDate : string;
      function GetCdi : string;
      function GetSelic : string;
      function GetDailyFactor : string;
      function GetSelicDaily : string;
      function GetCdiDaily : string;
      function SetJSON( value : TJSONArray) : iFinanceTaxes;
      function &End : iFinance;
  end;
implementation

uses
  Injection;

{ TFinanceTaxes }

constructor TFinanceTaxes.Create(Parent: iFinance);
begin
  TInjection.Weak(@FParent, Parent);
end;

destructor TFinanceTaxes.Destroy;
begin

  inherited;
end;

function TFinanceTaxes.&End: iFinance;
begin
  Result := FParent;
end;

function TFinanceTaxes.GetCdi: string;
begin
  Result := FCdi;
end;

function TFinanceTaxes.GetCdiDaily: string;
begin
  Result := FCdiDaily;
end;

function TFinanceTaxes.GetDailyFactor: string;
begin
  Result := FDailyFactor;
end;

function TFinanceTaxes.GetDate: string;
begin
  Result := FDate;
end;

function TFinanceTaxes.GetSelic: string;
begin
  Result := FSelic;
end;

function TFinanceTaxes.GetSelicDaily: string;
begin
  Result := FSelicDaily;
end;

function TFinanceTaxes.SetJSON(value: TJSONArray): iFinanceTaxes;
var
  JSONTaxe : TJSONObject;
begin
  Result := Self;
  JSONTaxe := value.Items[0] as TJSONObject;
  FDate := JSONTaxe.Pairs[0].JsonValue.Value;
  FCdi := JSONTaxe.Pairs[1].JsonValue.Value;
  FSelic := JSONTaxe.Pairs[2].JsonValue.Value;
  FDailyFactor := JSONTaxe.Pairs[3].JsonValue.Value;
  FSelicDaily := JSONTaxe.Pairs[4].JsonValue.Value;
  FCdiDaily := JSONTaxe.Pairs[5].JsonValue.Value;

end;

end.
