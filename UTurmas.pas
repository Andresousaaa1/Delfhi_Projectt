unit UTurmas;

interface

  uses System.Classes, System.SysUtils, System.JSON;

  type TTurmas = class (Tobject)

  Private
  FCodigo: integer;
  FCodProf: integer;
  FCodDis: integer;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property CodProf: Integer read FCodProf write FCodProf;
    property CodDis: Integer read FCodDis write FCodDis;

    function ToLine: string;
    procedure FromLine(ALine: string);

    function ToJSON: TJSONObject;
    procedure FromJSON(AJson: TJSONObject);
  end;

implementation

{ TDisciplinas }

procedure TTurmas.FromJSON(AJson: TJSONObject);
var
  CodigoVal: TJSONValue;
  CodProfVal: TJSONValue;
  CodDisVal: TJSONValue;
begin
  CodigoVal := AJson.GetValue('codigo');
  CodProfVal := AJson.GetValue('codprof');
  CodDisVal := AJson.GetValue('codDis');

  if (not Assigned(CodigoVal)) or (not Assigned (CodProfVal)) or (not Assigned(CodDisVal)) then
    raise Exception.Create('JSON invalido: campos ausentes.');

  try
    Codigo := StrToInt(CodigoVal.Value);
    CodProf := StrToInt(CodProfVal.Value);
    CodDis := StrToInt(CodDisVal.Value);
  except
    raise Exception.Create('Erro ao converter dados do JSON.');
  end;

end;

procedure TTurmas.FromLine(ALine: string);
var
  Campos: TArray<string>;
begin
  Campos := ALine.Split([';']);
  if Length(Campos) <> 3 then
  raise Exception.Create('Linha inválida');
  Codigo := StrToInt(Campos[0]);
  CodProf := StrToInt(Campos[1]);
  CodDis := StrToInt(Campos[1]);
end;

function TTurmas.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('codigo', TJSONNumber.Create(Codigo));
  Result.AddPair('codprof', CodProf);
  Result.AddPair('CodDis', CodDis);
end;

function TTurmas.ToLine: string;
begin
  Result := Format('%d;%d;%d', [Codigo, CodProf, CodDis]);
end;

end.
