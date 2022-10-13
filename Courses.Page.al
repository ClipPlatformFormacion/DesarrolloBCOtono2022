page 50100 "CLIP Courses"
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course";
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
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
            CaptionML = ENU = 'English Courses', ESP = 'Cursos en inglés';
            Filters = where("Language Code" = filter('ENU'));
        }
    }
}