object frm9x9: Tfrm9x9
  Left = 114
  Top = 4
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '9x9'
  ClientHeight = 564
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 20
    Top = 60
    Width = 484
    Height = 484
  end
  object spbnStart: TSpeedButton
    Left = 525
    Top = 321
    Width = 97
    Height = 33
    GroupIndex = 1
    Caption = 'Start'
    OnClick = spbnStartClick
  end
  object spbnZamknij: TSpeedButton
    Left = 525
    Top = 361
    Width = 97
    Height = 33
    Action = actClose
  end
  object GroupBox1: TGroupBox
    Left = 512
    Top = 60
    Width = 121
    Height = 57
    Caption = 'Tw'#243'j wynik'
    TabOrder = 0
    object lblWynik: TLabel
      Left = 16
      Top = 24
      Width = 12
      Height = 18
      Caption = '0'
      Font.Charset = OEM_CHARSET
      Font.Color = clTeal
      Font.Height = -19
      Font.Name = 'Terminal'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 512
    Top = 148
    Width = 121
    Height = 117
    Caption = 'Punktacja'
    TabOrder = 1
    object lblScBlue: TLabel
      Left = 8
      Top = 16
      Width = 6
      Height = 13
      Caption = '1'
    end
    object lblScBrown: TLabel
      Left = 8
      Top = 32
      Width = 6
      Height = 13
      Caption = '2'
    end
    object lblScGreen: TLabel
      Left = 8
      Top = 48
      Width = 6
      Height = 13
      Caption = '3'
    end
    object lblScRed: TLabel
      Left = 8
      Top = 64
      Width = 6
      Height = 13
      Caption = '4'
    end
    object lblScViolet: TLabel
      Left = 8
      Top = 80
      Width = 6
      Height = 13
      Caption = '5'
    end
    object lblScYellow: TLabel
      Left = 8
      Top = 96
      Width = 6
      Height = 13
      Caption = '6'
    end
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 24
    object Ustawienia1: TMenuItem
      Caption = 'Ustawienia'
      object mitemTray: TMenuItem
        Caption = 'Minimalizuj do ikony'
        OnClick = mitemTrayClick
      end
      object mitemSkrot: TMenuItem
        Caption = 'Skr'#243't na pulpicie'
        OnClick = mitemSkrotClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
    end
    object Najlepszewyniki1: TMenuItem
      Caption = 'Najlepsze wyniki'
      OnClick = Najlepszewyniki1Click
    end
    object Oprogramie1: TMenuItem
      Action = actAbout
    end
  end
  object PopupMenu1: TPopupMenu
    BiDiMode = bdRightToLeft
    OwnerDraw = True
    ParentBiDiMode = False
    TrackButton = tbLeftButton
    Left = 64
    Top = 24
    object Oprogramie2: TMenuItem
      Action = actAbout
    end
    object Zamknij1: TMenuItem
      Action = actClose
    end
  end
  object ActionList1: TActionList
    Left = 96
    Top = 24
    object actAbout: TAction
      Caption = 'O programie'
      OnExecute = actAboutExecute
    end
    object actClose: TAction
      Caption = 'Zamknij'
      OnExecute = actCloseExecute
    end
  end
end
