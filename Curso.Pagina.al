page 50101 Course
{
    CaptionML = ENU = 'Course', ESP = 'Curso';
    PageType = Card;
    UsageCategory = None;
    SourceTable = Course;

    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', ESP = 'General';
                field("No."; "No.") { ApplicationArea = All; }
                field(Name; Name) { ApplicationArea = All; }
                field("Duration (hours)"; "Duration (hours)") { ApplicationArea = All; }
                field("Language Code"; "Language Code") { ApplicationArea = All; }
            }
            group(Training)
            {
                CaptionML = ENU = 'Training', ESP = 'Formación';
                field("Content Description"; "Content Description") { ApplicationArea = All; }
                field("Type Option"; "Type Option") { ApplicationArea = All; }
                field(Type; Type) { ApplicationArea = All; }
            }
            group(Invoicing)
            {
                CaptionML = ENU = 'Invoicing', ESP = 'Facturación';
                field(Price; Price) { ApplicationArea = All; }
            }
        }
    }
}