report 50100 "CLIP Course Sales"
{
    Caption = 'Course Sales', comment = 'ESP="Ventas Cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;
    DefaultRenderingLayout = RDLCLayout;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            RequestFilterFields = "No.", "Duration (hours)", Type;
            dataitem("CLIP Course Edition"; "CLIP Course Edition")
            {
                DataItemLink = "Course No." = field("No.");
                DataItemTableView = sorting("Course No.", Edition);

                column(Edition; Edition) { }
                column(Max__Students; "Max. Students") { }
                column(Sales__Qty__; "Sales (Qty.)") { }
            }

            column(No_; Course."No.") { }
            column(Name; Course.Name) { }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    field(Name; AnOption)
                    {
                        Caption = 'An option', comment = 'ESP="Una opción"';
                        ApplicationArea = All;
                    }
                    field(AText; AText)
                    {
                        Caption = 'A text', comment = 'ESP="Un texto"';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            AText := 'Un texto por defecto';
        end;
    }

    rendering
    {
        layout(RDLCLayout)
        {
            Type = RDLC;
            LayoutFile = 'CourseSales.rdl';
        }
        // layout(ExcelLayout)
        // {
        //     Type = Excel;
        //     LayoutFile = 'CourseSales.xlsx';
        // }
        // layout(RDLC2)
        // {
        //     Type = RDLC;
        //     LayoutFile = 'CourseSales2.rdl';
        // }
    }

    var
        AnOption: Boolean;
        AText: Text;
        Counter: Integer;
}