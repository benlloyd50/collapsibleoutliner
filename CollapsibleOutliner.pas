unit CollapsibleOutliner;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    TreeView1: TTreeView;
    AddChildButton: TButton;
    AddSiblingButton: TButton;
    DeleteNodeButton: TButton;
    IndentButton: TButton;
    OutdentButton: TButton;
    procedure AddSiblingButtonClick(Sender: TObject);
    procedure AddChildButtonClick(Sender: TObject);
    procedure DeleteNodeButtonClick(Sender: TObject);
    procedure IndentButtonClick(Sender: TObject);
    procedure OutdentButtonClick(Sender: TObject);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TreeView1Edited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure TreeView1Editing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  IsEditingNode: Boolean = False;

implementation

{$R *.dfm}

procedure TMainForm.TreeView1Editing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
begin
  IsEditingNode := True;
end;

procedure TMainForm.TreeView1Edited(Sender: TObject; Node: TTreeNode; var S: string);
begin
  IsEditingNode := False;
end;

procedure TMainForm.AddChildButtonClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView1.Items.AddChild(TreeView1.Selected, 'New Item');
  Node.Selected := true;
  Node.EditText;
end;

procedure TMainForm.AddSiblingButtonClick(Sender: TObject);
var
  Node : TTreeNode;
begin
  Node := TreeView1.Items.Add(TreeView1.Selected, 'New Item');
  Node.Selected := true;
  Node.EditText;
end;

procedure TMainForm.IndentButtonClick(Sender: TObject);
var
  Node: TTreeNode;
  NewParent: TTreeNode;
  siblingIndex: Integer;
begin
  if not (TreeView1.Items.Count = 0) then
  begin
    Node := TreeView1.Selected;
    siblingIndex := -1;
    NewParent := Node.GetPrevSibling;
    if Assigned(NewParent) then
      siblingIndex := NewParent.AbsoluteIndex
    else
    begin
      NewParent := Node.GetNextSibling;
      if Assigned(NewParent) then
        siblingIndex := NewParent.AbsoluteIndex
      else
        MessageDlg('There is nothing to indent this item beneath!',
          mtInformation, [mbOk], 0);
    end;
    if not(siblingIndex = -1) then
      TreeView1.Selected.MoveTo(TreeView1.Items.Item[siblingIndex],
        naAddChild);
  end;
  TreeView1.SetFocus;
end;

procedure TMainForm.OutdentButtonClick(Sender: TObject);
var
  Node: TTreeNode;
  parentIndex: Integer;
begin
  if not (TreeView1.Items.Count = 0) then
  begin
    Node := TreeView1.Selected;
    parentIndex := -1;
    if Assigned(Node.Parent) then
      parentIndex := Node.Parent.AbsoluteIndex;
    if parentIndex = -1 then
      MessageDlg('This item is already fully outdented!', mtInformation, [mbOk], 0)
    else
      TreeView1.Selected.MoveTo(TreeView1.Items.Item[parentIndex], naAdd);
  end;
  TreeView1.SetFocus;
end;

procedure TMainForm.DeleteNodeButtonClick(Sender: TObject);
var
  index: Integer;
  ok: Boolean;
begin
  ok := True;
  if TreeView1.Items.Count = 0 then
    MessageDlg('No Items in the list silly human!', mtInformation, [mbOk], 0)
  else
  begin
    if TreeView1.Selected.HasChildren then
      if MessageDlg
        ('There are items beneath the selected node. Delete children?',
        mtInformation, [mbYes, mbNo], 0) = mrNo then
          ok := false;
    if ok then
    begin
      index := TreeView1.Selected.AbsoluteIndex - 1;
      TreeView1.Selected.Delete;
      if index >= 0 then
        TreeView1.Items[index].Selected := True;
    end;
    TreeView1.SetFocus;
  end;
end;

procedure TMainForm.TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Node: TTreeNode;
  AttachMode: TNodeAttachMode;
  HT: THitTests;
begin
  if TreeView1.Selected = nil then
    Exit;
  HT:= TreeView1.GetHitTestInfoAt(X, Y);
  Node := TreeView1.GetNodeAt(X, Y);
  if (HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) then
  begin
    if (htOnItem in HT) or (htOnIcon in HT) then
      AttachMode := naAddChild
    else if htNowhere in HT then
      AttachMode := naAdd
    else if htOnIndent in HT then
      AttachMode := naInsert;
    TreeView1.Selected.MoveTo(Node, AttachMode);
  end;
end;

procedure TMainForm.TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  Node: TTreeNode;
begin
  if Key in ['r'] then
  begin
    if (TreeView1.Selected <> nil) and (not IsEditingNode) then
    begin
      Node := TreeView1.Selected;
      Node.EditText;
    end;
  end;
end;

end.
