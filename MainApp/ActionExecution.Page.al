page 50105 "CLIP Action Execution"
{
    Caption = 'Action Ececution', comment = 'ESP="Ejecución acciones"';
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
            }
            action(SimpleItemQuery)
            {
                Caption = 'Item Query', comment = 'ESP="Query Productos"';
                ApplicationArea = All;
                RunObject = query "CLIP Simple Item Query";
                Image = Questionaire;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
            }
            action(SimpleItemQuery_AL)
            {
                Caption = 'Item Query AL', comment = 'ESP="Query Productos AL"';
                ApplicationArea = All;
                Image = Questionaire;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SimpleItemQuery: Query "CLIP Simple Item Query";
                    Counter: Integer;
                    ItemNo: Text;
                begin
                    SimpleItemQuery.SetFilter(Unit_Cost, '<50');
                    SimpleItemQuery.SetRange(Replenishment_System, "Replenishment System"::Assembly);
                    SimpleItemQuery.Open();

                    while SimpleItemQuery.Read() do begin
                        Counter += 1;
                        ItemNo := ItemNo + ';' + SimpleItemQuery.No_;
                    end;

                    SimpleItemQuery.Close();
                    Message(Format(Counter) + ' ' + ItemNo);
                end;
            }
        }
    }
}