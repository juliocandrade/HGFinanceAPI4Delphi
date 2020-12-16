unit Finance.Interfaces;

interface

uses
  System.JSON;

type
  iFinance = interface;
  iFinanceCurrency = interface;
  iFinanceCurrencies = interface;
  iFinanceStocks = interface;
  iFinanceStock = interface;
  iFinanceTaxes = interface;
  iFinanceStockPrice = interface;

  iFinance = interface
    ['{F7B90DC6-31B0-451E-9332-2EBE69DBDC0C}']
    function Key (value : string) : iFinance;
    function Get : iFinance;
    function Currencies : iFinanceCurrencies;
    function Stocks : iFinanceStocks;
    function Taxes : iFinanceTaxes;
  end;

  iFinanceCurrencies = interface
    ['{3E9EC8EF-D002-4485-AE59-A07F7365653B}']
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

  iFinanceCurrency = interface
    ['{1480B557-FA6F-4359-B172-9FE3B2623E84}']
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
    function SetJSON( value : TJSONPair) : iFinanceCurrency;
    function getJSON : TJSONObject;
    function &End : iFinanceCurrencies;
  end;

  iFinanceStocks = interface
    ['{F5D0D24B-5DE7-4D26-A883-7B47D31E48DF}']
    function GetIBOVESPA : iFinanceStock;
    function GetNASDAQ : iFinanceStock;
    function GetCAC : iFinanceStock;
    function GetNIKKEI : iFinanceStock;
    function SetJSON( value : TJSONObject ) : iFinanceStocks;
    function &End : iFinance;
  end;

  iFinanceStock = interface
    ['{E89C283C-133F-42C3-AA99-E15DAAD026B7}']
    function Code : string; overload;
    function Name : string; overload;
    function Location : string; overload;
    function Points : string; overload;
    function Variation : string; overload;
    function Code ( value : string ) : iFinanceStock; overload;
    function Name ( value : string ) : iFinanceStock; overload;
    function Location ( value : string ) : iFinanceStock; overload;
    function Points ( value : string ) : iFinanceStock; overload;
    function Variation ( value : string ) : iFinanceStock; overload;
    function SetJSON( value : TJSONPair ) : iFinanceStock;
    function &End : iFinanceStocks;
  end;

  iFinanceTaxes = interface
    function GetDate : string;
    function GetCdi : string;
    function GetSelic : string;
    function GetDailyFactor : string;
    function GetSelicDaily : string;
    function GetCdiDaily : string;
    function SetJSON( value : TJSONArray ) : iFinanceTaxes;
    function &End : iFinance;
  end;

  iFinanceStockPrice = interface
    function Code : string;
    function Name : string;
    function Price : string;
    function ChangePercent : string;
    function SetJSON( value : TJSONObject ) : iFinanceStockPrice;
    function &End : iFinance;

  end;


implementation

end.
