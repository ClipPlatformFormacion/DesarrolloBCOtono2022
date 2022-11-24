query 50100 "CLIP Simple Item Query"
{
    Caption = 'Simple Item Query', comment = 'ESP="Consulta simple de producto"';
    QueryType = Normal;

    elements
    {
        dataitem(Item; Item)
        {
            // DataItemTableFilter = "Replenishment System" = const(Purchase);
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Base_Unit_of_Measure; "Base Unit of Measure") { }
            column(Unit_Cost; "Unit Cost") { }
            filter(Replenishment_System; "Replenishment System")
            {
                ColumnFilter = Replenishment_System = filter(Purchase);
            }
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = Item."Vendor No.";
                SqlJoinType = InnerJoin;
                column(Name; Name) { }
            }
        }
    }
}