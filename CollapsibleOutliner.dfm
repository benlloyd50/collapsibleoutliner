object MainForm: TMainForm
  Left = 485
  Top = 249
  Caption = 'Collapsible Outliner'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object TreeView1: TTreeView
    Left = 8
    Top = 8
    Width = 612
    Height = 377
    DragMode = dmAutomatic
    Indent = 19
    TabOrder = 0
    OnDragDrop = TreeView1DragDrop
    OnDragOver = TreeView1DragOver
    OnEdited = TreeView1Edited
    OnEditing = TreeView1Editing
  end
  object AddChildButton: TButton
    Left = 98
    Top = 401
    Width = 75
    Height = 25
    Caption = 'Add Child'
    TabOrder = 1
    OnClick = AddChildButtonClick
  end
  object AddSiblingButton: TButton
    Left = 17
    Top = 401
    Width = 75
    Height = 25
    Caption = 'Add Sibling'
    TabOrder = 2
    OnClick = AddSiblingButtonClick
  end
  object DeleteNodeButton: TButton
    Left = 192
    Top = 401
    Width = 97
    Height = 25
    Caption = 'Delete Selected'
    TabOrder = 3
    OnClick = DeleteNodeButtonClick
  end
  object IndentButton: TButton
    Left = 536
    Top = 401
    Width = 75
    Height = 25
    Caption = 'Indent >'
    TabOrder = 4
    OnClick = IndentButtonClick
  end
  object OutdentButton: TButton
    Left = 455
    Top = 401
    Width = 75
    Height = 25
    Caption = '< Outdent'
    TabOrder = 5
    OnClick = OutdentButtonClick
  end
end
