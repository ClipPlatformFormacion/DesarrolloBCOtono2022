page 50105 "CLIP Action Execution"
{
    Caption = 'Action Execution', comment = 'ESP="Ejecución acciones"';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action(SalesOrderXML)
            {
                Caption = 'Sales Orders XML', comment = 'ESP="XML Pedidos venta"';
                ApplicationArea = All;
                RunObject = xmlport "CLIP Sales Order Export";
                Image = Export;
            }
            action(SimpleItemQuery)
            {
                Caption = 'Item Query', comment = 'ESP="Query Productos"';
                ApplicationArea = All;
                RunObject = query "CLIP Simple Item Query";
                Image = Questionaire;
            }
            action(SimpleItemQuery_AL)
            {
                Caption = 'Item Query AL', comment = 'ESP="Query Productos AL"';
                ApplicationArea = All;
                Image = Questionaire;

                trigger OnAction()
                var
                    SimpleItemQuery: Query "CLIP Simple Item Query";
                    Counter: Integer;
                    ItemNo: Text;
                begin
                    SimpleItemQuery.SetFilter(unitCost, '<50');
                    SimpleItemQuery.SetRange(Replenishment_System, "Replenishment System"::Assembly);
                    SimpleItemQuery.Open();

                    while SimpleItemQuery.Read() do begin
                        Counter += 1;
                        ItemNo := ItemNo + ';' + SimpleItemQuery.no;
                    end;

                    SimpleItemQuery.Close();
                    Message(Format(Counter) + ' ' + ItemNo);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'ESP="Proceso"';
                ShowAs = SplitButton;

                actionref(SalesOrderXML_Promoted; SalesOrderXML)
                {
                }
                actionref(SimpleItemQuery_Promoted; SimpleItemQuery)
                {
                }
                actionref(SimpleItemQuery_AL_Promoted; SimpleItemQuery_AL)
                {
                }
            }
        }
    }
}