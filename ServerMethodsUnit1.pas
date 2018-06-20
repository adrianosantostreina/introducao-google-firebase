unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,


  Data.FireDACJSONReflect,
  TBGFirebaseConnection.View.Connection;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    MemData: TFDMemTable;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FBGFirebase : TTBGFirebaseConnection;
    procedure GetTicketsFromFirebase(const ATicket: string = '');
  public
    { Public declarations }
    function GetTickets(const ATicket : string = ''): TFDJSONDataSets;
  end;
{$METHODINFO OFF}

implementation

const
  C_BaseURLFirebase = '...';
  C_UUID            = '...';
  C_TICKET          = 'tickets';

{$R *.dfm}


procedure TServerMethods1.DataModuleCreate(Sender: TObject);
begin
  if not Assigned(FBGFirebase) then
    FBGFirebase := TTBGFirebaseConnection.Create;
end;

procedure TServerMethods1.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FBGFirebase) then
    FBGFirebase.Free;
end;

function TServerMethods1.GetTicketS(const ATicket: string): TFDJSONDataSets;
begin
  MemData.Active := False;
  GetTicketsFromFirebase(ATicket);
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, MemData);
end;

procedure TServerMethods1.GetTicketsFromFirebase(const ATicket: string);
begin
  FBGFirebase
    .Connect
      .BaseURL(C_BaseURLFirebase)
      .Auth('anonymous')
      .uId(C_UUID)
    .&End
    .Get
      .DataSet(MemData)
      .Resource(Format('%s/%s', [C_TICKET, ATicket]))
    .&End
    .Exec;
end;


end.

