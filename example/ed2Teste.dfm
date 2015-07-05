object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 180
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 83
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Edit2w1: TEdit2w
    Left = 8
    Top = 56
    Width = 275
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 0
    ADBConnection = SQLConnection1
    ATable = 'CLIENTES'
    AFieldToSearch = 'CLIENTEID;NOME'
    AFieldToResult = 'NOME'
    AConnectionType = 'DBX'
    OnAfterSearch = Edit2w1AfterSearch
  end
  object Button1: TButton
    Left = 208
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2w2: TEdit2w
    Left = 8
    Top = 134
    Width = 275
    Height = 21
    TabOrder = 2
    Text = 'Edit2w2'
    ADBConnection = FDConnection1
    ATable = 'SD_APLICACAO'
    AFieldsToShow = 'COD;APLICACAO'
    AFieldToSearch = 'COD;APLICACAO'
    AFieldToResult = 'COD'
    AConnectionType = 'FDC'
    OnAfterSearch = Edit2w2AfterSearch
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=D:\Projetos\Delphi\Comercial\Database\ComercialDB.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    Left = 40
    Top = 8
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=Flow')
    Left = 136
    Top = 8
  end
end
