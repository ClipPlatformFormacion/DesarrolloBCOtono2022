page 50100 "CLIP Courses"
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course";
    Caption = 'Courses', Comment = 'ESP="Cursos"';
    CardPageId = "CLIP Course";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Duration (hours)"; Rec."Duration (hours)") { ApplicationArea = All; }
                field(Price; Rec.Price) { ApplicationArea = All; }
                field("Language Code"; Rec."Language Code") { ApplicationArea = All; }
            }
        }
        area(FactBoxes)
        {
            part(CourseEditions; "CLIP Course Editions")
            {
                ApplicationArea = All;
                SubPageLink = "Course No." = field("No.");
            }
        }
    }

    views
    {
        view(EnglishCourses)
        {
            Caption = 'English Courses', Comment = 'ESP="Cursos en inglés"';
            Filters = where("Language Code" = filter('ENU'));
        }
    }
}