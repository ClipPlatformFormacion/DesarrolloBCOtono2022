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
        }
    }
}