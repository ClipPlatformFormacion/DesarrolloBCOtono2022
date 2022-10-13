page 50101 "CLIP Course"
{
    CaptionML = ENU = 'Course', ESP = 'Curso';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "CLIP Course";

    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', ESP = 'General';
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Duration (hours)"; Rec."Duration (hours)") { ApplicationArea = All; }
                field("Language Code"; Rec."Language Code") { ApplicationArea = All; }
            }
            group(Training)
            {
                CaptionML = ENU = 'Training', ESP = 'Formación';
                field("Content Description"; Rec."Content Description") { ApplicationArea = All; }
                field("Type Option"; Rec."Type Option") { ApplicationArea = All; }
                field(Type; Rec.Type) { ApplicationArea = All; }
            }
            group(Invoicing)
            {
                CaptionML = ENU = 'Invoicing', ESP = 'Facturación';
                field(Price; Rec.Price) { ApplicationArea = All; }
            }
        }
    }
}