page 50100 Courses
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Course;
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
    CardPageId = Course;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field(Name; Name) { ApplicationArea = All; }
                field("Duration (hours)"; "Duration (hours)") { ApplicationArea = All; }
                field(Price; Price) { ApplicationArea = All; }
                field("Language Code"; "Language Code") { ApplicationArea = All; }
            }
        }
    }
}