reportextension 50100 "CLIP Sales - Shipment" extends "Sales - Shipment"
{
    dataset
    {
        add("Sales Shipment Line")
        {
            column(CLIP_Course_Edition; "CLIP Course Edition") { }
        }
        modify("Sales Shipment Line")
        {

        }
    }

    requestpage
    {
        layout
        {
            modify(NoOfCopies)
            {
                Visible = false;
            }
        }

    }

    rendering
    {
        layout(CLIPLayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }
}