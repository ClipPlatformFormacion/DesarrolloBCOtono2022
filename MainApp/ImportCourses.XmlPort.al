xmlport 50101 "CLIP Import Courses"
{
    Caption = 'Import courses', comment = 'ESP="Importar Cursos"';
    Format = Xml;
    Direction = Import;
    UseRequestPage = false;
    UseDefaultNamespace = true;
    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/ImportCourse';

    schema
    {
        textelement(Root)
        {
            tableelement(Course; "CLIP Course")
            {
                AutoSave = false;

                fieldelement(No; Course."No.") { }
                fieldelement(Name; Course.Name) { }
                fieldelement(Duration; Course."Duration (hours)")
                {
                    trigger OnAfterAssignField()
                    begin
                        Course."Duration (hours)" := Round(Course."Duration (hours)" / 60, 1);
                    end;
                }

                trigger OnBeforeModifyRecord()
                begin
                    DefaultData();

                    Course.Modify();
                end;

                trigger OnBeforeInsertRecord()
                begin
                    DefaultData();

                    Course.Insert();
                end;
            }
        }
    }

    local procedure DefaultData()
    begin
        Course.Validate("Language Code", 'ESP');
        Course.Validate("Gen. Prod. Posting Group", 'SERVICIOS');
        Course.Validate("VAT Prod. Posting Group", 'IVA7');
        Course.Name := 'Desde archivo: ' + Course.Name;
    end;
}