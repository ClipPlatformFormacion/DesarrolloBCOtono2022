report 50100 "CLIP Course Sales"
{
    Caption = 'Course Sales', comment = 'ESP="Ventas Cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;
    DefaultRenderingLayout = ExcelLayout;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            RequestFilterFields = "No.", "Duration (hours)", Type;
            dataitem("CLIP Course Edition"; "CLIP Course Edition")
            {
                DataItemLink = "Course No." = field("No.");
                DataItemTableView = sorting("Course No.", Edition);

                column(Edition; Edition) { IncludeCaption = true; }
                column(Max__Students; "Max. Students") { IncludeCaption = true; }
                column(Sales__Qty__; "Sales (Qty.)") { IncludeCaption = true; }
            }

            column(No_; Course."No.")
            {
                IncludeCaption = true;
            }
            column(Name; Course.Name) { IncludeCaption = true; }
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
        layout(ExcelLayout)
        {
            Type = Excel;
            LayoutFile = 'CourseSales.xlsx';
        }
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