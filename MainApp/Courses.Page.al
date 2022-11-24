page 50100 "CLIP Courses"
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course";
    Caption = 'Courses', Comment = 'ESP="Cursos"';
    CardPageId = "CLIP Course";
    PromotedActionCategories = 'New,Process,Reporting,AName', Comment = 'ESP="Nuevo,Proceso,Informes,UnNombre"';

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
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ShortCutKey = 'Ctrl+F7';
            }
            action(ImportCourses)
            {
                Caption = 'Import Courses', comment = 'ESP="Importar cursos"';
                Image = Import;
                ApplicationArea = All;
                RunObject = xmlport "CLIP Import Courses";
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
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