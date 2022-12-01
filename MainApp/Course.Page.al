page 50101 "CLIP Course"
{
    Caption = 'Course', Comment = 'ESP="Curso"';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "CLIP Course";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ESP="General"';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Identifiable course code', Comment = 'ESP="Código identificativo del curso"';
                }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Duration (hours)"; Rec."Duration (hours)") { ApplicationArea = All; }
                field("Language Code"; Rec."Language Code") { ApplicationArea = All; }
            }
            group(Training)
            {
                Caption = 'Training', Comment = 'ESP="Formación"';
                field("Content Description"; Rec."Content Description") { ApplicationArea = All; }
                field("Type Option"; Rec."Type Option") { ApplicationArea = All; }
                field(Type; Rec.Type) { ApplicationArea = All; }
            }
            part(CourseEditions; "CLIP Course Editions")
            {
                ApplicationArea = All;
                SubPageLink = "Course No." = field("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'ESP="Facturación"';
                field(Price; Rec.Price) { ApplicationArea = All; }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Jobs;
                    Importance = Promoted;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.', Comment = 'ESP="Especifica el tipo de curso para vincular las transacciones realizadas para este curso con la cuenta de contabilidad correspondiente según la configuración de registro general."';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.', Comment = 'ESP="Indica la especificación de IVA del curso en cuestión para vincular las transacciones realizadas para este registro con la cuenta de contabilidad general adecuada según la configuración de grupos de registro."';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Entries)
            {
                Caption = 'Ledger Entries', comment = 'ESP="Movimientos"';
                Image = ResourceLedger;
                ApplicationArea = All;
                RunObject = page "CLIP Course Ledger Entries";
                RunPageLink = "Course No." = field("No.");
                ShortCutKey = 'Ctrl+F7';
            }
        }
        area(Promoted)
        {
            group(Category_Category4)
            {
                Caption = 'Related', Comment = 'ESP="Relacionado"';

                actionref(Entries_Promoted; Entries)
                {
                }
            }
        }
    }
}