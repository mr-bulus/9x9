object frmNWyniki: TfrmNWyniki
  Left = 222
  Top = 21
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Najlepsze wyniki'
  ClientHeight = 356
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlNWyniki: TPanel
    Left = 0
    Top = 0
    Width = 280
    Height = 356
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object btnZamknij: TButton
      Left = 96
      Top = 304
      Width = 74
      Height = 25
      Caption = 'Zamknij'
      TabOrder = 0
      OnClick = btnZamknijClick
    end
  end
end
