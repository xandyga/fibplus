unit Unit1;
                                                     
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase,
  ExtCtrls, StdCtrls, Grids, DBGrids, EdDataSetInfo;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    db: TpFIBDatabase;
    tr: TpFIBTransaction;
    dt: TpFIBDataSet;
    ds: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    lblRopositoryName: TLabel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'FIBPlus Example - ' + Application.Title;
  db.DBName := 'localhost:' + ExtractFileDir(Application.ExeName) + '\db\employee.fdb';
  db.Connected := True;
  Button1Click(nil);
  //dt.Open;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not db.Connected then Exit;
  db.CloseDataSets;
  db.Close;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('This will end your ' + QuotedStr(Caption) + ' session. Proceed?',
    mtConfirmation, [mbOk, mbCancel], 0) = mrOk;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  dt.Close;
  if not ChooseDSInfo(dt) then Exit;
  lblRopositoryName.Caption := '  ' + dt.Description;
  dt.Open;
end;

end.
