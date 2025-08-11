unit Udisciplinas;

interface

  uses System.Classes, System.SysUtils, System.JSON;

  type TDisciplinas = class (Tobject)

  Private
  FCodigo: integer;
  FNome: String;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;

    function ToLine: string;
    procedure FromLine(ALine: string);

    function ToJSON: TJSONObject;
    procedure FromJSON(AJson: TJSONObject);
  end;

implementation

{ TDisciplinas }

procedure TDisciplinas.FromJSON(AJson: TJSONObject);
var
  CodigoVal: TJSONValue;
  NomeVal: TJSONValue;
begin
  CodigoVal := AJson.GetValue('codigo');
  NomeVal := AJson.GetValue('nome');

  if not Assigned(CodigoVal) or not Assigned(NomeVal) then
    raise Exception.Create('JSON inválido: campos ausentes.');

  try
    Codigo := StrToInt(CodigoVal.Value);
    Nome := NomeVal.Value;
  except
    raise Exception.Create('Erro ao converter dados do JSON.');
  end;

end;

procedure TDisciplinas.FromLine(ALine: string);
var
  Campos: TArray<string>;
begin
  Campos := ALine.Split([';']);
  if Length(Campos) <> 2 then
  raise Exception.Create('Linha inválida');
  Codigo := StrToInt(Campos[0]);
  Nome := Campos[1];
end;

function TDisciplinas.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('codigo', TJSONNumber.Create(Codigo));
  Result.AddPair('nome', Nome);
end;

function TDisciplinas.ToLine: string;
begin
  Result := Format('%d;%s', [Codigo, Nome]);
end;

end.
