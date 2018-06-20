unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,

  Data.FireDACJSONReflect, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FireDAC.Stan.StorageBin;

type
  TForm2 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    memLocal: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    StringGrid2: TStringGrid;
    memDados: TFDMemTable;
    memDadosid: TStringField;
    memDadosdata: TStringField;
    memDadoshora: TStringField;
    memDadosstatus: TStringField;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  ClientModuleUnit1, System.JSON;

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  Dados : TFDJSONDataSets;
  I : Integer;
  lJSON : TJSONValue;
begin
  Dados := ClientModule1.ServerMethods1Client.GetTickets('');
  if TFDJSONDataSetsReader.GetListCount(Dados) = 1 then
  begin
    memLocal.AppendData(TFDJSONDataSetsReader.GetListValue(Dados, 0));
    memLocal.Active := True;

    for I := 0 to Pred(memLocal.FieldCount) do
    begin
      lJSON := TJSONObject.ParseJSONValue(memLocal.Fields[I].AsString);

      memDados.Append;
      memDadosid.Value     := (lJSON as TJSONObject).Values['id'].Value;
      memDadosdata.Value   := (lJSON as TJSONObject).Values['data'].Value;
      memDadoshora.Value   := (lJSON as TJSONObject).Values['hora'].Value;
      memDadosstatus.Value := (lJSON as TJSONObject).Values['status'].Value;
      memDados.Post;
    end;
  end;
end;

end.
