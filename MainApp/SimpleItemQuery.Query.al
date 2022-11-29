query 50100 "CLIP Simple Item Query"
{
    Caption = 'Simple Item Query', comment = 'ESP="Consulta simple de producto"';
    QueryType = API;
    APIPublisher = 'clipPlatform';
    APIGroup = 'items';
    APIVersion = 'v2.0';
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';

    elements
    {
        dataitem(Item; Item)
        {
            // DataItemTableFilter = "Replenishment System" = const(Purchase);
            column(no; "No.") { }
            column(description; Description) { }
            column(baseUnitOfMeasure; "Base Unit of Measure") { }
            column(unitCost; "Unit Cost") { }
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