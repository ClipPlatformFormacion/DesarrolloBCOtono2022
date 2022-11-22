xmlport 50100 "CLIP Sales Order Export"
{
    Caption = 'Sales Order Export', comment = 'ESP="Exportación Pedidos Venta"';
    Direction = Export;
    Format = VariableText;
    FieldSeparator = ';';
    FieldDelimiter = '';
    RecordSeparator = '<NewLine>';
    FormatEvaluate = Xml;

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
                fieldelement(Currency; SalesHeader."Currency Code")
                {
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