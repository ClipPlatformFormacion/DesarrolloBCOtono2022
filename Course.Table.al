table 50100 "CLIP Course"
{
    Caption = 'Course', Comment = 'ESP="Curso"';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ESP="Nº"';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CoursesSetup.Get();
                    NoSeriesManagement.TestManual(CoursesSetup."Course Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
        }
        field(3; "Content Description"; Text[2048])
        {
            Caption = 'Content Description', Comment = 'ESP="Descripción contenido"';
        }
        field(4; "Duration (hours)"; Integer)
        {
            Caption = 'Duration (hours)', Comment = 'ESP="Duración (horas)"';
        }
        field(5; Price; Decimal)
        {
            Caption = 'Price', Comment = 'ESP="Precio"';
        }
        field(6; "Language Code"; Code[10])
        {
            Caption = 'Language Code', Comment = 'ESP="Cód. idioma"';
            TableRelation = Language;
        }
        field(7; "Type Option"; Option)
        {
            Caption = 'Type Option', Comment = 'ESP="Tipo option"';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            OptionCaption = ' ,Instructor-Lead,Video Tutorial', Comment = 'ESP=" ,Guiado,Vídeo tutorial"';
        }
        field(8; Type; Enum "CLIP Course Type")
        {
            Caption = 'Type', Comment = 'ESP="Tipo"';
        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.") { }
    }

    trigger OnInsert()
    begin
        if Rec."No." = '' then begin
            CoursesSetup.Get();
            CoursesSetup.TestField("Course Nos.");
            NoSeriesManagement.InitSeries(CoursesSetup."Course Nos.", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
        end;
    end;

    var
        CoursesSetup: Record "CLIP Courses Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
}