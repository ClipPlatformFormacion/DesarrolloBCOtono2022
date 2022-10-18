table 50101 "CLIP Courses Setup"
{
    Caption = 'Courses Setup', Comment = 'ESP="Conf. cursos"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key', Comment = 'ESP="Clave primaria"';
            DataClassification = SystemMetadata;
        }
        field(2; "Course Nos."; Code[20])
        {
            Caption = 'Course Nos.', Comment = 'ESP="Nº Cursos"';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}