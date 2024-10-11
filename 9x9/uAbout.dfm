object frmAbout: TfrmAbout
  Left = 238
  Top = 90
  BorderStyle = bsDialog
  Caption = 'O programie...'
  ClientHeight = 260
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 24
    Top = 224
    Width = 115
    Height = 13
    Caption = 'Autor: PK'
  end
  object Label3: TLabel
    Left = 184
    Top = 24
    Width = 17
    Height = 13
    Caption = '9x9'
  end
  object Label4: TLabel
    Left = 24
    Top = 112
    Width = 111
    Height = 13
    Caption = 'Rejestr zmodyfikowany:'
  end
  object Label5: TLabel
    Left = 24
    Top = 136
    Width = 82
    Height = 13
    Caption = 'Skr'#243't na pulpicie:'
  end
  object lblRegMod: TLabel
    Left = 155
    Top = 112
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDeskSC: TLabel
    Left = 155
    Top = 136
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
end
