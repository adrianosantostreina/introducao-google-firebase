// 
// Created by the DataSnap proxy generator.
// 19/06/2018 14:28:16
// 

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FDataModuleCreateCommand: TDSRestCommand;
    FDataModuleDestroyCommand: TDSRestCommand;
    FGetTicketsCommand: TDSRestCommand;
    FGetTicketsCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function GetTickets(ATicket: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetTickets_Cache(ATicket: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_DataModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TServerMethods1_DataModuleDestroy: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TServerMethods1_GetTickets: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ATicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetTickets_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ATicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

procedure TServerMethods1Client.DataModuleCreate(Sender: TObject);
begin
  if FDataModuleCreateCommand = nil then
  begin
    FDataModuleCreateCommand := FConnection.CreateCommand;
    FDataModuleCreateCommand.RequestType := 'POST';
    FDataModuleCreateCommand.Text := 'TServerMethods1."DataModuleCreate"';
    FDataModuleCreateCommand.Prepare(TServerMethods1_DataModuleCreate);
  end;
  if not Assigned(Sender) then
    FDataModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleCreateCommand.Execute;
end;

procedure TServerMethods1Client.DataModuleDestroy(Sender: TObject);
begin
  if FDataModuleDestroyCommand = nil then
  begin
    FDataModuleDestroyCommand := FConnection.CreateCommand;
    FDataModuleDestroyCommand.RequestType := 'POST';
    FDataModuleDestroyCommand.Text := 'TServerMethods1."DataModuleDestroy"';
    FDataModuleDestroyCommand.Prepare(TServerMethods1_DataModuleDestroy);
  end;
  if not Assigned(Sender) then
    FDataModuleDestroyCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleDestroyCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleDestroyCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleDestroyCommand.Execute;
end;

function TServerMethods1Client.GetTickets(ATicket: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetTicketsCommand = nil then
  begin
    FGetTicketsCommand := FConnection.CreateCommand;
    FGetTicketsCommand.RequestType := 'GET';
    FGetTicketsCommand.Text := 'TServerMethods1.GetTickets';
    FGetTicketsCommand.Prepare(TServerMethods1_GetTickets);
  end;
  FGetTicketsCommand.Parameters[0].Value.SetWideString(ATicket);
  FGetTicketsCommand.Execute(ARequestFilter);
  if not FGetTicketsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetTicketsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetTicketsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetTicketsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetTickets_Cache(ATicket: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetTicketsCommand_Cache = nil then
  begin
    FGetTicketsCommand_Cache := FConnection.CreateCommand;
    FGetTicketsCommand_Cache.RequestType := 'GET';
    FGetTicketsCommand_Cache.Text := 'TServerMethods1.GetTickets';
    FGetTicketsCommand_Cache.Prepare(TServerMethods1_GetTickets_Cache);
  end;
  FGetTicketsCommand_Cache.Parameters[0].Value.SetWideString(ATicket);
  FGetTicketsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetTicketsCommand_Cache.Parameters[1].Value.GetString);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FDataModuleCreateCommand.DisposeOf;
  FDataModuleDestroyCommand.DisposeOf;
  FGetTicketsCommand.DisposeOf;
  FGetTicketsCommand_Cache.DisposeOf;
  inherited;
end;

end.
