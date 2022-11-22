xmlport 50100 "CLIP Sales Order Export"
{
    Caption = 'Sales Order Export', comment = 'ESP="Exportación Pedidos Venta"';
    Direction = Export;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                SourceTableView = where("Document Type" = const(Order));
                fieldelement(Customer; SalesHeader."Sell-to Customer No.") { }
                fieldelement(No; SalesHeader."No.") { }
                fieldelement(Date; SalesHeader."Order Date") { }
                fieldelement(Currency; SalesHeader."Currency Code") { }


                tableelement(SalesLine; "Sales Line")
                {
                    LinkTable = SalesHeader;
                    LinkFields = "Document Type" = field("Document Type"), "Document No." = field("No.");

                    fieldelement(Type; SalesLine.Type) { }
                    fieldelement(No; SalesLine."No.") { }
                    fieldelement(Quantity; SalesLine.Quantity) { }
                    fieldelement(Price; SalesLine."Unit Price") { }
                    fieldelement(Discount; SalesLine."Line Discount %") { }
                }
            }
        }
    }
}