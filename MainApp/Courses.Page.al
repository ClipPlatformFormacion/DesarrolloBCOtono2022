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
            action(ImportCourses)
            {
                Caption = 'Import Courses', comment = 'ESP="Importar cursos"';
                Image = Import;
                ApplicationArea = All;
                RunObject = xmlport "CLIP Import Courses";
            }
        }
        area(Promoted)
        {
            group(Category_Category4)
            {
                Caption = 'AName', Comment = 'ESP="UnNombre"';
                ShowAs = SplitButton;

                actionref(Entries_Promoted; Entries)
                {
                }
                actionref(ImportCourses_Promoted; ImportCourses)
                {
                }
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