page 50104 "CLIP Course Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Course Ledger Entries', Comment = 'ESP="Movs. curso"';
    DataCaptionFields = "Course No.";
    Editable = false;
    PageType = List;
    SourceTable = "CLIP Course Ledger Entry";
    SourceTableView = SORTING("Course No.", "Posting Date")
                      ORDER(Descending);
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(RepeaterControl)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {

                    ToolTip = 'Specifies the date when the entry was posted.';
                }
                field("Document No."; Rec."Document No.")
                {

                    ToolTip = 'Specifies the document number on the Course ledger entry.';
                }
                field("Course No."; Rec."Course No.")
                {

                    ToolTip = 'Specifies the number of the Course.';
                }
                field("Course Edition"; Rec."Course Edition")
                {

                }
                field(Description; Rec.Description)
                {

                    ToolTip = 'Specifies the description of the posted entry.';
                }
                field(Quantity; Rec.Quantity)
                {

                    ToolTip = 'Specifies the number of units of the item or Course specified on the line.';
                }
                field("Unit Price"; Rec."Unit Price")
                {

                    ToolTip = 'Specifies the price of one unit of the item or Course. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                    Visible = false;
                }
                field("Total Price"; Rec."Total Price")
                {

                    ToolTip = 'Specifies the total price of the posted entry.';
                }
                field("Entry No."; Rec."Entry No.")
                {

                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Navigate")
            {
                Caption = 'Find entries...', Comment = 'ESP="Buscar movs..."';
                Image = Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run();
                end;
            }
        }
        area(Promoted)
        {
            actionref("&Navigate_Promoted"; "&Navigate")
            {
            }
        }
    }

    var
        Navigate: Page Navigate;
}

