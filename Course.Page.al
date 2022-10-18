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
            }
        }
    }
}