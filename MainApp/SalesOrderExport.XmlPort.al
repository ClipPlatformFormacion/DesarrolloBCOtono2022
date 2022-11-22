xmlport 50100 "CLIP Sales Order Export"
{
    Caption = 'Sales Order Export', comment = 'ESP="Exportación Pedidos Venta"';
    Direction = Export;
    Format = FixedText;
    RecordSeparator = '<NewLine>';
    FormatEvaluate = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                SourceTableView = where("Document Type" = const(Order));
                fieldelement(Customer; SalesHeader."Sell-to Customer No.")
                {
                    Width = 20;
                }
                fieldelement(No; SalesHeader."No.")
                {
                    Width = 20;
                }
                fieldelement(Date; SalesHeader."Order Date")
                {
                    Width = 10;
                }
                fieldelement(Currency; SalesHeader."Currency Code")
                {
                    Width = 3;
                    trigger OnBeforePassField()
                    var
                        GeneralLedgerSetup: Record "General Ledger Setup";
                    begin
                        if SalesHeader."Currency Code" = '' then begin
                            GeneralLedgerSetup.SetLoadFields("LCY Code");
                            GeneralLedgerSetup.Get();
                            SalesHeader."Currency Code" := GeneralLedgerSetup."LCY Code";
                        end;
                    end;
                }
            }
        }
    }
}