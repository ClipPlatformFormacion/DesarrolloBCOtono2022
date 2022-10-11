page 50100 Courses
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Course;
    CaptionML = ENU = 'Courses', ESP = 'Cursos';

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field(Name; Name) { ApplicationArea = All; }
                field("Content Description"; "Content Description") { ApplicationArea = All; }
                field("Duration (hours)"; "Duration (hours)") { ApplicationArea = All; }
                field(Price; Price) { ApplicationArea = All; }
                field("Language Code"; "Language Code") { ApplicationArea = All; }
                field("Type Option"; "Type Option") { ApplicationArea = All; }
                field(Type; Type) { ApplicationArea = All; }
            }
        }
    }
}